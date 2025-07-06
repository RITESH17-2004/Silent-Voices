// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:lottie/lottie.dart';
// // // // // import 'package:camera/camera.dart';

// // // // // class SignToSpeechPage extends StatefulWidget {
// // // // //   const SignToSpeechPage({Key? key}) : super(key: key);

// // // // //   @override
// // // // //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // // // // }

// // // // // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// // // // //   CameraController? _cameraController;
// // // // //   List<CameraDescription>? _cameras;
// // // // //   bool _isCameraInitialized = false;
// // // // //   bool _isCameraOn = false;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _initCameras();
// // // // //   }

// // // // //   Future<void> _initCameras() async {
// // // // //     try {
// // // // //       _cameras = await availableCameras();
// // // // //     } catch (e) {
// // // // //       // Handle error if needed
// // // // //     }
// // // // //   }

// // // // //   Future<void> _toggleCamera() async {
// // // // //     if (_isCameraOn) {
// // // // //       await _stopCamera();
// // // // //     } else {
// // // // //       await _startCamera();
// // // // //     }
// // // // //     setState(() {
// // // // //       _isCameraOn = !_isCameraOn;
// // // // //     });
// // // // //   }

// // // // //   Future<void> _startCamera() async {
// // // // //     if (_cameras == null || _cameras!.isEmpty) return;
// // // // //     _cameraController = CameraController(
// // // // //       _cameras![0],
// // // // //       ResolutionPreset.medium,
// // // // //       enableAudio: false,
// // // // //     );
// // // // //     try {
// // // // //       await _cameraController!.initialize();
// // // // //       setState(() {
// // // // //         _isCameraInitialized = true;
// // // // //       });
// // // // //     } catch (e) {
// // // // //       // Handle error if needed
// // // // //     }
// // // // //   }

// // // // //   Future<void> _stopCamera() async {
// // // // //     if (_cameraController != null) {
// // // // //       await _cameraController!.dispose();
// // // // //       _cameraController = null;
// // // // //       setState(() {
// // // // //         _isCameraInitialized = false;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _stopCamera();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final screenWidth = MediaQuery.of(context).size.width;
// // // // //     final screenHeight = MediaQuery.of(context).size.height;
// // // // //     return Scaffold(
// // // // //       body: Stack(
// // // // //         children: [
// // // // //           // Full background image
// // // // //           Positioned.fill(
// // // // //             child: Image.asset(
// // // // //               'assets/background/bg.png',
// // // // //               fit: BoxFit.cover,
// // // // //             ),
// // // // //           ),
// // // // //           // Webcam preview fills the screen
// // // // //           Positioned.fill(
// // // // //             child: _isCameraOn && _isCameraInitialized && _cameraController != null
// // // // //                 ? ClipRRect(
// // // // //                     borderRadius: BorderRadius.zero,
// // // // //                     child: CameraPreview(_cameraController!),
// // // // //                   )
// // // // //                 : Center(
// // // // //                     child: Text(
// // // // //                       'Webcam preview will appear here',
// // // // //                       style: TextStyle(
// // // // //                         color: Colors.white54,
// // // // //                         fontSize: 22,
// // // // //                         fontWeight: FontWeight.normal,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //           ),
// // // // //           // Globe animation in top-right
// // // // //           Positioned(
// // // // //             top: 32,
// // // // //             right: 20,
// // // // //             child: SizedBox(
// // // // //               width: 48,
// // // // //               height: 48,
// // // // //               child: Lottie.asset(
// // // // //                 'assets/animations/globe.json',
// // // // //                 fit: BoxFit.contain,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           // Start Webcam button at the top center
// // // // //           Positioned(
// // // // //             top: 40,
// // // // //             left: 0,
// // // // //             right: 0,
// // // // //             child: Center(
// // // // //               child: ElevatedButton.icon(
// // // // //                 style: ElevatedButton.styleFrom(
// // // // //                   backgroundColor: const Color(0xFF108EC2),
// // // // //                   foregroundColor: Colors.white,
// // // // //                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: 18),
// // // // //                   shape: RoundedRectangleBorder(
// // // // //                     borderRadius: BorderRadius.circular(30),
// // // // //                   ),
// // // // //                   textStyle: const TextStyle(
// // // // //                     fontSize: 20,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     letterSpacing: 1.1,
// // // // //                   ),
// // // // //                 ),
// // // // //                 icon: Image.asset('assets/icons/camera.png', width: 28, height: 28, color: Colors.white),
// // // // //                 label: Text(_isCameraOn ? 'Stop Webcam' : 'Start Webcam'),
// // // // //                 onPressed: _toggleCamera,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           // Message Box fixed at the bottom
// // // // //           Positioned(
// // // // //             left: 0,
// // // // //             right: 0,
// // // // //             bottom: 0,
// // // // //             child: Column(
// // // // //               mainAxisSize: MainAxisSize.min,
// // // // //               children: [
// // // // //                 Padding(
// // // // //                   padding: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
// // // // //                   child: Container(
// // // // //                     padding: const EdgeInsets.all(18),
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.white.withOpacity(0.15),
// // // // //                       borderRadius: BorderRadius.circular(18),
// // // // //                       border: Border.all(color: Colors.white24, width: 1.5),
// // // // //                     ),
// // // // //                     child: Column(
// // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                       mainAxisSize: MainAxisSize.min,
// // // // //                       children: [
// // // // //                         Row(
// // // // //                           children: [
// // // // //                             Image.asset('assets/icons/message.png', width: 22, height: 22, color: Colors.white),
// // // // //                             const SizedBox(width: 8),
// // // // //                             const Text(
// // // // //                               'MESSAGE BOX',
// // // // //                               style: TextStyle(
// // // // //                                 color: Colors.white,
// // // // //                                 fontWeight: FontWeight.bold,
// // // // //                                 fontSize: 16,
// // // // //                                 letterSpacing: 1.2,
// // // // //                               ),
// // // // //                             ),
// // // // //                           ],
// // // // //                         ),
// // // // //                         const SizedBox(height: 12),
// // // // //                         Container(
// // // // //                           width: double.infinity,
// // // // //                           padding: const EdgeInsets.all(12),
// // // // //                           decoration: BoxDecoration(
// // // // //                             color: const Color(0xFF108EC2),
// // // // //                             borderRadius: BorderRadius.circular(12),
// // // // //                           ),
// // // // //                           child: const Text(
// // // // //                             'YOUR MESSAGE WILL APPEAR HERE.',
// // // // //                             style: TextStyle(
// // // // //                               color: Colors.white,
// // // // //                               fontSize: 16,
// // // // //                               fontWeight: FontWeight.w600,
// // // // //                               letterSpacing: 1.1,
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 // Headphone button below the message box
// // // // //                 Center(
// // // // //                   child: GestureDetector(
// // // // //                     onTap: () {
// // // // //                       // Add your audio playback logic here
// // // // //                       print('Headphone icon tapped - play audio');
// // // // //                     },
// // // // //                     child: Container(
// // // // //                       padding: const EdgeInsets.all(10),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: const Color(0xFF108EC2),
// // // // //                         borderRadius: BorderRadius.circular(24),
// // // // //                         border: Border.all(color: Colors.white, width: 2),
// // // // //                       ),
// // // // //                       child: Image.asset(
// // // // //                         'assets/icons/headphone.png',
// // // // //                         width: 28,
// // // // //                         height: 28,
// // // // //                         color: Colors.white,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 16),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:camera/camera.dart';

// // // // // // // // class SignToSpeechPage extends StatefulWidget {
// // // // // // // //   const SignToSpeechPage({Key? key}) : super(key: key);

// // // // // // // //   @override
// // // // // // // //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // // // // // // // }

// // // // // // // // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// // // // // // // //   CameraController? _cameraController;
// // // // // // // //   List<CameraDescription>? _cameras;
// // // // // // // //   bool _isCameraInitialized = false;
// // // // // // // //   bool _isCameraOn = false;

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     _initCameras();
// // // // // // // //   }

// // // // // // // //   Future<void> _initCameras() async {
// // // // // // // //     try {
// // // // // // // //       _cameras = await availableCameras();
// // // // // // // //     } catch (e) {
// // // // // // // //       debugPrint("Camera error: $e");
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   Future<void> _toggleCamera() async {
// // // // // // // //     if (_isCameraOn) {
// // // // // // // //       await _stopCamera();
// // // // // // // //     } else {
// // // // // // // //       await _startCamera();
// // // // // // // //     }
// // // // // // // //     setState(() {
// // // // // // // //       _isCameraOn = !_isCameraOn;
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   Future<void> _startCamera() async {
// // // // // // // //     if (_cameras == null || _cameras!.isEmpty) return;

// // // // // // // //     final camera = _cameras!.firstWhere(
// // // // // // // //       (cam) => cam.lensDirection == CameraLensDirection.back,
// // // // // // // //       orElse: () => _cameras![0],
// // // // // // // //     );

// // // // // // // //     _cameraController = CameraController(
// // // // // // // //       camera,
// // // // // // // //       ResolutionPreset.max,
// // // // // // // //       enableAudio: false,
// // // // // // // //     );

// // // // // // // //     try {
// // // // // // // //       await _cameraController!.initialize();
// // // // // // // //       setState(() {
// // // // // // // //         _isCameraInitialized = true;
// // // // // // // //       });
// // // // // // // //     } catch (e) {
// // // // // // // //       debugPrint("Camera init error: $e");
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   Future<void> _stopCamera() async {
// // // // // // // //     if (_cameraController != null) {
// // // // // // // //       await _cameraController!.dispose();
// // // // // // // //       _cameraController = null;
// // // // // // // //       setState(() {
// // // // // // // //         _isCameraInitialized = false;
// // // // // // // //       });
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   void dispose() {
// // // // // // // //     _stopCamera();
// // // // // // // //     super.dispose();
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     final screenSize = MediaQuery.of(context).size;

// // // // // // // //     return Scaffold(
// // // // // // // //       body: Stack(
// // // // // // // //         children: [
// // // // // // // //           // Fullscreen Camera Preview
// // // // // // // //           if (_isCameraOn && _isCameraInitialized && _cameraController != null)
// // // // // // // //             Positioned.fill(
// // // // // // // //               child: CameraPreview(_cameraController!),
// // // // // // // //             )
// // // // // // // //           else
// // // // // // // //             Container(
// // // // // // // //               color: Colors.black,
// // // // // // // //               child: const Center(
// // // // // // // //                 child: Text(
// // // // // // // //                   'Camera preview will appear here',
// // // // // // // //                   style: TextStyle(
// // // // // // // //                     color: Colors.white54,
// // // // // // // //                     fontSize: 18,
// // // // // // // //                   ),
// // // // // // // //                 ),
// // // // // // // //               ),
// // // // // // // //             ),

// // // // // // // //           // Overlay: Top Center Button
// // // // // // // //           Positioned(
// // // // // // // //             top: 50,
// // // // // // // //             left: 0,
// // // // // // // //             right: 0,
// // // // // // // //             child: Center(
// // // // // // // //               child: ElevatedButton.icon(
// // // // // // // //                 style: ElevatedButton.styleFrom(
// // // // // // // //                   backgroundColor: const Color(0xFF108EC2),
// // // // // // // //                   foregroundColor: Colors.white,
// // // // // // // //                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
// // // // // // // //                   shape: RoundedRectangleBorder(
// // // // // // // //                     borderRadius: BorderRadius.circular(30),
// // // // // // // //                   ),
// // // // // // // //                   textStyle: const TextStyle(
// // // // // // // //                     fontSize: 18,
// // // // // // // //                     fontWeight: FontWeight.bold,
// // // // // // // //                   ),
// // // // // // // //                 ),
// // // // // // // //                 icon: const Icon(Icons.camera_alt),
// // // // // // // //                 label: Text(_isCameraOn ? 'Stop Webcam' : 'Start Webcam'),
// // // // // // // //                 onPressed: _toggleCamera,
// // // // // // // //               ),
// // // // // // // //             ),
// // // // // // // //           ),

// // // // // // // //           // Overlay: Bottom Message Box
// // // // // // // //           Positioned(
// // // // // // // //             left: 16,
// // // // // // // //             right: 16,
// // // // // // // //             bottom: 40,
// // // // // // // //             child: Container(
// // // // // // // //               padding: const EdgeInsets.all(16),
// // // // // // // //               decoration: BoxDecoration(
// // // // // // // //                 color: Colors.black.withOpacity(0.6),
// // // // // // // //                 borderRadius: BorderRadius.circular(16),
// // // // // // // //                 border: Border.all(color: Colors.white24, width: 1.5),
// // // // // // // //               ),
// // // // // // // //               child: Column(
// // // // // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // //                 children: const [
// // // // // // // //                   Text(
// // // // // // // //                     'MESSAGE BOX',
// // // // // // // //                     style: TextStyle(
// // // // // // // //                       color: Colors.white70,
// // // // // // // //                       fontWeight: FontWeight.bold,
// // // // // // // //                       fontSize: 16,
// // // // // // // //                       letterSpacing: 1.1,
// // // // // // // //                     ),
// // // // // // // //                   ),
// // // // // // // //                   SizedBox(height: 8),
// // // // // // // //                   Text(
// // // // // // // //                     'YOUR MESSAGE WILL APPEAR HERE.',
// // // // // // // //                     style: TextStyle(
// // // // // // // //                       color: Colors.white,
// // // // // // // //                       fontSize: 16,
// // // // // // // //                       fontWeight: FontWeight.w600,
// // // // // // // //                       letterSpacing: 1.1,
// // // // // // // //                     ),
// // // // // // // //                   ),
// // // // // // // //                 ],
// // // // // // // //               ),
// // // // // // // //             ),
// // // // // // // //           ),
// // // // // // // //         ],
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // // import 'dart:async';
// // // // // // // // import 'dart:convert';
// // // // // // // // import 'dart:io';
// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:camera/camera.dart';
// // // // // // // // import 'package:http/http.dart' as http;
// // // // // // // // import 'package:path_provider/path_provider.dart';

// // // // // // // // class SignToSpeechPage extends StatefulWidget {
// // // // // // // //   const SignToSpeechPage({Key? key}) : super(key: key);

// // // // // // // //   @override
// // // // // // // //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // // // // // // // }

// // // // // // // // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// // // // // // // //   late CameraController _controller;
// // // // // // // //   Timer? _timer;
// // // // // // // //   String _prediction = "Waiting...";
// // // // // // // //   final _client = http.Client();

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     _initCamera();
// // // // // // // //   }

// // // // // // // //   Future<void> _initCamera() async {
// // // // // // // //     final cameras = await availableCameras();
// // // // // // // //     final camera = cameras.first;

// // // // // // // //     _controller = CameraController(camera, ResolutionPreset.medium);
// // // // // // // //     await _controller.initialize();

// // // // // // // //     setState(() {});
// // // // // // // //     // _timer = Timer.periodic(const Duration(milliseconds: 500), (_) => _sendFrame());
// // // // // // // //     // _timer = Timer.periodic(Duration(milliseconds: 100), (_) => _sendFrameForPrediction());
// // // // // // // //     _timer = Timer.periodic(const Duration(milliseconds: 100), (_) => _sendFrame());


// // // // // // // //   }

// // // // // // // //   Future<void> _sendFrame() async {
// // // // // // // //     if (!_controller.value.isInitialized || _controller.value.isTakingPicture) return;

// // // // // // // //     try {
// // // // // // // //       final image = await _controller.takePicture();
// // // // // // // //       final bytes = await File(image.path).readAsBytes();
// // // // // // // //       final base64Image = base64Encode(bytes);

// // // // // // // //       final response = await _client.post(
// // // // // // // //         Uri.parse("http://127.0.0.1:5000/predict"), // ⚠️ Replace with your actual IP
// // // // // // // //         headers: {'Content-Type': 'application/json'},
// // // // // // // //         body: jsonEncode({'image': base64Image}),
// // // // // // // //       );

// // // // // // // //       if (response.statusCode == 200) {
// // // // // // // //         final result = jsonDecode(response.body);
// // // // // // // //         setState(() {
// // // // // // // //           _prediction = result['prediction'];
// // // // // // // //         });
// // // // // // // //       }
// // // // // // // //     } catch (e) {
// // // // // // // //       print("Error sending frame: $e");
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   void dispose() {
// // // // // // // //     _timer?.cancel();
// // // // // // // //     _controller.dispose();
// // // // // // // //     _client.close();
// // // // // // // //     super.dispose();
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       body: _controller.value.isInitialized
// // // // // // // //           ? Stack(
// // // // // // // //               children: [
// // // // // // // //                 CameraPreview(_controller),
// // // // // // // //                 Align(
// // // // // // // //                   alignment: Alignment.topCenter,
// // // // // // // //                   child: Container(
// // // // // // // //                     margin: const EdgeInsets.only(top: 50),
// // // // // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // // // // //                     decoration: BoxDecoration(
// // // // // // // //                       color: Colors.black.withOpacity(0.6),
// // // // // // // //                       borderRadius: BorderRadius.circular(12),
// // // // // // // //                     ),
// // // // // // // //                     child: Text(
// // // // // // // //                       _prediction,
// // // // // // // //                       style: const TextStyle(fontSize: 24, color: Colors.white),
// // // // // // // //                     ),
// // // // // // // //                   ),
// // // // // // // //                 ),
// // // // // // // //               ],
// // // // // // // //             )
// // // // // // // //           : const Center(child: CircularProgressIndicator()),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }
// // // // // // // import 'dart:async';
// // // // // // // import 'dart:convert';
// // // // // // // import 'dart:io';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:camera/camera.dart';
// // // // // // // import 'package:http/http.dart' as http;

// // // // // // // class SignToSpeechPage extends StatefulWidget {
// // // // // // //   const SignToSpeechPage({Key? key}) : super(key: key);

// // // // // // //   @override
// // // // // // //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // // // // // // }

// // // // // // // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// // // // // // //   late CameraController _controller;
// // // // // // //   Timer? _timer;
// // // // // // //   String _prediction = "Waiting...";
// // // // // // //   bool _isCapturing = false;
// // // // // // //   final _client = http.Client();

// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     _initCamera();
// // // // // // //   }

// // // // // // //   Future<void> _initCamera() async {
// // // // // // //     final cameras = await availableCameras();
// // // // // // //     final camera = cameras.first;

// // // // // // //     _controller = CameraController(camera, ResolutionPreset.medium);
// // // // // // //     await _controller.initialize();
// // // // // // //     setState(() {});
// // // // // // //   }

// // // // // // //   void _startCapturing() {
// // // // // // //     if (_isCapturing) return;
// // // // // // //     _timer = Timer.periodic(const Duration(milliseconds: 100), (_) => _sendFrame());
// // // // // // //     setState(() {
// // // // // // //       _isCapturing = true;
// // // // // // //     });
// // // // // // //   }

// // // // // // //   void _stopCapturing() {
// // // // // // //     _timer?.cancel();
// // // // // // //     setState(() {
// // // // // // //       _isCapturing = false;
// // // // // // //     });
// // // // // // //   }

// // // // // // //   Future<void> _sendFrame() async {
// // // // // // //     if (!_controller.value.isInitialized || _controller.value.isTakingPicture) return;

// // // // // // //     try {
// // // // // // //       final image = await _controller.takePicture();
// // // // // // //       final bytes = await File(image.path).readAsBytes();
// // // // // // //       final base64Image = base64Encode(bytes);

// // // // // // //       final response = await _client.post(
// // // // // // //         Uri.parse("http://127.0.0.1:5000/predict"), // If using adb reverse
// // // // // // //         headers: {'Content-Type': 'application/json'},
// // // // // // //         body: jsonEncode({'image': base64Image}),
// // // // // // //       );

// // // // // // //       if (response.statusCode == 200) {
// // // // // // //         final result = jsonDecode(response.body);
// // // // // // //         setState(() {
// // // // // // //           _prediction = result['prediction'];
// // // // // // //         });
// // // // // // //       }
// // // // // // //     } catch (e) {
// // // // // // //       print("Error sending frame: $e");
// // // // // // //     }
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     _timer?.cancel();
// // // // // // //     _controller.dispose();
// // // // // // //     _client.close();
// // // // // // //     super.dispose();
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       body: _controller.value.isInitialized
// // // // // // //           ? Stack(
// // // // // // //               children: [
// // // // // // //                 CameraPreview(_controller),
// // // // // // //                 Align(
// // // // // // //                   alignment: Alignment.topCenter,
// // // // // // //                   child: Container(
// // // // // // //                     margin: const EdgeInsets.only(top: 50),
// // // // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // // // //                     decoration: BoxDecoration(
// // // // // // //                       color: Colors.black.withOpacity(0.6),
// // // // // // //                       borderRadius: BorderRadius.circular(12),
// // // // // // //                     ),
// // // // // // //                     child: Text(
// // // // // // //                       _prediction,
// // // // // // //                       style: const TextStyle(fontSize: 24, color: Colors.white),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //                 Align(
// // // // // // //                   alignment: Alignment.bottomCenter,
// // // // // // //                   child: Padding(
// // // // // // //                     padding: const EdgeInsets.only(bottom: 40),
// // // // // // //                     child: ElevatedButton(
// // // // // // //                       onPressed: _isCapturing ? _stopCapturing : _startCapturing,
// // // // // // //                       style: ElevatedButton.styleFrom(
// // // // // // //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// // // // // // //                         backgroundColor: _isCapturing ? Colors.red : Colors.green,
// // // // // // //                       ),
// // // // // // //                       child: Text(
// // // // // // //                         _isCapturing ? "Stop Capturing" : "Start Capturing",
// // // // // // //                         style: const TextStyle(fontSize: 18),
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             )
// // // // // // //           : const Center(child: CircularProgressIndicator()),
// // // // // // //     );
// // // // // // // //   }
// // // // // // // // }


// // // // // // import 'dart:async';
// // // // // // import 'dart:convert';
// // // // // // import 'dart:io';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:camera/camera.dart';
// // // // // // import 'package:http/http.dart' as http;

// // // // // // class SignToSpeechPage extends StatefulWidget {
// // // // // //   const SignToSpeechPage({Key? key}) : super(key: key);

// // // // // //   @override
// // // // // //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // // // // // }

// // // // // // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// // // // // //   late CameraController _controller;
// // // // // //   Timer? _timer;
// // // // // //   String _prediction = "Waiting...";
// // // // // //   bool _isCapturing = false;
// // // // // //   final _client = http.Client();

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _initCamera();
// // // // // //   }

// // // // // //   // Future<void> _initCamera() async {
// // // // // //   //   final cameras = await availableCameras();
// // // // // //   //   final camera = cameras.first;

// // // // // //   //   _controller = CameraController(camera, ResolutionPreset.medium);
// // // // // //   //   await _controller.initialize();
// // // // // //   //   setState(() {});
// // // // // //   // }
// // // // // //   Future<void> _initCamera() async {
// // // // // //   final cameras = await availableCameras();
// // // // // //   final camera = cameras.first;

// // // // // //   _controller = CameraController(
// // // // // //     camera,
// // // // // //     ResolutionPreset.medium,
// // // // // //     enableAudio: false,
// // // // // //   );

// // // // // //   await _controller.initialize();

// // // // // //   // ✅ Turn off the flash immediately
// // // // // //   await _controller.setFlashMode(FlashMode.off);

// // // // // //   setState(() {});
// // // // // // }

// // // // // //   void _startCapturing() {
// // // // // //     if (_isCapturing) return;

// // // // // //     // Optional: reset the backend queue
// // // // // //     _client.post(
// // // // // //       Uri.parse("http://127.0.0.1:5000/reset"),
// // // // // //       headers: {'Content-Type': 'application/json'},
// // // // // //     );

// // // // // //     _timer = Timer.periodic(const Duration(milliseconds: 100), (_) => _sendFrame());
// // // // // //     setState(() {
// // // // // //       _isCapturing = true;
// // // // // //       _prediction = "Waiting...";
// // // // // //     });
// // // // // //   }

// // // // // //   void _stopCapturing() {
// // // // // //     _timer?.cancel();
// // // // // //     setState(() {
// // // // // //       _isCapturing = false;
// // // // // //     });
// // // // // //   }

// // // // // //   Future<void> _sendFrame() async {
// // // // // //     if (!_controller.value.isInitialized || _controller.value.isTakingPicture || !_isCapturing) return;

// // // // // //     try {
// // // // // //       final image = await _controller.takePicture();
// // // // // //       final bytes = await File(image.path).readAsBytes();
// // // // // //       final base64Image = base64Encode(bytes);

// // // // // //       final response = await _client.post(
// // // // // //         Uri.parse("http://127.0.0.1:5000/predict"),
// // // // // //         headers: {'Content-Type': 'application/json'},
// // // // // //         body: jsonEncode({'image': base64Image}),
// // // // // //       );

// // // // // //       if (response.statusCode == 200) {
// // // // // //         final result = jsonDecode(response.body);
// // // // // //         final prediction = result['prediction'];

// // // // // //         setState(() {
// // // // // //           _prediction = prediction;
// // // // // //         });

// // // // // //         // Stop if we have a real prediction
// // // // // //         if (prediction != "Waiting..." && prediction != "Nothing") {
// // // // // //           print("✅ Prediction received: $prediction — stopping capture");
// // // // // //           _stopCapturing();
// // // // // //         }
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print("⚠️ Error sending frame: $e");
// // // // // //     }
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _timer?.cancel();
// // // // // //     _controller.dispose();
// // // // // //     _client.close();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       body: _controller.value.isInitialized
// // // // // //           ? Stack(
// // // // // //               children: [
// // // // // //                 CameraPreview(_controller),
// // // // // //                 Align(
// // // // // //                   alignment: Alignment.topCenter,
// // // // // //                   child: Container(
// // // // // //                     margin: const EdgeInsets.only(top: 50),
// // // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // // //                     decoration: BoxDecoration(
// // // // // //                       color: Colors.black.withOpacity(0.6),
// // // // // //                       borderRadius: BorderRadius.circular(12),
// // // // // //                     ),
// // // // // //                     child: Text(
// // // // // //                       _prediction,
// // // // // //                       style: const TextStyle(fontSize: 24, color: Colors.white),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 Align(
// // // // // //                   alignment: Alignment.bottomCenter,
// // // // // //                   child: Padding(
// // // // // //                     padding: const EdgeInsets.only(bottom: 40),
// // // // // //                     child: ElevatedButton(
// // // // // //                       onPressed: _isCapturing ? _stopCapturing : _startCapturing,
// // // // // //                       style: ElevatedButton.styleFrom(
// // // // // //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// // // // // //                         backgroundColor: _isCapturing ? Colors.red : Colors.green,
// // // // // //                       ),
// // // // // //                       child: Text(
// // // // // //                         _isCapturing ? "Stop Capturing" : "Start Capturing",
// // // // // //                         style: const TextStyle(fontSize: 18),
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             )
// // // // // //           : const Center(child: CircularProgressIndicator()),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // import 'dart:async';
// // // // // // import 'dart:convert';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:camera/camera.dart';
// // // // // // import 'package:http/http.dart' as http;
// // // // // // import 'package:image/image.dart' as img;

// // // // // // class SignToSpeechPage extends StatefulWidget {
// // // // // //   const SignToSpeechPage({Key? key}) : super(key: key);

// // // // // //   @override
// // // // // //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // // // // // }

// // // // // // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// // // // // //   late CameraController _controller;
// // // // // //   String _prediction = "Waiting...";
// // // // // //   bool _isCapturing = false;
// // // // // //   bool _isProcessing = false;
// // // // // //   final _client = http.Client();

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     _initCamera();
// // // // // //   }

// // // // // //   Future<void> _initCamera() async {
// // // // // //     final cameras = await availableCameras();
// // // // // //     final camera = cameras.first;

// // // // // //     _controller = CameraController(
// // // // // //       camera,
// // // // // //       ResolutionPreset.medium,
// // // // // //       enableAudio: false,
// // // // // //     );

// // // // // //     await _controller.initialize();
// // // // // //     await _controller.setFlashMode(FlashMode.off);

// // // // // //     setState(() {});

// // // // // //     // Start image stream like a webcam
// // // // // //     await _controller.startImageStream((CameraImage image) {
// // // // // //       if (_isCapturing && !_isProcessing) {
// // // // // //         _isProcessing = true;
// // // // // //         _processCameraImage(image);
// // // // // //       }
// // // // // //     });
// // // // // //   }

// // // // // //   void _startCapturing() {
// // // // // //     if (_isCapturing) return;

// // // // // //     _client.post(
// // // // // //       Uri.parse("http://127.0.0.1:5000/reset"),
// // // // // //       headers: {'Content-Type': 'application/json'},
// // // // // //     );

// // // // // //     setState(() {
// // // // // //       _isCapturing = true;
// // // // // //       _prediction = "Waiting...";
// // // // // //     });
// // // // // //   }

// // // // // //   void _stopCapturing() {
// // // // // //     setState(() {
// // // // // //       _isCapturing = false;
// // // // // //     });
// // // // // //   }

// // // // // //   Future<void> _processCameraImage(CameraImage image) async {
// // // // // //     try {
// // // // // //       final img.Image rgbImage = _convertYUV420ToImage(image);
// // // // // //       final jpegBytes = img.encodeJpg(rgbImage, quality: 85);
// // // // // //       final base64Image = base64Encode(jpegBytes);

// // // // // //       final response = await _client.post(
// // // // // //         Uri.parse("http://127.0.0.1:5000/predict"),
// // // // // //         headers: {'Content-Type': 'application/json'},
// // // // // //         body: jsonEncode({'image': base64Image}),
// // // // // //       );

// // // // // //       if (response.statusCode == 200) {
// // // // // //         final result = jsonDecode(response.body);
// // // // // //         final prediction = result['prediction'];

// // // // // //         setState(() {
// // // // // //           _prediction = prediction;
// // // // // //         });

// // // // // //         if (prediction != "Waiting..." && prediction != "Nothing") {
// // // // // //           print("✅ Prediction received: $prediction — stopping capture");
// // // // // //           _stopCapturing();
// // // // // //         }
// // // // // //       }
// // // // // //     } catch (e) {
// // // // // //       print("⚠️ Error processing image: $e");
// // // // // //     } finally {
// // // // // //       _isProcessing = false;
// // // // // //     }
// // // // // //   }

// // // // // //   img.Image _convertYUV420ToImage(CameraImage image) {
// // // // // //     final int width = image.width;
// // // // // //     final int height = image.height;
// // // // // //     // final img.Image imgData = img.Image(width, height);
// // // // // //     final img.Image imgData = img.Image(width: width, height: height);


// // // // // //     final uvRowStride = image.planes[1].bytesPerRow;
// // // // // //     final uvPixelStride = image.planes[1].bytesPerPixel!;

// // // // // //     for (int y = 0; y < height; y++) {
// // // // // //       for (int x = 0; x < width; x++) {
// // // // // //         final int uvIndex = uvPixelStride * (x ~/ 2) + uvRowStride * (y ~/ 2);
// // // // // //         final int index = y * width + x;

// // // // // //         final yp = image.planes[0].bytes[index];
// // // // // //         final up = image.planes[1].bytes[uvIndex];
// // // // // //         final vp = image.planes[2].bytes[uvIndex];

// // // // // //         int r = (yp + 1.370705 * (vp - 128)).clamp(0, 255).toInt();
// // // // // //         int g = (yp - 0.337633 * (up - 128) - 0.698001 * (vp - 128)).clamp(0, 255).toInt();
// // // // // //         int b = (yp + 1.732446 * (up - 128)).clamp(0, 255).toInt();

// // // // // //         imgData.setPixelRgb(x, y, r, g, b);
// // // // // //       }
// // // // // //     }

// // // // // //     return imgData;
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _controller.dispose();
// // // // // //     _client.close();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       body: _controller.value.isInitialized
// // // // // //           ? Stack(
// // // // // //               children: [
// // // // // //                 CameraPreview(_controller),
// // // // // //                 Align(
// // // // // //                   alignment: Alignment.topCenter,
// // // // // //                   child: Container(
// // // // // //                     margin: const EdgeInsets.only(top: 50),
// // // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // // //                     decoration: BoxDecoration(
// // // // // //                       color: Colors.black.withOpacity(0.6),
// // // // // //                       borderRadius: BorderRadius.circular(12),
// // // // // //                     ),
// // // // // //                     child: Text(
// // // // // //                       _prediction,
// // // // // //                       style: const TextStyle(fontSize: 24, color: Colors.white),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 Align(
// // // // // //                   alignment: Alignment.bottomCenter,
// // // // // //                   child: Padding(
// // // // // //                     padding: const EdgeInsets.only(bottom: 40),
// // // // // //                     child: ElevatedButton(
// // // // // //                       onPressed: _isCapturing ? _stopCapturing : _startCapturing,
// // // // // //                       style: ElevatedButton.styleFrom(
// // // // // //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// // // // // //                         backgroundColor: _isCapturing ? Colors.red : Colors.green,
// // // // // //                       ),
// // // // // //                       child: Text(
// // // // // //                         _isCapturing ? "Stop Capturing" : "Start Capturing",
// // // // // //                         style: const TextStyle(fontSize: 18),
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             )
// // // // // //           : const Center(child: CircularProgressIndicator()),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'dart:async';
// // // // // import 'dart:convert';
// // // // // import 'dart:io';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:camera/camera.dart';
// // // // // import 'package:http/http.dart' as http;

// // // // // class SignToSpeechPage extends StatefulWidget {
// // // // //   const SignToSpeechPage({Key? key}) : super(key: key);

// // // // //   @override
// // // // //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // // // // }

// // // // // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// // // // //   late CameraController _controller;
// // // // //   Timer? _timer;
// // // // //   String _prediction = "Waiting...";
// // // // //   bool _isCapturing = false;
// // // // //   final _client = http.Client();

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _initCamera();
// // // // //   }

// // // // //   // Future<void> _initCamera() async {
// // // // //   //   final cameras = await availableCameras();
// // // // //   //   final camera = cameras.first;

// // // // //   //   _controller = CameraController(camera, ResolutionPreset.medium);
// // // // //   //   await _controller.initialize();
// // // // //   //   setState(() {});
// // // // //   // }
// // // // //   Future<void> _initCamera() async {
// // // // //   final cameras = await availableCameras();
// // // // //   // final camera = cameras.first;

// // // // //   // _controller = CameraController(
// // // // //   //   camera,
// // // // //   //   ResolutionPreset.medium,
// // // // //   //   enableAudio: false,
// // // // //   // );

// // // // //   await _controller.initialize();

// // // // //   // ✅ Turn off the flash immediately
// // // // //   await _controller.setFlashMode(FlashMode.off);

// // // // //   setState(() {});
// // // // // }

// // // // //   void _startCapturing() async {
// // // // //   if (_isCapturing) return;

// // // // //   // ✅ Replace localhost with your LAPTOP IP address on same Wi-Fi
// // // // //   final uri = Uri.parse("http://192.168.1.5:5000/start");

// // // // //   final request = http.Request('GET', uri);
// // // // //   final response = await request.send();

// // // // //   setState(() {
// // // // //     _isCapturing = true;
// // // // //     _prediction = "Waiting...";
// // // // //   });

// // // // //   // ✅ Listen to server-sent events (SSE)
// // // // //   response.stream.transform(utf8.decoder).listen((data) {
// // // // //     if (data.startsWith("data:")) {
// // // // //       final sign = data.replaceAll("data:", "").trim();

// // // // //       setState(() {
// // // // //         _prediction = sign;
// // // // //       });

// // // // //       print("🔮 Prediction: $sign");
// // // // //     }
// // // // //   });
// // // // // }


// // // // //   void _stopCapturing() {
// // // // //     _timer?.cancel();
// // // // //     setState(() {
// // // // //       _isCapturing = false;
// // // // //     });
// // // // //   }

// // // // //   // Future<void> _sendFrame() async {
// // // // //   //   if (!_controller.value.isInitialized || _controller.value.isTakingPicture || !_isCapturing) return;

// // // // //   //   try {
// // // // //   //     final image = await _controller.takePicture();
// // // // //   //     final bytes = await File(image.path).readAsBytes();
// // // // //   //     final base64Image = base64Encode(bytes);

// // // // //   //     final response = await _client.post(
// // // // //   //       Uri.parse("http://127.0.0.1:5000/predict"),
// // // // //   //       headers: {'Content-Type': 'application/json'},
// // // // //   //       body: jsonEncode({'image': base64Image}),
// // // // //   //     );

// // // // //   //     if (response.statusCode == 200) {
// // // // //   //       final result = jsonDecode(response.body);
// // // // //   //       final prediction = result['prediction'];

// // // // //   //       setState(() {
// // // // //   //         _prediction = prediction;
// // // // //   //       });

// // // // //   //       // Stop if we have a real prediction
// // // // //   //       if (prediction != "Waiting..." && prediction != "Nothing") {
// // // // //   //         print("✅ Prediction received: $prediction — stopping capture");
// // // // //   //         _stopCapturing();
// // // // //   //       }
// // // // //   //     }
// // // // //   //   } catch (e) {
// // // // //   //     print("⚠️ Error sending frame: $e");
// // // // //   //   }
// // // // //   // }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _timer?.cancel();
// // // // //     _controller.dispose();
// // // // //     _client.close();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       body: _controller.value.isInitialized
// // // // //           ? Stack(
// // // // //               children: [
// // // // //                 CameraPreview(_controller),
// // // // //                 Align(
// // // // //                   alignment: Alignment.topCenter,
// // // // //                   child: Container(
// // // // //                     margin: const EdgeInsets.only(top: 50),
// // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.black.withOpacity(0.6),
// // // // //                       borderRadius: BorderRadius.circular(12),
// // // // //                     ),
// // // // //                     child: Text(
// // // // //                       _prediction,
// // // // //                       style: const TextStyle(fontSize: 24, color: Colors.white),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 Align(
// // // // //                   alignment: Alignment.bottomCenter,
// // // // //                   child: Padding(
// // // // //                     padding: const EdgeInsets.only(bottom: 40),
// // // // //                     child: ElevatedButton(
// // // // //                       onPressed: _isCapturing ? _stopCapturing : _startCapturing,
// // // // //                       style: ElevatedButton.styleFrom(
// // // // //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// // // // //                         backgroundColor: _isCapturing ? Colors.red : Colors.green,
// // // // //                       ),
// // // // //                       child: Text(
// // // // //                         _isCapturing ? "Stop Capturing" : "Start Capturing",
// // // // //                         style: const TextStyle(fontSize: 18),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             )
// // // // //           : const Center(child: CircularProgressIndicator()),
// // // // //     );
// // // // //   }
// // // // // }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class SignToSpeechPage extends StatefulWidget {
// //   const SignToSpeechPage({Key? key}) : super(key: key);

// //   @override
// //   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// // }

// // class _SignToSpeechPageState extends State<SignToSpeechPage> {
// //   String _prediction = "Waiting...";
// //   bool _isCapturing = false;
// //   late http.Client _client;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _client = http.Client();
// //   }

// //   void _startCapturing() async {
// //     if (_isCapturing) return;

// //     try {
// //       final uri = Uri.parse("http://127.0.0.1:5000/start"); // ✅ Will work with ADB reverse

// //       final request = http.Request('GET', uri);
// //       final response = await _client.send(request);

// //       setState(() {
// //         _isCapturing = true;
// //         _prediction = "Waiting...";
// //       });

// //       // ✅ Listen to streamed predictions
// //       response.stream.transform(utf8.decoder).listen((data) {
// //         if (data.startsWith("data:")) {
// //           final sign = data.replaceAll("data:", "").trim();
// //           setState(() {
// //             _prediction = sign;
// //           });

// //           print("🔮 Prediction: $sign");
// //         }
// //       });
// //     } catch (e) {
// //       print("⚠️ Error connecting to backend: $e");
// //       setState(() {
// //         _prediction = "Error connecting to backend";
// //         _isCapturing = false;
// //       });
// //     }
// //   }

// //   void _stopCapturing() async {
// //   try {
// //     final uri = Uri.parse("http://127.0.0.1:5000/stop");
// //     await _client.post(uri);

// //     print("🛑 Sent stop request to backend");
// //   } catch (e) {
// //     print("⚠️ Error stopping capture: $e");
// //   }

// //   setState(() {
// //     _isCapturing = false;
// //     _prediction = "Stopped";
// //   });
// // }

// //   @override
// //   void dispose() {
// //     _client.close();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           // Optional camera background (black screen or your own image)
// //           Container(color: Colors.black),

// //           // Prediction overlay
// //           Align(
// //             alignment: Alignment.topCenter,
// //             child: Container(
// //               margin: const EdgeInsets.only(top: 60),
// //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //               decoration: BoxDecoration(
// //                 color: Colors.black.withOpacity(0.6),
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Text(
// //                 _prediction,
// //                 style: const TextStyle(fontSize: 24, color: Colors.white),
// //               ),
// //             ),
// //           ),

// //           // Start/Stop button
// //           Align(
// //             alignment: Alignment.bottomCenter,
// //             child: Padding(
// //               padding: const EdgeInsets.only(bottom: 40),
// //               child: ElevatedButton(
// //                 onPressed: _isCapturing ? _stopCapturing : _startCapturing,
// //                 style: ElevatedButton.styleFrom(
// //                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                   backgroundColor: _isCapturing ? Colors.red : Colors.green,
// //                 ),
// //                 child: Text(
// //                   _isCapturing ? "Stop Capturing" : "Start Capturing",
// //                   style: const TextStyle(fontSize: 18),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class SignToSpeechPage extends StatefulWidget {
//   const SignToSpeechPage({Key? key}) : super(key: key);

//   @override
//   State<SignToSpeechPage> createState() => _SignToSpeechPageState();
// }

// class _SignToSpeechPageState extends State<SignToSpeechPage> {
//   String _prediction = "Waiting...";
//   bool _isCapturing = false;
//   late http.Client _client;

//   @override
//   void initState() {
//     super.initState();
//     _client = http.Client();
//   }

//   void _startCapturing() async {
//     if (_isCapturing) return;

//     try {
//       final uri = Uri.parse("http://127.0.0.1:5000/start"); // ✅ Will work with ADB reverse

//       final request = http.Request('GET', uri);
//       final response = await _client.send(request);

//       setState(() {
//         _isCapturing = true;
//         _prediction = "Waiting...";
//       });

//       // ✅ Listen to streamed predictions
//       response.stream.transform(utf8.decoder).listen((data) {
//         if (data.startsWith("data:")) {
//           final sign = data.replaceAll("data:", "").trim();
//           setState(() {
//             _prediction = sign;
//           });

//           print("🔮 Prediction: $sign");
//         }
//       });
//     } catch (e) {
//       print("⚠️ Error connecting to backend: $e");
//       setState(() {
//         _prediction = "Error connecting to backend";
//         _isCapturing = false;
//       });
//     }
//   }

//   void _stopCapturing() async {
//     try {
//       final uri = Uri.parse("http://127.0.0.1:5000/stop");
//       await _client.post(uri);

//       print("🛑 Sent stop request to backend");
//     } catch (e) {
//       print("⚠️ Error stopping capture: $e");
//     }

//     setState(() {
//       _isCapturing = false;
//       _prediction = "Stopped";
//     });
//   }

//   @override
//   void dispose() {
//     _client.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF0F0F23), // Dark blue
//               Color(0xFF1A1A2E), // Darker blue
//               Color(0xFF16213E), // Deep blue
//               Color(0xFF0F3460), // Neon blue base
//             ],
//             stops: [0.0, 0.3, 0.7, 1.0],
//           ),
//         ),
//         child: Stack(
//           children: [
//             // Animated background effects
//             Positioned(
//               top: 100,
//               right: -50,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [
//                       const Color(0xFF00F5FF).withOpacity(0.1),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 200,
//               left: -100,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [
//                       const Color(0xFF00F5FF).withOpacity(0.08),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Main content
//             SafeArea(
//               child: Column(
//                 children: [
//                   // Header
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         const Text(
//                           'Sign to Speech',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 1.5,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Real-time sign language recognition',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white.withOpacity(0.7),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const Spacer(),

//                   // Prediction Message Box
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             const Color(0xFF00F5FF).withOpacity(0.15),
//                             const Color(0xFF0080FF).withOpacity(0.1),
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: const Color(0xFF00F5FF).withOpacity(0.3),
//                           width: 1.5,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color(0xFF00F5FF).withOpacity(0.2),
//                             blurRadius: 20,
//                             spreadRadius: 2,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.mic,
//                             size: 40,
//                             color: _isCapturing 
//                                 ? const Color(0xFF00F5FF) 
//                                 : Colors.white.withOpacity(0.5),
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Prediction',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white.withOpacity(0.8),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 12,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                 color: const Color(0xFF00F5FF).withOpacity(0.2),
//                                 width: 1,
//                               ),
//                             ),
//                             child: Text(
//                               _prediction,
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const Spacer(),

//                   // Control Button
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 40),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         gradient: LinearGradient(
//                           colors: _isCapturing 
//                               ? [
//                                   const Color(0xFFFF4444),
//                                   const Color(0xFFCC0000),
//                                 ]
//                               : [
//                                   const Color(0xFF00F5FF),
//                                   const Color(0xFF0080FF),
//                                 ],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: (_isCapturing 
//                                 ? const Color(0xFFFF4444) 
//                                 : const Color(0xFF00F5FF)).withOpacity(0.4),
//                             blurRadius: 20,
//                             spreadRadius: 2,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: ElevatedButton(
//                         onPressed: _isCapturing ? _stopCapturing : _startCapturing,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.transparent,
//                           shadowColor: Colors.transparent,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 40,
//                             vertical: 16,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               _isCapturing ? Icons.stop : Icons.play_arrow,
//                               size: 24,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               _isCapturing ? "Stop Capturing" : "Start Capturing",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignToSpeechPage extends StatefulWidget {
  const SignToSpeechPage({Key? key}) : super(key: key);

  @override
  State<SignToSpeechPage> createState() => _SignToSpeechPageState();
}

class _SignToSpeechPageState extends State<SignToSpeechPage> {
  String _prediction = "Waiting...";
  bool _isCapturing = false;
  late http.Client _client;

  @override
  void initState() {
    super.initState();
    _client = http.Client();
  }

  void _startCapturing() async {
    if (_isCapturing) return;

    try {
      final uri = Uri.parse("http://127.0.0.1:5000/start"); // ✅ Will work with ADB reverse

      final request = http.Request('GET', uri);
      final response = await _client.send(request);

      setState(() {
        _isCapturing = true;
        _prediction = "Waiting...";
      });

      // ✅ Listen to streamed predictions
      response.stream.transform(utf8.decoder).listen((data) {
        if (data.startsWith("data:")) {
          final sign = data.replaceAll("data:", "").trim();
          setState(() {
            _prediction = sign;
          });

          print("🔮 Prediction: $sign");
        }
      });
    } catch (e) {
      print("⚠️ Error connecting to backend: $e");
      setState(() {
        _prediction = "Error connecting to backend";
        _isCapturing = false;
      });
    }
  }

  void _stopCapturing() async {
    try {
      final uri = Uri.parse("http://127.0.0.1:5000/stop");
      await _client.post(uri);

      print("🛑 Sent stop request to backend");
    } catch (e) {
      print("⚠️ Error stopping capture: $e");
    }

    setState(() {
      _isCapturing = false;
      _prediction = "Stopped";
    });
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F0F23), // Dark blue
              Color(0xFF1A1A2E), // Darker blue
              Color(0xFF16213E), // Deep blue
              Color(0xFF0F3460), // Neon blue base
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background effects
            Positioned(
              top: 100,
              right: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00F5FF).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              left: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00F5FF).withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Sign to Speech',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Real-time sign language recognition',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Prediction Message Box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFF00F5FF).withOpacity(0.15),
                            const Color(0xFF0080FF).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF00F5FF).withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00F5FF).withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Prediction',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF00F5FF).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              _prediction,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Control Button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          colors: _isCapturing 
                              ? [
                                  const Color(0xFFFF4444),
                                  const Color(0xFFCC0000),
                                ]
                              : [
                                  const Color(0xFF00F5FF),
                                  const Color(0xFF0080FF),
                                ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (_isCapturing 
                                ? const Color(0xFFFF4444) 
                                : const Color(0xFF00F5FF)).withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isCapturing ? _stopCapturing : _startCapturing,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          _isCapturing ? "Stop Capturing" : "Start Capturing",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}