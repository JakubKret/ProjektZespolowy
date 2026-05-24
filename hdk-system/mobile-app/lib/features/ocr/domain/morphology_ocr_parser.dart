class OcrTextLine {
  final String text;
  final double top;
  final double bottom;

  const OcrTextLine({
    required this.text,
    required this.top,
    required this.bottom,
  });

  double get centerY => (top + bottom) / 2;
}

class OcrEntry {
  String label;
  double value;
  String? unit;

  OcrEntry({required this.label, required this.value, this.unit});

  String? get dbColumn => _labelToColumn[_normalizeLabel(label)];

  static String _normalizeLabel(String label) {
    return label
        .toLowerCase()
        .replaceAll(RegExp(r'\(.*?\)'), '')
        .trim();
  }

  static const _labelToColumn = <String, String>{
    'hemoglobina': 'hgbGDl',
    'hgb': 'hgbGDl',
    'hematokryt': 'hctPct',
    'hct': 'hctPct',
    'erytrocyty': 'rbcMlnUl',
    'krwinki czerwone': 'rbcMlnUl',
    'rbc': 'rbcMlnUl',
    'mcv': 'mcvFl',
    'mch': 'mchPg',
    'mchc': 'mchcGDl',
    'rdw': 'rdwPct',
    'leukocyty': 'wbcTysUl',
    'krwinki białe': 'wbcTysUl',
    'krwinki biale': 'wbcTysUl',
    'wbc': 'wbcTysUl',
    'neutrofile': 'neutPct',
    'neut': 'neutPct',
    'limfocyty': 'lymphPct',
    'lymph': 'lymphPct',
    'monocyty': 'monoPct',
    'mono': 'monoPct',
    'eozynofile': 'eosPct',
    'eos': 'eosPct',
    'bazofile': 'basoPct',
    'baso': 'basoPct',
    'płytki krwi': 'pltTysUl',
    'plytki krwi': 'pltTysUl',
    'plt': 'pltTysUl',
    'trombocyty': 'pltTysUl',
    'mpv': 'mpvFl',
    'żelazo': 'feUgDl',
    'zelazo': 'feUgDl',
    'fe': 'feUgDl',
    'ferrytyna': 'ferritinNgMl',
    'ferritin': 'ferritinNgMl',
    'ferritina': 'ferritinNgMl',
  };
}

class OcrDiscoveryResult {
  final List<OcrEntry> entries;
  final String rawText;

  const OcrDiscoveryResult({required this.entries, this.rawText = ''});

  bool get hasAnyValue => entries.isNotEmpty;
}

class MorphologyOcrParser {
  static OcrDiscoveryResult parseWithPositions(List<OcrTextLine> ocrLines) {
    final rawText = ocrLines.map((l) => l.text).join('\n');
    if (ocrLines.isEmpty) {
      return OcrDiscoveryResult(entries: [], rawText: rawText);
    }

    final rows = _groupIntoRows(ocrLines);
    final entries = <OcrEntry>[];

    for (final row in rows) {
      final entry = _extractEntryFromRow(row);
      if (entry != null) entries.add(entry);
    }

    _deduplicateEntries(entries);
    return OcrDiscoveryResult(entries: entries, rawText: rawText);
  }

  static OcrDiscoveryResult parse(String fullText) {
    final lines = fullText
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    if (lines.isEmpty) {
      return OcrDiscoveryResult(entries: [], rawText: fullText);
    }

    final entries = <OcrEntry>[];

    for (var i = 0; i < lines.length; i++) {
      final entry = _extractEntryFromText(lines[i]);
      if (entry != null) {
        entries.add(entry);
        continue;
      }

      final label = _extractLabelOnly(lines[i]);
      if (label != null && i + 1 < lines.length) {
        final value = _extractFirstNumber(lines[i + 1]);
        if (value != null) {
          final unit = _extractUnit(lines[i + 1], value);
          entries.add(OcrEntry(label: label, value: value, unit: unit));
        }
      }
    }

    _deduplicateEntries(entries);
    return OcrDiscoveryResult(entries: entries, rawText: fullText);
  }

  // -- Row grouping by Y coordinate --

  static List<List<OcrTextLine>> _groupIntoRows(List<OcrTextLine> lines) {
    if (lines.isEmpty) return [];

    final sorted = List<OcrTextLine>.from(lines)
      ..sort((a, b) => a.centerY.compareTo(b.centerY));

    final rows = <List<OcrTextLine>>[];
    var currentRow = <OcrTextLine>[sorted.first];

    for (var i = 1; i < sorted.length; i++) {
      final line = sorted[i];
      final rowAnchor = currentRow.first;
      final threshold = (rowAnchor.bottom - rowAnchor.top) * 1.0;

      if ((line.centerY - rowAnchor.centerY).abs() <= threshold) {
        currentRow.add(line);
      } else {
        rows.add(currentRow);
        currentRow = [line];
      }
    }
    rows.add(currentRow);
    return rows;
  }

  // -- Entry extraction from a spatial row --

  static OcrEntry? _extractEntryFromRow(List<OcrTextLine> row) {
    for (final line in row) {
      final inline = _extractEntryFromText(line.text);
      if (inline != null) return inline;
    }

    String? label;
    double? value;
    String? unit;

    for (final line in row) {
      final text = line.text.trim();
      if (text.isEmpty) continue;

      if (_isRangeText(text) || _isHeaderText(text)) continue;

      final num = _extractFirstNumber(text);
      if (num != null && _isStandaloneNumber(text)) {
        value ??= num;
      } else if (_isPlausibleLabel(text) && !_isUnitText(text)) {
        label ??= _cleanLabel(text);
      } else if (_isUnitText(text)) {
        unit ??= text.trim();
      }
    }

    if (label == null || value == null) return null;
    return OcrEntry(label: label, value: value, unit: unit);
  }

  // -- Entry extraction from a single text line --

  static OcrEntry? _extractEntryFromText(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return null;

    final match = _labelValuePattern.firstMatch(trimmed);
    if (match == null) return null;

    final rawLabel = match.group(1)!.trim();
    if (!_isPlausibleLabel(rawLabel)) return null;
    if (_isHeaderText(rawLabel)) return null;

    final rawNumber = match.group(2)!.replaceAll(',', '.');
    final value = double.tryParse(rawNumber);
    if (value == null) return null;

    final afterNumber = trimmed.substring(match.end).trim();
    final unit = _extractUnitFromAfter(afterNumber);

    return OcrEntry(
      label: _cleanLabel(rawLabel),
      value: value,
      unit: unit,
    );
  }

  static String? _extractLabelOnly(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return null;
    if (_numberPattern.hasMatch(trimmed)) return null;
    if (!_isPlausibleLabel(trimmed)) return null;
    if (_isHeaderText(trimmed)) return null;
    return _cleanLabel(trimmed);
  }

  // -- Helpers --

  static final _labelValuePattern = RegExp(
    r'([a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\s\(\)]+?)\s+(\d+[.,]\d+|\d+)',
  );

  static final _numberPattern = RegExp(r'(\d+[.,]\d+|\d+)');

  static final _unitPattern = RegExp(
    r'^[a-zA-Zµ×%/³⁶\d]+[a-zA-Zµ×%/³⁶\d/]*$',
  );

  static final _rangePattern = RegExp(
    r'(\d+[.,]?\d*)\s*[—–\-]\s*(\d+[.,]?\d*)',
  );

  static final _headerWords = {
    'hematologia', 'nazwa', 'wynik', 'badania', 'zakres',
    'referencyjny', 'jednostka', 'norma', 'materiał', 'material',
    'data', 'laboratorium', 'pacjent', 'pesel', 'lekarz',
    'morfologia', 'krwi', 'parametr',
  };

  static double? _extractFirstNumber(String text) {
    final cleaned = text.trim();
    if (cleaned.isEmpty) return null;
    final match = _numberPattern.firstMatch(cleaned);
    if (match == null) return null;
    final raw = match.group(1)!.replaceAll(',', '.');
    return double.tryParse(raw);
  }

  static String? _extractUnit(String text, double value) {
    final valStr = _numberPattern.firstMatch(text.trim());
    if (valStr == null) return null;
    final after = text.substring(valStr.end).trim();
    return _extractUnitFromAfter(after);
  }

  static String? _extractUnitFromAfter(String after) {
    if (after.isEmpty) return null;
    final parts = after.split(RegExp(r'\s+'));
    final candidate = parts.first;
    if (_rangePattern.hasMatch(candidate)) return null;
    if (double.tryParse(candidate.replaceAll(',', '.')) != null) return null;
    if (candidate.length > 15) return null;
    if (_unitPattern.hasMatch(candidate) || candidate.contains('/')) {
      return candidate;
    }
    return null;
  }

  static bool _isStandaloneNumber(String text) {
    final trimmed = text.trim();
    if (_rangePattern.hasMatch(trimmed)) return false;
    final match = _numberPattern.firstMatch(trimmed);
    if (match == null) return false;
    final before = trimmed.substring(0, match.start).trim();
    if (before.isNotEmpty && RegExp(r'[a-zA-Z]').hasMatch(before)) return false;
    return true;
  }

  static bool _isRangeText(String text) {
    return _rangePattern.hasMatch(text.trim());
  }

  static bool _isUnitText(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return false;
    if (trimmed.length > 10) return false;
    if (trimmed.contains('/') ||
        trimmed.contains('µ') ||
        trimmed.contains('×') ||
        trimmed == '%') {
      return true;
    }
    const knownUnits = {
      'fl', 'pg', 'ml', 'dl', 'mg', 'ng', 'ug', 'ul', 'l',
      'mmol', 'umol', 'g', 'kg', 'iu',
    };
    return knownUnits.contains(trimmed.toLowerCase());
  }

  static bool _isPlausibleLabel(String text) {
    final trimmed = text.trim();
    if (trimmed.length < 2) return false;
    if (!RegExp(r'[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ]').hasMatch(trimmed)) {
      return false;
    }
    return true;
  }

  static bool _isHeaderText(String text) {
    final lower = text.toLowerCase().trim();
    final words = lower.split(RegExp(r'\s+'));
    if (words.length == 1 && _headerWords.contains(lower)) return true;
    if (words.length >= 2 &&
        words.every((w) => _headerWords.contains(w))) {
      return true;
    }
    if (lower.startsWith('zakres ref')) return true;
    if (lower.startsWith('nazwa bad')) return true;
    if (lower.startsWith('wynik bad')) return true;
    return false;
  }

  static String _cleanLabel(String raw) {
    var label = raw.trim();
    label = label.replaceAll(RegExp(r'\s+'), ' ');
    if (label.endsWith(':')) label = label.substring(0, label.length - 1).trim();
    if (label.isNotEmpty) {
      label = label[0].toUpperCase() + label.substring(1);
    }
    return label;
  }

  static void _deduplicateEntries(List<OcrEntry> entries) {
    final seen = <String>{};
    entries.removeWhere((e) {
      final key = e.label.toLowerCase();
      if (seen.contains(key)) return true;
      seen.add(key);
      return false;
    });
  }
}
