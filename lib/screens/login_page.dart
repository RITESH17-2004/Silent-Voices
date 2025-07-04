import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import '../widgets/password_field.dart';
import 'forget_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onSignupTap;
  final void Function(String email, String password) onLogin;
  const LoginPage({super.key, required this.onSignupTap, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String? error;
  bool rememberMe = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1C2C),
              Colors.black,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top soft wave with image
              Stack(
                children: [
                  ClipPath(
                    clipper: SoftWaveClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 210,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x334FC3F7),
                            blurRadius: 32,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/illustrations/signs.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            height: 210,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            height: 60,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Color(0xFF0B1C2C),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Login form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4FC3F7),
                          shadows: [
                            Shadow(
                              color: const Color(0xFF4FC3F7).withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Login to your account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFFA6CCE3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _ModernTextField(
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        onChanged: (v) => setState(() => email = v),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Email required';
                          if (!v.contains('@')) return 'Enter a valid email';
                          return null;
                        },
                        obscureText: false,
                      ),
                      const SizedBox(height: 18),
                      PasswordField(
                        controller: _passwordController,
                        hintText: 'Password',
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Password required';
                          if (v.length < 6) return 'Min 6 characters';
                          return null;
                        },
                        onChanged: (v) => setState(() => password = v),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (v) => setState(() => rememberMe = v ?? false),
                            activeColor: Color(0xFF4FC3F7),
                            checkColor: Colors.white,
                            side: BorderSide(color: Color(0xFF4FC3F7), width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          Text('Remember Me', style: GoogleFonts.poppins(color: Colors.white)),
                          Spacer(),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4),
                              splashColor: Color(0x334FC3F7),
                              highlightColor: Color(0x224FC3F7),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const ForgetPasswordPage()),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFFA6CCE3),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      if (error != null) ...[
                        const SizedBox(height: 12),
                        Text(error!, style: const TextStyle(color: Colors.red)),
                      ],
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: _ModernGradientButton(
                          text: 'Login',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.onLogin(email, password);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: _ClickableSentence(
                          text: "Don't have an account? Sign up",
                          onTap: widget.onSignupTap,
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom soft wave clipper for the top container
class SoftWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width * 0.25, size.height - 20, size.width * 0.5, size.height - 30);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 40, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Modern styled text field
class _ModernTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  const _ModernTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.suffixIcon,
  });

  @override
  State<_ModernTextField> createState() => _ModernTextFieldState();
}

class _ModernTextFieldState extends State<_ModernTextField> {
  bool _focused = false;
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (f) => setState(() => _focused = f),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          boxShadow: _focused
              ? [
                  BoxShadow(
                    color: const Color(0xFF4FC3F7).withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF0F1F33),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(color: Color(0xFFB0BEC5)),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Image.asset(
                widget.icon == Icons.email_outlined
                    ? 'assets/icons/email.png'
                    : 'assets/icons/lock.png',
                width: 24,
                height: 24,
                color: Color(0xFF4FC3F7),
              ),
            ),
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF2A5D85), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF2A5D85), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF4FC3F7), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          ),
        ),
      ),
    );
  }
}

// Modern gradient button with soft glow on hover/focus
class _ModernGradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const _ModernGradientButton({super.key, required this.text, required this.onPressed});

  @override
  State<_ModernGradientButton> createState() => _ModernGradientButtonState();
}

class _ModernGradientButtonState extends State<_ModernGradientButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF0277BD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF4FC3F7).withOpacity(0.5),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.onPressed,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                widget.text,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Add this widget at the end of the file:
class _ClickableSentence extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const _ClickableSentence({required this.text, required this.onTap});
  @override
  State<_ClickableSentence> createState() => _ClickableSentenceState();
}

class _ClickableSentenceState extends State<_ClickableSentence> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: _pressed ? const Color(0x224FC3F7) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          widget.text,
          style: GoogleFonts.poppins(
            color: const Color(0xFFB0BEC5),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

