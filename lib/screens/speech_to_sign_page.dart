import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToSignPage extends StatefulWidget {
  const SpeechToSignPage({super.key});

  @override
  State<SpeechToSignPage> createState() => _SpeechToSignPageState();
}

class _SpeechToSignPageState extends State<SpeechToSignPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String recognizedText = '';
  String _selectedLocaleId = 'en-US'; // default

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'locale': 'en-US'},
    {'name': 'Hindi', 'locale': 'hi-IN'},
    {'name': 'Marathi', 'locale': 'mr-IN'},
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => setState(() {
          if (val == 'done') _isListening = false;
        }),
        onError: (val) => setState(() => _isListening = false),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            recognizedText = val.recognizedWords;
          }),
          localeId: _selectedLocaleId, // Use selected language
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDB3A3),
      appBar: AppBar(
        title: const Text('Speech to Sign'),
        backgroundColor: const Color(0xFF607EA2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Language dropdown
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: DropdownButtonFormField<String>(
                value: _selectedLocaleId,
                decoration: InputDecoration(
                  labelText: 'Choose Language',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _languages.map((lang) {
                  return DropdownMenuItem<String>(
                    value: lang['locale'],
                    child: Text(lang['name']!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLocaleId = value!;
                  });
                },
              ),
            ),
            // 1. Say your words
            _SpeechToSignBox(
              title: 'Say your words',
              child: IconButton(
                icon: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  size: 36,
                  color: Color(0xFF607EA2),
                ),
                onPressed: _listen,
                tooltip: _isListening ? 'Stop Listening' : 'Start Listening',
              ),
            ),
            const SizedBox(height: 28),
            // 2. Converted text
            _SpeechToSignBox(
              title: 'Converted text',
              child: Text(
                recognizedText.isEmpty ? 'Waiting for input...' : recognizedText,
                style: TextStyle(
                  color: Color(0xFF314B6E),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            // 3. Sign language display
            _SpeechToSignBox(
              title: 'Sign language display',
              child: Lottie.asset(
                'assets/animations/sign_avatar.json',
                height: 90,
                repeat: true,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpeechToSignBox extends StatelessWidget {
  final String title;
  final Widget child;
  const _SpeechToSignBox({required this.title, required this.child});

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
              color: Color(0xFF607EA2),
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