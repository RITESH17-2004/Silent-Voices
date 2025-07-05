import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import '../widgets/password_field.dart';
import 'forget_password_page.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onSignInTap;
  final Future<void> Function(String name, String email, String password)? onSignup;
  final String? errorMessage;
  const SignUpPage({
    super.key, 
    required this.onSignInTap,
    this.onSignup,
    this.errorMessage,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  bool rememberMe = false;
  bool emailValid = false;
  bool _isLoading = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0B1C2C),
                  Color(0xFF050D18),
                ],
              ),
            ),
          ),
          // Bottom wave with image
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                width: double.infinity,
                height: 180,
                child: Image.asset(
                  'assets/illustrations/signs.png',
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.15),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
          ),
          // Sign up form
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Register',
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
                        'Create your new account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFFA6CCE3),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _SignUpTextField(
                        hintText: 'Full Name',
                        iconPath: 'assets/icons/user.png',
                        onChanged: (v) => setState(() => name = v),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Name required';
                          return null;
                        },
                        obscureText: false,
                      ),
                      const SizedBox(height: 18),
                      _SignUpTextField(
                        hintText: 'Email',
                        iconPath: 'assets/icons/email.png',
                        onChanged: (v) => setState(() {
                          email = v;
                          emailValid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
                        }),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Email required';
                          if (!v.contains('@')) return 'Enter a valid email';
                          return null;
                        },
                        obscureText: false,
                        suffixIcon: emailValid
                            ? Icon(Icons.check_circle, color: Color(0xFF4FC3F7), size: 22)
                            : null,
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
                      // Error message display
                      if (widget.errorMessage != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.withOpacity(0.3)),
                          ),
                          child: Text(
                            widget.errorMessage!,
                            style: GoogleFonts.poppins(
                              color: Colors.red[300],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: _ModernGradientButton(
                          text: _isLoading ? 'Creating Account...' : 'Register',
                          onPressed: _isLoading || widget.onSignup == null ? () {} : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await widget.onSignup!(name, email, password);
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Color(0xFF2A5D85), thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Or continue with', style: GoogleFonts.poppins(color: Color(0xFFB0BEC5))),
                          ),
                          Expanded(child: Divider(color: Color(0xFF2A5D85), thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialIcon(asset: 'assets/icons/facebook.png'),
                          const SizedBox(width: 18),
                          _SocialIcon(asset: 'assets/icons/google.png'),
                          const SizedBox(width: 18),
                          _SocialIcon(asset: 'assets/icons/instagram.png'),
                          const SizedBox(width: 18),
                          _SocialIcon(asset: 'assets/icons/apple.png'),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: _ClickableSentence(
                          text: "Already have an account? Sign in",
                          onTap: widget.onSignInTap,
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom wave clipper
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(
        size.width * 0.75, size.height - 40, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Modern styled text field for sign up
class _SignUpTextField extends StatefulWidget {
  final String hintText;
  final String iconPath;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  const _SignUpTextField({
    super.key,
    required this.hintText,
    required this.iconPath,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.suffixIcon,
  });

  @override
  State<_SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<_SignUpTextField> {
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
                widget.iconPath,
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

// Social icon button
class _SocialIcon extends StatelessWidget {
  final String asset;
  const _SocialIcon({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          asset,
          width: 24,
          height: 24,
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