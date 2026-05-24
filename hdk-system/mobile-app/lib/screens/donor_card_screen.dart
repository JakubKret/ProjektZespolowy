import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers/app_providers.dart';
import '../core/session/donor_session.dart';
import 'add_donation_screen.dart';
import 'login_screen.dart';
import 'menstrual_cycle_screen.dart';

class DonorCardScreen extends ConsumerWidget {
  const DonorCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dashboardAsync = ref.watch(donorDashboardProvider);

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFD32F2F)),
            tooltip: 'Wyloguj się',
            onPressed: () async {
              await logout(ref);
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: dashboardAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
          ),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Nie udało się wczytać profilu: $error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (dashboard) {
            if (dashboard == null) {
              return const Center(
                child: Text('Zaloguj się, aby zobaczyć kartę dawcy.'),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${dashboard.profile.firstName} ${dashboard.profile.lastName}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dashboard.profile.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildBloodTypeBadge(theme, dashboard.bloodTypeLabel),
                  const Spacer(),
                  _buildMainCounter(theme, dashboard.totalLiters),
                  const Spacer(),
                  _buildKarencjaInfo(theme, dashboard),
                  const SizedBox(height: 30),
                  _buildActionButtons(context, ref, theme),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBloodTypeBadge(ThemeData theme, String bloodType) {
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

  Widget _buildMainCounter(ThemeData theme, double totalLiters) {
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
                color: Colors.red.withValues(alpha: 0.15),
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

  Widget _buildKarencjaInfo(ThemeData theme, DonorDashboardData dashboard) {
    final canDonate = dashboard.eligibility.canDonate;

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
            canDonate
                ? 'Możesz oddać krew już teraz'
                : 'Następna donacja możliwa za:',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          if (!canDonate) ...[
            const SizedBox(height: 8),
            Text(
              '${dashboard.daysUntilNextDonation} DNI',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            canDonate
                ? 'Brak aktywnej karencji'
                : 'Planowana data: ${dashboard.nextDonationDateLabel}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDonationScreen(),
                ),
              );
              invalidateDonorData(ref);
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
        const SizedBox(width: 12),
        IconButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenstrualCycleScreen(),
              ),
            );
            invalidateDonorData(ref);
          },
          icon: const Icon(Icons.water_drop, color: Colors.pinkAccent),
          style: IconButton.styleFrom(
            backgroundColor: Colors.pink.shade50,
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
