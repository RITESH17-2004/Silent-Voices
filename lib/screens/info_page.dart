import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDB3A3),
      appBar: AppBar(
        title: const Text('About Silent Voices'),
        backgroundColor: const Color(0xFF607EA2),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/hello.json',
                    height: 120,
                    repeat: true,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Silent Voices',
                    style: TextStyle(
                      color: Color(0xFF314B6E),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Silent Voices is designed to bridge the gap between hearing and deaf communities. It enables seamless two-way communication by converting speech to sign language and vice versa.',
                    style: TextStyle(
                      color: Color(0xFF607EA2),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'How it works:',
                      style: TextStyle(
                        color: Color(0xFF314B6E),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '• Real-time speech-to-sign and sign-to-text conversion\n• Empowers both hearing and deaf individuals to communicate easily\n• Uses modern technology to foster inclusivity',
                    style: TextStyle(
                      color: Color(0xFF607EA2),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Main Features:',
                      style: TextStyle(
                        color: Color(0xFF314B6E),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('• Real-time Speech-to-Text ➝ Sign conversion', style: TextStyle(color: Color(0xFF607EA2), fontSize: 16)),
                      Text('• Real-time Sign ➝ Text conversion', style: TextStyle(color: Color(0xFF607EA2), fontSize: 16)),
                      Text('• Clean, accessible interface', style: TextStyle(color: Color(0xFF607EA2), fontSize: 16)),
                      Text('• Support for both typed and spoken input', style: TextStyle(color: Color(0xFF607EA2), fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 