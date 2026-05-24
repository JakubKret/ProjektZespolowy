import 'package:flutter_test/flutter_test.dart';
import 'package:hdk_mobile_app/features/ocr/domain/morphology_ocr_parser.dart';

void main() {
  group('MorphologyOcrParser.parse (plain text)', () {
    test('parses Diagnostyka lab report format', () {
      const input = '''
Morfologia krwi (ICD-9: C53)
Leukocyty 8,0 tys/µl* 3,8 10,0
Erytrocyty 4,5 mln/µl* 4,2 6,0
Hemoglobina 14,5 g/dl* 14,0 18,0
Hematokryt 43 %* 40 54
MCV 96 fl* 80 99
MCH 32 pg* 27 35
MCHC 33,8 g/dl* 32,0 37,0
Płytki krwi 279 tys/µl* 140 440
''';

      final result = MorphologyOcrParser.parse(input);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};

      expect(map['hemoglobina']?.value, 14.5);
      expect(map['leukocyty']?.value, 8.0);
      expect(map['erytrocyty']?.value, 4.5);
      expect(map['hematokryt']?.value, 43.0);
      expect(map['mcv']?.value, 96.0);
      expect(map['mch']?.value, 32.0);
      expect(map['mchc']?.value, 33.8);
      expect(map['płytki krwi']?.value, 279.0);
    });

    test('parses Portal/hospital format', () {
      const input = '''
Krwinki białe (WBC) 10,78 ×10³/µl 4,69 — 12,81
Krwinki czerwone (RBC) 4,46 ×106/µl 4,14 — 5,22
Hemoglobina 12,6 g/dl 11,2 — 14,1
Hematokryt 36,0 % 32,8 — 40,4
MCV 80,7 fl 72,9 — 83,8
MCH 28,3 pg 24,9 — 29,3
MCHC 35,0 g/dl 33,0 — 36,3
Płytki krwi 431 ×10³/µl 197 — 435
''';

      final result = MorphologyOcrParser.parse(input);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};

      expect(map['hemoglobina']?.value, 12.6);
      expect(map['hematokryt']?.value, 36.0);
      expect(map['mcv']?.value, 80.7);
      expect(map['mch']?.value, 28.3);
      expect(map['mchc']?.value, 35.0);
    });

    test('parses ferrytyna value', () {
      const input = '''
Hemoglobina 13,2 g/dl
Ferrytyna 45,3 ng/ml
''';
      final result = MorphologyOcrParser.parse(input);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};
      expect(map['hemoglobina']?.value, 13.2);
      expect(map['ferrytyna']?.value, 45.3);
    });

    test('handles HGB abbreviation', () {
      final result = MorphologyOcrParser.parse('HGB 15,0 g/dl');
      expect(result.entries.isNotEmpty, true);
      expect(result.entries.first.value, 15.0);
    });

    test('handles period decimals', () {
      final result = MorphologyOcrParser.parse('Hemoglobina 14.2 g/dl');
      expect(result.entries.first.value, 14.2);
    });

    test('returns empty when nothing recognized', () {
      final result =
          MorphologyOcrParser.parse('Some random text with no lab values');
      expect(result.hasAnyValue, isFalse);
    });

    test('handles value on the next line after label', () {
      final result =
          MorphologyOcrParser.parse('Hemoglobina\n14,8\ng/dl');
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};
      expect(map['hemoglobina']?.value, 14.8);
    });

    test('dynamically discovers unknown fields', () {
      const input = '''
CRP 5,2 mg/l
TSH 2,45 µIU/ml
''';
      final result = MorphologyOcrParser.parse(input);
      expect(result.entries.length, 2);
      expect(result.entries[0].label, 'CRP');
      expect(result.entries[0].value, 5.2);
      expect(result.entries[1].label, 'TSH');
      expect(result.entries[1].value, 2.45);
    });

    test('maps known labels to DB columns', () {
      final result = MorphologyOcrParser.parse('Hemoglobina 14,5 g/dl');
      expect(result.entries.first.dbColumn, 'hgbGDl');
    });

    test('unknown labels have null dbColumn', () {
      final result = MorphologyOcrParser.parse('CRP 5,2 mg/l');
      expect(result.entries.first.dbColumn, isNull);
    });
  });

  group('MorphologyOcrParser.parseWithPositions (spatial)', () {
    test('matches label and value on the same row even in different blocks', () {
      final ocrLines = [
        const OcrTextLine(text: 'Hemoglobina', top: 100, bottom: 120),
        const OcrTextLine(text: 'Hematokryt', top: 130, bottom: 150),
        const OcrTextLine(text: 'MCV', top: 160, bottom: 180),
        const OcrTextLine(text: '12,6', top: 100, bottom: 120),
        const OcrTextLine(text: '36,0', top: 130, bottom: 150),
        const OcrTextLine(text: '80,7', top: 160, bottom: 180),
        const OcrTextLine(text: 'g/dl', top: 100, bottom: 120),
        const OcrTextLine(text: '%', top: 130, bottom: 150),
        const OcrTextLine(text: 'fl', top: 160, bottom: 180),
      ];

      final result = MorphologyOcrParser.parseWithPositions(ocrLines);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};

      expect(map['hemoglobina']?.value, 12.6);
      expect(map['hematokryt']?.value, 36.0);
      expect(map['mcv']?.value, 80.7);
    });

    test('prefers same-line value over spatial match', () {
      final ocrLines = [
        const OcrTextLine(
            text: 'Hemoglobina 14,5 g/dl', top: 100, bottom: 120),
        const OcrTextLine(text: '99,9', top: 100, bottom: 120),
      ];

      final result = MorphologyOcrParser.parseWithPositions(ocrLines);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};
      expect(map['hemoglobina']?.value, 14.5);
    });

    test('full Portal report simulation with column blocks', () {
      final ocrLines = [
        const OcrTextLine(text: 'Hematologia', top: 10, bottom: 30),
        const OcrTextLine(text: 'Nazwa badania', top: 40, bottom: 55),
        const OcrTextLine(text: 'Wynik badania', top: 40, bottom: 55),
        const OcrTextLine(
            text: 'Zakres referencyjny', top: 40, bottom: 55),
        const OcrTextLine(
            text: 'Krwinki białe (WBC)', top: 80, bottom: 100),
        const OcrTextLine(text: '10,78', top: 80, bottom: 100),
        const OcrTextLine(text: '×103/µl', top: 80, bottom: 100),
        const OcrTextLine(text: '4,69 — 12,81', top: 80, bottom: 100),
        const OcrTextLine(
            text: 'Krwinki czerwone (RBC)', top: 110, bottom: 130),
        const OcrTextLine(text: '4,46', top: 110, bottom: 130),
        const OcrTextLine(text: '×106/µl', top: 110, bottom: 130),
        const OcrTextLine(text: '4,14 — 5,22', top: 110, bottom: 130),
        const OcrTextLine(text: 'Hemoglobina', top: 140, bottom: 160),
        const OcrTextLine(text: '12,6', top: 140, bottom: 160),
        const OcrTextLine(text: 'g/dl', top: 140, bottom: 160),
        const OcrTextLine(text: '11,2 — 14,1', top: 140, bottom: 160),
        const OcrTextLine(text: 'Hematokryt', top: 170, bottom: 190),
        const OcrTextLine(text: '36,0', top: 170, bottom: 190),
        const OcrTextLine(text: '%', top: 170, bottom: 190),
        const OcrTextLine(text: '32,8 — 40,4', top: 170, bottom: 190),
        const OcrTextLine(text: 'Płytki krwi', top: 200, bottom: 220),
        const OcrTextLine(text: '431', top: 200, bottom: 220),
        const OcrTextLine(text: '×103/µl', top: 200, bottom: 220),
        const OcrTextLine(text: '197 — 435', top: 200, bottom: 220),
      ];

      final result = MorphologyOcrParser.parseWithPositions(ocrLines);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};

      expect(map['hemoglobina']?.value, 12.6);
      expect(map['hematokryt']?.value, 36.0);
      expect(map['płytki krwi']?.value, 431.0);
    });

    test('does not grab value from a different row', () {
      final ocrLines = [
        const OcrTextLine(text: 'Hemoglobina', top: 100, bottom: 120),
        const OcrTextLine(text: '99,9', top: 200, bottom: 220),
      ];

      final result = MorphologyOcrParser.parseWithPositions(ocrLines);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};
      expect(map['hemoglobina'], isNull);
    });

    test('does not match referencyjny as label', () {
      final ocrLines = [
        const OcrTextLine(
            text: 'Zakres referencyjny', top: 40, bottom: 55),
        const OcrTextLine(text: '4,7 — 12,0', top: 40, bottom: 55),
        const OcrTextLine(text: 'Hemoglobina', top: 80, bottom: 100),
        const OcrTextLine(text: '14,5', top: 80, bottom: 100),
      ];

      final result = MorphologyOcrParser.parseWithPositions(ocrLines);
      final map = {for (final e in result.entries) e.label.toLowerCase(): e};
      expect(map['hemoglobina']?.value, 14.5);
      expect(map.containsKey('zakres referencyjny'), isFalse);
    });

    test('discovers arbitrary lab fields spatially', () {
      final ocrLines = [
        const OcrTextLine(text: 'Glukoza', top: 100, bottom: 120),
        const OcrTextLine(text: '95,0', top: 100, bottom: 120),
        const OcrTextLine(text: 'mg/dl', top: 100, bottom: 120),
        const OcrTextLine(text: 'Kreatynina', top: 130, bottom: 150),
        const OcrTextLine(text: '1,02', top: 130, bottom: 150),
        const OcrTextLine(text: 'mg/dl', top: 130, bottom: 150),
      ];

      final result = MorphologyOcrParser.parseWithPositions(ocrLines);
      expect(result.entries.length, 2);
      expect(result.entries[0].label, 'Glukoza');
      expect(result.entries[0].value, 95.0);
      expect(result.entries[0].unit, 'mg/dl');
      expect(result.entries[1].label, 'Kreatynina');
      expect(result.entries[1].value, 1.02);
    });
  });
}
