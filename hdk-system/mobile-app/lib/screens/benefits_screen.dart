import 'package:flutter/material.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Korzyści i Odznaki',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildPitCard(theme),
          const SizedBox(height: 32),
          Text(
            'Twoje Odznaki ZHDK',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildBadgeItem(
            theme,
            'Zasłużony Honorowy Dawca Krwi III stopnia',
            'Brązowa odznaka (oddane 6 litrów)',
            true,
          ),
          const SizedBox(height: 12),
          _buildBadgeItem(
            theme,
            'Zasłużony Honorowy Dawca Krwi II stopnia',
            'Srebrna odznaka (oddane 12 litrów)',
            false,
          ),
          const SizedBox(height: 12),
          _buildBadgeItem(
            theme,
            'Zasłużony Honorowy Dawca Krwi I stopnia',
            'Złota odznaka (oddane 18 litrów)',
            false,
          ),
          const SizedBox(height: 12),
          _buildBadgeItem(
            theme,
            'HDK - Zasłużony dla Zdrowia Narodu',
            'Tytuł MZ (oddane 20 litrów)',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildPitCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFD32F2F), Colors.red.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kalkulator Ulgi PIT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Icon(Icons.calculate, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Szacowana ulga za bieżący rok:',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            '234.00 PLN',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Przelicznik: 1 litr = 130 PLN.\nPamiętaj, że ostateczna kwota zależy od Twoich dochodów.',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(
    ThemeData theme,
    String title,
    String subtitle,
    bool isUnlocked,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isUnlocked ? const Color(0xFFFFF0F0) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: isUnlocked ? const Color(0xFFFFCDCD) : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isUnlocked
                  ? const Color(0xFFD32F2F)
                  : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.military_tech,
              color: isUnlocked ? Colors.white : Colors.grey.shade500,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.black87 : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isUnlocked
                        ? const Color(0xFFD32F2F)
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked) const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
  }
}
