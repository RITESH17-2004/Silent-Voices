import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import '../widgets/avatar_animation.dart';
import '../widgets/animated_wavy_background.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.onGetStarted});
  final VoidCallback onGetStarted;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Hindi', 'Marathi'];

  // Texts for each language
  final Map<String, Map<String, String>> _localizedTexts = {
    'English': {
      'appName': 'Silent Voices',
      'tagline': 'Talk with Your Heart. Be Understood in Signs.',
      'subtitle': 'A bridge for the speech and hearing impaired to communicate effortlessly.',
      'getStarted': 'Get Started',
      'username': 'Username',
      'email': 'someone@gmail.com',
      'password': 'Password',
    },
    'Hindi': {
      'appName': 'साइलेंट वॉयसेस',
      'tagline': 'दिल से बोलो, संकेतों में समझो।',
      'subtitle': 'बोलने और सुनने में असमर्थ लोगों के लिए संवाद का पुल।',
      'getStarted': 'शुरू करें',
      'username': 'उपयोगकर्ता नाम',
      'email': 'someone@gmail.com',
      'password': 'पासवर्ड',
    },
    'Marathi': {
      'appName': 'सायलेंट व्हॉइसेस',
      'tagline': 'मनाने बोला, संकेतांनी समजून घ्या.',
      'subtitle': 'बोलू व ऐकू न शकणाऱ्यांसाठी संवादाचा पूल.',
      'getStarted': 'सुरू करा',
      'username': 'वापरकर्ता नाव',
      'email': 'someone@gmail.com',
      'password': 'पासवर्ड',
    },
  };

  @override
  Widget build(BuildContext context) {
    final texts = _localizedTexts[_selectedLanguage]!;
    return Scaffold(
      backgroundColor: const Color(0xFFBDB3A3),
      body: Stack(
        children: [
          // Animated wavy background at the bottom
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedWavyBackground(),
          ),
          // Subtle blue accent shape
          Positioned(
            left: -120,
            top: 80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: const Color(0xFF2B4C6F).withOpacity(0.18),
                borderRadius: BorderRadius.circular(120),
              ),
            ),
          ),
          // Another subtle accent (optional)
          Positioned(
            right: -80,
            bottom: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFF2B4C6F).withOpacity(0.10),
                borderRadius: BorderRadius.circular(90),
              ),
            ),
          ),
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = constraints.maxWidth < 500 ? constraints.maxWidth * 0.92 : 400;
                return Container(
                  width: 330,
                  constraints: const BoxConstraints(minHeight: 400),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B4C6F),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.13),
                        blurRadius: 32,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Content
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Language selector (top right)
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.13),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.language, color: Colors.white, size: 20),
                                  const SizedBox(width: 6),
                                  DropdownButton<String>(
                                    value: _selectedLanguage,
                                    dropdownColor: const Color(0xFF2B4C6F),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                    underline: Container(),
                                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                                    items: _languages.map((lang) => DropdownMenuItem(
                                      value: lang,
                                      child: Text(lang, style: const TextStyle(color: Colors.white)),
                                    )).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _selectedLanguage = val!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Logo(size: 32),
                          const SizedBox(height: 28),
                          Text(
                            texts['appName']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            texts['tagline']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Connecting hearts, bridging silence, and empowering communication for all.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                      const SizedBox(height: 48),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.black.withOpacity(0.85);
                                }
                                return Colors.black;
                              }),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                              textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: widget.onGetStarted,
                            child: Text(texts['getStarted']!),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}