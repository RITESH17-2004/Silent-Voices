import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignToSpeechPage extends StatelessWidget {
  const SignToSpeechPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = screenWidth * 0.85;
    final webcamBoxHeight = screenHeight * 0.25;
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
                  // Webcam button
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
                    icon: Image.asset('assets/icons/camera.png', width: 28, height: 28, color: Colors.white),
                    label: const Text('Start Webcam'),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 32),
                  // Webcam Preview Box
                  Container(
                    width: containerWidth,
                    height: webcamBoxHeight,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Color(0xFF108EC2), width: 2),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Webcam preview will appear here',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
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
                  // Headphones Icon and Listen to Audio
                  Image.asset('assets/icons/headphone.png', width: 32, height: 32, color: Colors.white),
                  const SizedBox(height: 8),
                  const Text(
                    'Listen to Audio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
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