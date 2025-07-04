import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SpeechToSignPage extends StatelessWidget {
  const SpeechToSignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = screenWidth * 0.85;
    final avatarSize = screenWidth * 0.3;
    final buttonPadding = EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 18);
    return Scaffold(
      body: Stack(
        children: [
          // Full background image
          Positioned.fill(
            child: Image.asset(
              'assets/background/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Globe animation in top-right
          Positioned(
            top: 32,
            right: 20,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Lottie.asset(
                'assets/animations/globe.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Mic button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF108EC2),
                      foregroundColor: Colors.white,
                      padding: buttonPadding,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    icon: Image.asset('assets/icons/mike.png', width: 28, height: 28),
                    label: const Text('Tap the mic and speak'),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 32),
                  // Message Box
                  Container(
                    width: containerWidth,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icons/message.png', width: 22, height: 22, color: Colors.white),
                            const SizedBox(width: 8),
                            const Text(
                              'MESSAGE BOX',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'YOUR MESSAGE WILL APPEAR HERE.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // 3D Avatar
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Color(0xFF108EC2), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF108EC2).withOpacity(0.3),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: avatarSize * 0.42,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.person, size: 60, color: Color(0xFF108EC2)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '3D Avatar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}