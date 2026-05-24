import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../core/bootstrap/reference_data_seed.dart';
import '../core/providers/app_providers.dart';

class AddDonationScreen extends ConsumerStatefulWidget {
  const AddDonationScreen({super.key});

  @override
  ConsumerState<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends ConsumerState<AddDonationScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  String _selectedType = 'Krew pełna';
  int? _selectedBloodCenterId;
  final TextEditingController _amountController = TextEditingController(
    text: '450',
  );

  final List<String> _donationTypes = ['Krew pełna', 'Osocze', 'Płytki krwi'];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFD32F2F),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

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

    final centers = await ref.read(bloodCentersProvider.future);
    if (centers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Brak placówek w bazie. Dodaj placówkę na mapie lub zaloguj się ponownie.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final bloodCenterId = _selectedBloodCenterId ?? centers.first.id;
    final amount = int.parse(_amountController.text);

    String backendDonationType = 'whole_blood';
    if (_selectedType == 'Osocze') backendDonationType = 'plasma';
    if (_selectedType == 'Płytki krwi') backendDonationType = 'platelets';

    try {
      final workflowService = ref.read(donorWorkflowServiceProvider);
      await workflowService.recordDonationAndRefreshBenefits(
        donorProfileId: donorId,
        bloodCenterId: bloodCenterId,
        donationDate: _selectedDate,
        volumeMl: amount,
        donationType: backendDonationType,
        annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Zapisano: $_selectedType ($amount ml) z dnia ${DateFormat('dd.MM.yyyy').format(_selectedDate)}',
          ),
          backgroundColor: Colors.green.shade600,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Błąd zapisu: $e'),
          backgroundColor: Colors.red.shade600,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final centersAsync = ref.watch(bloodCentersProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFD32F2F)),
        title: const Text(
          'Dodaj donację',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Uzupełnij szczegóły swojej donacji. Pamiętaj, aby wpisać dokładne dane ze stacji.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Data donacji',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy').format(_selectedDate),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Placówka',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                centersAsync.when(
                  loading: () => const LinearProgressIndicator(
                    color: Color(0xFFD32F2F),
                  ),
                  error: (e, _) => Text('Błąd wczytywania placówek: $e'),
                  data: (centers) {
                    if (centers.isEmpty) {
                      return const Text(
                        'Brak placówek — wróć na mapę i dodaj dane.',
                        style: TextStyle(color: Colors.orange),
                      );
                    }
                    final selectedId =
                        _selectedBloodCenterId ?? centers.first.id;
                    return DropdownButtonFormField<int>(
                      initialValue: selectedId,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      items: centers
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.id,
                              child: Text('${c.name} (${c.city})'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedBloodCenterId = value);
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Składnik krwi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: _donationTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue!;
                      if (_selectedType == 'Osocze') {
                        _amountController.text = '600';
                      } else if (_selectedType == 'Płytki krwi') {
                        _amountController.text = '250';
                      } else {
                        _amountController.text = '450';
                      }
                    });
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ilość (w mililitrach)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: 'ml',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Proszę podać ilość';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Proszę podać poprawną wartość liczbową';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Zapisz donację',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
