import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isLoginMode = true;
  bool _isLoading = false;

  final String _mockEmail = 'dawca@hdk.pl';
  final String _mockPassword = 'krew123';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginWithCredentials() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    if (_emailController.text == _mockEmail &&
        _passwordController.text == _mockPassword) {
      _navigateToMainApp();
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Błędny email lub hasło!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loginWithBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Twoje urządzenie nie obsługuje biometrii.'),
          ),
        );
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

      if (didAuthenticate && mounted) {
        _navigateToMainApp();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Błąd biometrii: $e')));
      }
    }
  }

  void _registerDummyAccount() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Rejestracja wkrótce zostanie podpięta pod backend! Zaloguj się na konto testowe.',
        ),
        backgroundColor: Colors.orange,
      ),
    );
    setState(() {
      _isLoginMode = true;
      _emailController.text = _mockEmail;
      _passwordController.text = _mockPassword;
    });
  }

  void _navigateToMainApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
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
                  child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
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
                  onPressed: _isLoginMode
                      ? _loginWithCredentials
                      : _registerDummyAccount,
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
            ],
          ),
        ),
      ),
    );
  }
}
