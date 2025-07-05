import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/info_page.dart';
import 'screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SilentVoicesApp());
}

class SilentVoicesApp extends StatefulWidget {
  const SilentVoicesApp({super.key});

  @override
  State<SilentVoicesApp> createState() => _SilentVoicesAppState();
}

class _SilentVoicesAppState extends State<SilentVoicesApp> {
  final AuthService _authService = AuthService();
  bool _showLanding = true;
  bool _showLogin = true;
  String? _errorMessage;

  void _onGetStarted() {
    setState(() {
      _showLanding = false;
      _showLogin = true;
      _errorMessage = null;
    });
  }

  Future<void> _onLogin(String email, String password) async {
    try {
      setState(() {
        _errorMessage = null;
      });
      
      await _authService.signIn(email: email, password: password);
      // Authentication successful - user will be redirected via StreamBuilder
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _onSignup(String name, String email, String password) async {
    try {
      setState(() {
        _errorMessage = null;
      });
      
      await _authService.signUp(name: name, email: email, password: password);
      // Registration successful - user will be redirected via StreamBuilder
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  void _switchToSignup() {
    setState(() {
      _showLogin = false;
      _errorMessage = null;
    });
  }

  void _switchToLogin() {
    setState(() {
      _showLogin = true;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Voices',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/info': (context) => const InfoPage(),
        '/home': (context) => const HomePage(),
      },
      home: StreamBuilder<User?>(
        stream: _authService.authStateChanges,
        builder: (context, snapshot) {
          // Show loading indicator while checking auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4FC3F7),
                ),
              ),
            );
          }

          // User is authenticated
          if (snapshot.hasData && snapshot.data != null) {
            return const HomePage();
          }

          // User is not authenticated - show auth screens
          return _showLanding
              ? LandingPage(
                  onSignIn: () => setState(() {
                    _showLanding = false;
                    _showLogin = true;
                  }),
                  onSignUp: () => setState(() {
                    _showLanding = false;
                    _showLogin = false;
                  }),
                )
              : _showLogin
                  ? LoginPage(
                      onSignupTap: _switchToSignup,
                      onLogin: _onLogin,
                      errorMessage: _errorMessage,
                    )
                  : SignUpPage(
                      onSignInTap: _switchToLogin,
                      onSignup: _onSignup,
                      errorMessage: _errorMessage,
                    );
        },
      ),
    );
  }
} 