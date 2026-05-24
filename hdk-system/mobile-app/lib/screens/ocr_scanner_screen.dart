import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';

import '../core/database/app_database.dart';
import '../core/providers/app_providers.dart';
import '../features/ocr/domain/morphology_ocr_parser.dart';

class OcrScannerScreen extends ConsumerStatefulWidget {
  const OcrScannerScreen({super.key});

  @override
  ConsumerState<OcrScannerScreen> createState() => _OcrScannerScreenState();
}

class _OcrScannerScreenState extends ConsumerState<OcrScannerScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  bool _isProcessing = false;

  List<OcrEntry> _entries = [];
  List<TextEditingController> _valueControllers = [];

  Future<void> _pickAndAnalyzeImage(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);
    if (photo == null) return;

    setState(() {
      _imageFile = File(photo.path);
      _isProcessing = true;
      _disposeControllers();
      _entries = [];
    });

    await _processImageWithMLKit(_imageFile!);
  }

  Future<void> _processImageWithMLKit(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      final ocrLines = <OcrTextLine>[];

      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          final rect = line.boundingBox;
          ocrLines.add(OcrTextLine(
            text: line.text,
            top: rect.top,
            bottom: rect.bottom,
          ));
        }
      }

      final result = MorphologyOcrParser.parseWithPositions(ocrLines);

      setState(() {
        _entries = result.entries;
        _valueControllers = _entries
            .map((e) => TextEditingController(text: e.value.toStringAsFixed(
                e.value == e.value.roundToDouble() ? 0 : 1)))
            .toList();
        _isProcessing = false;
      });

      if (!result.hasAnyValue && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Nie rozpoznano wartości na zdjęciu. Wpisz dane ręcznie.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      setState(() => _isProcessing = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Błąd skanowania: $e')));
    } finally {
      textRecognizer.close();
    }
  }

  void _removeEntry(int index) {
    setState(() {
      _valueControllers[index].dispose();
      _valueControllers.removeAt(index);
      _entries.removeAt(index);
    });
  }

  Future<void> _saveResults() async {
    final donorId = ref.read(currentDonorIdProvider);
    if (donorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Brak aktywnego profilu dawcy.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    for (var i = 0; i < _entries.length; i++) {
      final parsed = double.tryParse(
          _valueControllers[i].text.replaceAll(',', '.'));
      if (parsed != null) _entries[i].value = parsed;
    }

    final columnValues = <String, double>{};
    for (final entry in _entries) {
      final col = entry.dbColumn;
      if (col != null) columnValues[col] = entry.value;
    }

    final db = ref.read(databaseProvider);

    try {
      await db.morphologyResultsDao.createResult(
        MorphologyResultsTableCompanion.insert(
          donorId: donorId,
          resultDate: DateTime.now(),
          isVerified: const drift.Value(true),
          hgbGDl: drift.Value(columnValues['hgbGDl']),
          hctPct: drift.Value(columnValues['hctPct']),
          rbcMlnUl: drift.Value(columnValues['rbcMlnUl']),
          mcvFl: drift.Value(columnValues['mcvFl']),
          mchPg: drift.Value(columnValues['mchPg']),
          mchcGDl: drift.Value(columnValues['mchcGDl']),
          rdwPct: drift.Value(columnValues['rdwPct']),
          wbcTysUl: drift.Value(columnValues['wbcTysUl']),
          neutPct: drift.Value(columnValues['neutPct']),
          lymphPct: drift.Value(columnValues['lymphPct']),
          monoPct: drift.Value(columnValues['monoPct']),
          eosPct: drift.Value(columnValues['eosPct']),
          basoPct: drift.Value(columnValues['basoPct']),
          pltTysUl: drift.Value(columnValues['pltTysUl']),
          mpvFl: drift.Value(columnValues['mpvFl']),
          feUgDl: drift.Value(columnValues['feUgDl']),
          ferritinNgMl: drift.Value(columnValues['ferritinNgMl']),
        ),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wyniki zapisane pomyślnie!'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        _imageFile = null;
        _disposeControllers();
        _entries = [];
      });

      invalidateDonorData(ref);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd zapisu: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _disposeControllers() {
    for (final c in _valueControllers) {
      c.dispose();
    }
    _valueControllers = [];
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(morphologyHistoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Archiwum Wyników',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isProcessing
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildScanButtons(),
                  if (_entries.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildWarningBanner(),
                    const SizedBox(height: 16),
                    _buildEntryCards(),
                    const SizedBox(height: 20),
                    _buildSaveButton(),
                  ],
                  if (_imageFile != null && _entries.isEmpty) ...[
                    const SizedBox(height: 24),
                    _buildImagePreview(),
                  ],
                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    'Historia Twoich Badań',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildHistory(historyAsync),
                ],
              ),
            ),
    );
  }

  Widget _buildScanButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Aparat'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => _pickAndAnalyzeImage(ImageSource.camera),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.photo_library),
            label: const Text('Galeria'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFD32F2F),
              side: const BorderSide(color: Color(0xFFD32F2F)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => _pickAndAnalyzeImage(ImageSource.gallery),
          ),
        ),
      ],
    );
  }

  Widget _buildWarningBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Zweryfikuj wartości z papierem. Możesz edytować lub usunąć wpisy.',
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryCards() {
    return Column(
      children: List.generate(_entries.length, (i) {
        final entry = _entries[i];
        final isKnown = entry.dbColumn != null;

        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isKnown ? Colors.green.shade300 : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          color: isKnown ? Colors.green.shade50 : Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      if (entry.unit != null)
                        Text(
                          entry.unit!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _valueControllers[i],
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  color: Colors.red.shade400,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  onPressed: () => _removeEntry(i),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: _saveResults,
      child: const Text(
        'Zatwierdź i Zapisz',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        _imageFile!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildHistory(AsyncValue<List<MorphologyResultsTableData>> historyAsync) {
    return historyAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Błąd ładowania historii: $err'),
      data: (history) {
        if (history.isEmpty) {
          return const Text(
            'Brak zapisanych wyników.',
            style: TextStyle(color: Colors.grey),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final result = history[index];
            return _buildHistoryCard(result);
          },
        );
      },
    );
  }

  Widget _buildHistoryCard(MorphologyResultsTableData result) {
    final formattedDate =
        DateFormat('dd.MM.yyyy HH:mm').format(result.resultDate);

    final values = <String, String>{};
    if (result.hgbGDl != null) values['HGB'] = '${result.hgbGDl} g/dl';
    if (result.ferritinNgMl != null) {
      values['Ferrytyna'] = '${result.ferritinNgMl} ng/ml';
    }
    if (result.wbcTysUl != null) values['WBC'] = '${result.wbcTysUl} tys/µl';
    if (result.rbcMlnUl != null) values['RBC'] = '${result.rbcMlnUl} mln/µl';
    if (result.hctPct != null) values['HCT'] = '${result.hctPct}%';
    if (result.mcvFl != null) values['MCV'] = '${result.mcvFl} fl';
    if (result.mchPg != null) values['MCH'] = '${result.mchPg} pg';
    if (result.mchcGDl != null) values['MCHC'] = '${result.mchcGDl} g/dl';
    if (result.pltTysUl != null) values['PLT'] = '${result.pltTysUl} tys/µl';
    if (result.feUgDl != null) values['Fe'] = '${result.feUgDl} µg/dl';

    return Card(
      elevation: 0,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (result.isVerified)
                  const Icon(Icons.verified, color: Colors.green, size: 20),
              ],
            ),
            if (values.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...values.entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    '${e.key}: ${e.value}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Brak danych',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
