import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/info_page.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const SilentVoicesApp());
}

class SilentVoicesApp extends StatefulWidget {
  const SilentVoicesApp({super.key});

  @override
  State<SilentVoicesApp> createState() => _SilentVoicesAppState();
}

class _SilentVoicesAppState extends State<SilentVoicesApp> {
  bool _authenticated = false;
  bool _showLanding = true;
  bool _showLogin = true;

  void _onGetStarted() {
    setState(() {
      _showLanding = false;
      _showLogin = true;
    });
  }

  void _onLogin(String email, String password) {
    setState(() {
      _authenticated = true;
    });
  }

  void _onSignup(String name, String email, String password) {
    setState(() {
      _authenticated = true;
    });
  }

  void _switchToSignup() {
    setState(() {
      _showLogin = false;
    });
  }

  void _switchToLogin() {
    setState(() {
      _showLogin = true;
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
      home: _authenticated
          ? const HomePage()
          : _showLanding
              ? LandingPage(onGetStarted: _onGetStarted)
              : _showLogin
                  ? LoginPage(
                      onSignupTap: _switchToSignup,
                      onLogin: _onLogin,
                    )
                  : SignUpPage(
                      onSignInTap: _switchToLogin,
                    ),
    );
  }
} 