import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:camera/camera.dart';

class SignToSpeechPage extends StatefulWidget {
  const SignToSpeechPage({Key? key}) : super(key: key);

  @override
  State<SignToSpeechPage> createState() => _SignToSpeechPageState();
}

class _SignToSpeechPageState extends State<SignToSpeechPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isCameraOn = false;

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    try {
      _cameras = await availableCameras();
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> _toggleCamera() async {
    if (_isCameraOn) {
      await _stopCamera();
    } else {
      await _startCamera();
    }
    setState(() {
      _isCameraOn = !_isCameraOn;
    });
  }

  Future<void> _startCamera() async {
    if (_cameras == null || _cameras!.isEmpty) return;
    _cameraController = CameraController(
      _cameras![0],
      ResolutionPreset.medium,
      enableAudio: false,
    );
    try {
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> _stopCamera() async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
      _cameraController = null;
      setState(() {
        _isCameraInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    _stopCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          // Webcam preview fills the screen
          Positioned.fill(
            child: _isCameraOn && _isCameraInitialized && _cameraController != null
                ? ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: CameraPreview(_cameraController!),
                  )
                : Center(
                    child: Text(
                      'Webcam preview will appear here',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
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
          // Start Webcam button at the top center
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF108EC2),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 18),
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
                label: Text(_isCameraOn ? 'Stop Webcam' : 'Start Webcam'),
                onPressed: _toggleCamera,
              ),
            ),
          ),
          // Message Box fixed at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                            color: const Color(0xFF108EC2),
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
                ),
                // Headphone button below the message box
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Add your audio playback logic here
                      print('Headphone icon tapped - play audio');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF108EC2),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Image.asset(
                        'assets/icons/headphone.png',
                        width: 28,
                        height: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}