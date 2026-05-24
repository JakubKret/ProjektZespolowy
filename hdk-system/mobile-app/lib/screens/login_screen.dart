import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import '../core/providers/app_providers.dart';
import '../core/session/donor_session.dart';
import 'main_navigation_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isLoginMode = true;
  bool _isLoading = false;

  String _selectedSex = 'K';
  String _selectedBloodType = '0';
  String _selectedRh = '+';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _submitCredentials() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError('Podaj email i hasło.');
      return;
    }

    if (!_isLoginMode) {
      if (_firstNameController.text.trim().isEmpty ||
          _lastNameController.text.trim().isEmpty) {
        _showError('Podaj imię i nazwisko.');
        return;
      }
      if (password.length < 6) {
        _showError('Hasło musi mieć co najmniej 6 znaków.');
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      if (_isLoginMode) {
        await loginWithCredentials(ref, email: email, password: password);
      } else {
        await registerNewDonor(
          ref,
          email: email,
          password: password,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          sex: _selectedSex == 'K' ? 'F' : 'M',
          bloodType: _selectedBloodType,
          rhFactor: _selectedRh,
        );
      }

      if (!mounted) return;
      _navigateToMainApp();
    } catch (e) {
      if (!mounted) return;
      _showError('$e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics =
          await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        if (!mounted) return;
        _showError('Twoje urządzenie nie obsługuje biometrii.');
        return;
      }

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Odblokuj dostęp do swojego profilu dawcy',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'Wymagane uwierzytelnienie',
            cancelButton: 'Anuluj',
          ),
          IOSAuthMessages(cancelButton: 'Anuluj'),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (!didAuthenticate || !mounted) return;

      setState(() => _isLoading = true);
      await loginWithBiometrics(ref);
      if (!mounted) return;
      _navigateToMainApp();
    } catch (e) {
      if (!mounted) return;
      _showError('$e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _seedDemoAccount() async {
    setState(() => _isLoading = true);
    try {
      final db = ref.read(databaseProvider);
      final existing =
          await db.donorProfileDao.getProfileByEmail('dawca@hdk.pl');
      if (existing == null) {
        await registerNewDonor(
          ref,
          email: 'dawca@hdk.pl',
          password: 'krew123',
          firstName: 'Anna',
          lastName: 'Dawca',
          sex: 'F',
          bloodType: 'A',
          rhFactor: '-',
        );
        await logout(ref);
      }
      if (!mounted) return;
      setState(() {
        _isLoginMode = true;
        _emailController.text = 'dawca@hdk.pl';
        _passwordController.text = 'krew123';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konto testowe gotowe — kliknij Zaloguj się.'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoginMode = true;
        _emailController.text = 'dawca@hdk.pl';
        _passwordController.text = 'krew123';
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateToMainApp() {
    invalidateDonorData(ref);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Icon(
                  Icons.bloodtype,
                  size: 80,
                  color: Color(0xFFD32F2F),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Krwiodawstwo',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFFD32F2F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                _isLoginMode ? 'Logowanie' : 'Rejestracja',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              if (!_isLoginMode) ...[
                TextField(
                  controller: _firstNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Imię',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lastNameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Nazwisko',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildSegmentedSelector(
                  label: 'Płeć',
                  icon: Icons.wc,
                  options: const ['K', 'M'],
                  selected: _selectedSex,
                  onChanged: (v) => setState(() => _selectedSex = v),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildSegmentedSelector(
                        label: 'Grupa krwi',
                        icon: Icons.bloodtype,
                        options: const ['0', 'A', 'B', 'AB'],
                        selected: _selectedBloodType,
                        onChanged: (v) =>
                            setState(() => _selectedBloodType = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSegmentedSelector(
                        label: 'Rh',
                        icon: Icons.science,
                        options: const ['+', '-'],
                        selected: _selectedRh,
                        onChanged: (v) =>
                            setState(() => _selectedRh = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Hasło',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (_isLoading)
                const Center(
                  child:
                      CircularProgressIndicator(color: Color(0xFFD32F2F)),
                )
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submitCredentials,
                  child: Text(
                    _isLoginMode ? 'Zaloguj się' : 'Utwórz konto',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              if (_isLoginMode) ...[
                OutlinedButton.icon(
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Zaloguj się biometrycznie'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD32F2F),
                    side: const BorderSide(color: Color(0xFFD32F2F)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _loginWithBiometrics,
                ),
              ],
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoginMode = !_isLoginMode;
                  });
                },
                child: Text(
                  _isLoginMode
                      ? 'Nie masz konta? Zarejestruj się'
                      : 'Masz już konto? Zaloguj się',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              if (_isLoginMode)
                TextButton(
                  onPressed: _seedDemoAccount,
                  child: const Text(
                    'Wypełnij dane testowe',
                    style: TextStyle(color: Color(0xFFD32F2F)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedSelector({
    required String label,
    required IconData icon,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: options.map((opt) {
              final isSelected = opt == selected;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(opt),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFD32F2F)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Center(
                      child: Text(
                        opt,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
