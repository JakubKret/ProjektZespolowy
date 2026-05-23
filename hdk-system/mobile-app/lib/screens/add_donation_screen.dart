import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/database/app_database.dart';
import '../core/workflows/donor_workflow_service.dart';

class AddDonationScreen extends StatefulWidget {
  const AddDonationScreen({Key? key}) : super(key: key);

  @override
  State<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Zmienne przechowujące stan formularza
  DateTime _selectedDate = DateTime.now();
  String _selectedType = 'Krew pełna';
  final TextEditingController _amountController = TextEditingController(
    text: '450',
  ); // Domyślna wartość w ml

  final List<String> _donationTypes = ['Krew pełna', 'Osocze', 'Płytki krwi'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Nie pozwalamy na donacje w przyszłości
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFD32F2F), // Medyczna czerwień na kalendarzu
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final int amount = int.parse(_amountController.text);

      // Mapujemy polskie nazwy na te obsługiwane przez backend
      String backendDonationType = 'whole_blood';
      if (_selectedType == 'Osocze') backendDonationType = 'plasma';
      if (_selectedType == 'Płytki krwi') backendDonationType = 'platelets';

      try {
        // Inicjalizacja bazy - w prawdziwej aplikacji przekażemy ją z góry np. przez Providera
        final database = AppDatabase();
        final workflowService = DonorWorkflowService(database);

        // Wywołanie dokładnie tej funkcji, którą przesłałeś w plikach!
        await workflowService.recordDonationAndRefreshBenefits(
          donorProfileId: 1, // TODO: Pobrać zalogowanego użytkownika
          bloodCenterId: 1, // TODO: Wybrać z listy / mapy
          donationDate: _selectedDate,
          volumeMl: amount,
          donationType: backendDonationType,
          annualIncomePln: 0.0, // Tymczasowo 0, potrzebne do PIT
        );

        if (!mounted) return;

        // Sukces
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
        // Obsługa błędu zapisu do lokalnej bazy
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Błąd zapisu: $e'),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

                // Pole wyboru daty donacji
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

                // Pole wyboru typu składnika
                const Text(
                  'Składnik krwi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFFD32F2F)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                  ),
                  items: _donationTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                      // Dopasowanie domyślnej ilości na podstawie składnika
                      if (_selectedType == 'Osocze') {
                        _amountController.text = '600';
                      } else if (_selectedType == 'Płytki krwi') {
                        _amountController.text =
                            '250'; // Zależnie od wytycznych
                      } else {
                        _amountController.text = '450';
                      }
                    });
                  },
                ),
                const SizedBox(height: 24),

                // Pole objętości
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
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Color(0xFFD32F2F)),
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

                // Przycisk zapisu
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
                      elevation: 0,
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
