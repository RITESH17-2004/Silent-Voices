import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignToSpeechPage extends StatefulWidget {
  const SignToSpeechPage({super.key});

  @override
  State<SignToSpeechPage> createState() => _SignToSpeechPageState();
}

class _SignToSpeechPageState extends State<SignToSpeechPage> {
  String recognizedText = '';

  void _simulateWebcamInput() {
    setState(() {
      recognizedText = 'Hello, how are you? (from sign)';
    });
  }

  void _simulatePlayAudio() {
    // Simulate playing audio (could show a snackbar or animation)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playing audio...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDB3A3),
      appBar: AppBar(
        title: const Text('Sign to Speech'),
        backgroundColor: const Color(0xFF314B6E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Start webcam
            _SignToSpeechBox(
              title: 'Start webcam',
              child: IconButton(
                icon: Icon(Icons.videocam, size: 36, color: Color(0xFF314B6E)),
                onPressed: _simulateWebcamInput,
                tooltip: 'Simulate Webcam Input',
              ),
            ),
            const SizedBox(height: 28),
            // 2. Converted text
            _SignToSpeechBox(
              title: 'Converted text',
              child: Text(
                recognizedText.isEmpty ? 'Waiting for sign input...' : recognizedText,
                style: TextStyle(
                  color: Color(0xFF607EA2),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            // 3. Listen to text
            _SignToSpeechBox(
              title: 'Listen to text',
              child: IconButton(
                icon: Icon(Icons.volume_up, size: 36, color: Color(0xFF607EA2)),
                onPressed: _simulatePlayAudio,
                tooltip: 'Simulate Play Audio',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignToSpeechBox extends StatelessWidget {
  final String title;
  final Widget child;
  const _SignToSpeechBox({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF314B6E),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
} 