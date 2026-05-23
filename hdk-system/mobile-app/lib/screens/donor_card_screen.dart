import 'package:flutter/material.dart';

class DonorCardScreen extends StatelessWidget {
  // Przykładowe zmockowane dane - docelowo z backendu
  final double totalLiters = 4.5;
  final String bloodType = 'A Rh-';
  final int daysToNextDonation = 14;
  final String nextDonationDate = '06.06.2026';

  const DonorCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Karta Dawcy',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildBloodTypeBadge(theme),
              const Spacer(),
              _buildMainCounter(theme),
              const Spacer(),
              _buildKarencjaInfo(theme),
              const SizedBox(height: 30),
              _buildActionButtons(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBloodTypeBadge(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFFFCDCD), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bloodtype, color: Color(0xFFD32F2F)),
          const SizedBox(width: 8),
          Text(
            'Grupa krwi: $bloodType',
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFFD32F2F),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCounter(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Oddana krew',
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(color: const Color(0xFFD32F2F), width: 4),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  totalLiters.toStringAsFixed(1),
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: const Color(0xFFD32F2F),
                    fontWeight: FontWeight.w900,
                    fontSize: 64,
                  ),
                ),
                Text(
                  'LITRA',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.red.shade300,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKarencjaInfo(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            'Następna donacja możliwa za:',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$daysToNextDonation DNI',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Planowana data: $nextDonationDate',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Nawigacja do formularza dodawania donacji
            },
            icon: const Icon(Icons.add),
            label: const Text('Dodaj wpis'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }
}
