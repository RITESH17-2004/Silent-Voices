import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'speech_to_sign_page.dart';
import 'sign_to_speech_page.dart';
import 'info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInImage;
  late Animation<double> _fadeInCard;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeInImage = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOut));
    _fadeInCard = CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Color palette
    const chineseBlack = Color(0xFF0E141C);
    const policeBlue = Color(0xFF314B6E);
    const rackley = Color(0xFF607EA2);
    const weldonBlue = Color(0xFF8197AC);
    const silverPink = Color(0xFFBDB3A3);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0E141C), // Chinese Black
              Color(0xFF314B6E), // Police Blue
              Color(0xFF607EA2), // Rackley
              Color(0xFFBDB3A3), // Silver Pink
            ],
            stops: [0.0, 0.4, 0.8, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Info button
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.info_outline, color: Color(0xFFBDB3A3), size: 30),
                  tooltip: 'About',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const InfoPage()),
                    );
                  },
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated large illustration
                      FadeTransition(
                        opacity: _fadeInImage,
                        child: Container(
                          height: 340,
                          width: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: policeBlue.withOpacity(0.5),
                                blurRadius: 40,
                                offset: const Offset(0, 16),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.asset(
                              'assets/illustrations/home_illustration.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Glassmorphic card with animation
                      FadeTransition(
                        opacity: _fadeInCard,
                        child: GlassmorphicCard(
                          child: Column(
                            children: [
                              Text(
                                "Welcome to Silent Voices",
                                style: TextStyle(
                                  color: silverPink,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Bridge the gap between speech and sign language. Start your journey now!",
                                style: TextStyle(
                                  color: weldonBlue,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // Navigation buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _HomeButton(
                              label: "Sign to Speech",
                              color: rackley,
                              textColor: chineseBlack,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const SignToSpeechPage()),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _HomeButton(
                              label: "Speech to Sign",
                              color: silverPink,
                              textColor: policeBlue,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const SpeechToSignPage()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Page indicator dots (optional, for onboarding feel)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _Dot(isActive: true, color: rackley),
                          const SizedBox(width: 8),
                          _Dot(isActive: false, color: silverPink),
                          const SizedBox(width: 8),
                          _Dot(isActive: false, color: weldonBlue),
                        ],
                      ),
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

// Glassmorphic card widget
class GlassmorphicCard extends StatelessWidget {
  final Widget child;
  const GlassmorphicCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.13),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
          ),
          child: child,
        ),
      ),
    );
  }
}

// Home button widget
class _HomeButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _HomeButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        elevation: 10,
        shadowColor: color.withOpacity(0.4),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: textColor,
        ),
      ),
    );
  }
}

// Page indicator dot
class _Dot extends StatelessWidget {
  final bool isActive;
  final Color color;
  const _Dot({required this.isActive, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      width: isActive ? 16 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _AnimatedHomeButton extends StatelessWidget {
  final String label;
  final String lottieAsset;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedHomeButton({
    required this.label,
    required this.lottieAsset,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 170,
        height: 220,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              lottieAsset,
              height: 90,
              repeat: true,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 18),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 