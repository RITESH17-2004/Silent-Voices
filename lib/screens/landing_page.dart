import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum AppLanguage { english, hindi, marathi }

const Map<AppLanguage, String> kTaglines = {
  AppLanguage.english: 'Talk with Your Heart. Be Understood in Signs.',
  AppLanguage.hindi: 'अपने दिल से बोलो। संकेतों में समझा जाए।',
  AppLanguage.marathi: 'मनापासून बोला. संकेतांमध्ये समजले जाईल.',
};

class LandingPage extends StatefulWidget {
  final VoidCallback? onSignIn;
  final VoidCallback? onSignUp;
  final VoidCallback? onGetStarted;
  const LandingPage({super.key, this.onSignIn, this.onSignUp, this.onGetStarted});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  AppLanguage _selectedLanguage = AppLanguage.english;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 4.0),
            child: PopupMenuButton<AppLanguage>(
              icon: SizedBox(
                height: 40,
                width: 40,
                child: Lottie.asset('assets/animations/globe.json'),
              ),
              tooltip: 'Change Language',
              color: Colors.black,
              onSelected: (AppLanguage lang) {
                setState(() {
                  _selectedLanguage = lang;
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: AppLanguage.english,
                  child: Text('English',style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: AppLanguage.hindi,
                  child: Text('Hindi',style: TextStyle(color: Colors.white)),
                ),
                const PopupMenuItem(
                  value: AppLanguage.marathi,
                  child: Text('Marathi',style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/background/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Page Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 10), // Reduced space below header
                  // Hero Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Center(child: Image.asset('assets/icons/logo.png', height: 185)),
                        const SizedBox(height: 2),
                        Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Colors.teal, Colors.blue, Colors.cyan],
                            ).createShader(bounds),
                            child: const Text(
                              'Silent Voices',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Center(
                            child: Text(
                              kTaglines[_selectedLanguage]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold, height: 1.3),
                            ),
                          ),
                        ),
                        const SizedBox(height: 150),
                        
                        const SizedBox(height: 16),
                        Center(
                          child: SizedBox(
                            width: 320,
                            child: GestureDetector(
                              onTap: widget.onSignIn,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: widget.onSignUp,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(color: Colors.white70, fontSize: 16),
                                ),
                                Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Hover scale effect widget for buttons
class _HoverScaleButton extends StatefulWidget {
  final Widget child;
  const _HoverScaleButton({required this.child});

  @override
  State<_HoverScaleButton> createState() => _HoverScaleButtonState();
}

class _HoverScaleButtonState extends State<_HoverScaleButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

// Custom widget for hover/tap effect on Sign up
class _SignUpText extends StatefulWidget {
  final VoidCallback? onTap;
  const _SignUpText({this.onTap});

  @override
  State<_SignUpText> createState() => _SignUpTextState();
}

class _SignUpTextState extends State<_SignUpText> {
  bool _hovering = false;
  bool _tapping = false;

  @override
  Widget build(BuildContext context) {
    final baseStyle = const TextStyle(color: Colors.white70, fontSize: 16);
    final signUpStyle = _hovering || _tapping
        ? const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
        : baseStyle;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Don't have an account? ", style: baseStyle),
        MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() { _hovering = false; _tapping = false; }),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _tapping = true),
            onTapUp: (_) => setState(() => _tapping = false),
            onTapCancel: () => setState(() => _tapping = false),
            onTap: widget.onTap,
            child: Text('Sign up', style: signUpStyle),
          ),
        ),
      ],
    );
  }
}