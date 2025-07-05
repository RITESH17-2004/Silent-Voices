import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'speech_to_sign_page.dart';
import 'sign_to_speech_page.dart';
import 'info_page.dart';
import 'package:flutter/foundation.dart';
import 'package:silent_voices/screens/profile_page.dart';
import 'settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;
  int? _hoveredButton; // For web/desktop hover
  int? _hoveredNav; // For web/desktop hover
  late AnimationController _glowController;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        final userData = await _authService.getUserData(currentUser.uid);
        if (userData != null) {
          setState(() {
            _userName = userData['name'] ?? 'User';
          });
        }
      }
    } catch (e) {
      // If there's an error, use default greeting
      setState(() {
        _userName = 'User';
      });
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Colors
    const backgroundColor = Color(0xFF0B1C2C);
    const topCardColor = Color(0xFF0B1C2C);
    const aboutCardColor = Color(0xE6142336); // #142336, 90% opacity
    const greetingColor = Color(0xFFE5ECF4);
    const subtextColor = Color(0xFFA5B5C3);
    const aboutTextColor = Color(0xFFB0C5D6);
    const navBarColor = Color(0xFF0F172A);
    const navActive = Color(0xFF3B82F6);
    const navInactive = Color(0xFF64748B);
    const blueGradientStart = Color(0xFF1E3A8A);
    const blueGradientEnd = Color(0xFF3B82F6);
    const grayGradientStart = Color(0xFF9CA3AF);
    const grayGradientEnd = Color(0xFFE5E7EB);
    const poppins = 'Poppins';

    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;
    final isLarge = size.width > 500;
    final horizontalPadding = isSmall ? 8.0 : 16.0;
    final topCardHeight = isSmall ? 120.0 : (isLarge ? 220.0 : 180.0);
    final cardPadding = isSmall ? 16.0 : 28.0;
    final betweenCardGap = isSmall ? 8.0 : 16.0;
    final greetingFont = isSmall ? 18.0 : (isLarge ? 32.0 : 24.0);
    final subtextFont = isSmall ? 12.0 : (isLarge ? 18.0 : 15.0);
    final aboutFont = isSmall ? 11.5 : 15.0;
    final imageSize = isSmall ? 90.0 : 140.0;
    final navIconSize = 28.0;

    // Try to use neon_hands.png as background if it exists
    final backgroundDecoration = BoxDecoration(
      color: const Color(0xFF0C0F1E),
    );

    Widget buildButton(int index, String imagePath) {
      final hovered = _hoveredButton == index;
      return MouseRegion(
        onEnter: kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux
            ? (_) => setState(() => _hoveredButton = index)
            : null,
        onExit: kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux
            ? (_) => setState(() => _hoveredButton = null)
            : null,
        child: AnimatedScale(
          scale: hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignToSpeechPage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SpeechToSignPage()),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              height: isSmall ? 110 : 170,
              decoration: BoxDecoration(
                gradient: index == 0
                    ? const LinearGradient(
                        colors: [Color(0xFF4FC3F7), Color(0xFF1976D2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [grayGradientStart, grayGradientEnd],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  height: index == 0 ? (isSmall ? 150 : 230) : (isSmall ? 100 : 160),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget buildNavIcon(int index, String assetPath) {
      final isActive = _selectedIndex == index;
      final hovered = _hoveredNav == index;
      return MouseRegion(
        onEnter: kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux
            ? (_) => setState(() => _hoveredNav = index)
            : null,
        onExit: kIsWeb || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux
            ? (_) => setState(() => _hoveredNav = null)
            : null,
        child: AnimatedScale(
          scale: hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 120),
          child: Container(
            decoration: isActive
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: navActive.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  )
                : null,
            child: Image.asset(
              assetPath,
              width: navIconSize,
              height: navIconSize,
              color: isActive ? navActive : navInactive,
              colorBlendMode: BlendMode.srcIn,
              opacity: AlwaysStoppedAnimation(isActive ? 1.0 : 0.5),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            // Home content
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: backgroundDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Card (Greeting)
                  Padding(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, betweenCardGap / 2),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: isSmall ? 90.0 : 120.0,
                        maxHeight: isLarge ? 180.0 : 140.0,
                      ),
                      decoration: BoxDecoration(
                        color: topCardColor,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage('assets/illustrations/signs.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.28),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(cardPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/illustrations/logo1.png',
                              height: (size.width * 0.32).clamp(60.0, 120.0),
                              width: (size.width * 0.32).clamp(60.0, 120.0),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hello, ${_userName.isNotEmpty ? _userName.split(' ').first : 'User'}! 👋',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Color(0xFF4FC3F7),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Your bridge between speech and sign language.',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Color(0xFFB0BEC5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Action Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: betweenCardGap / 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(0, 'assets/illustrations/sign to speech.png'),
                        ),
                        SizedBox(width: betweenCardGap),
                        Expanded(
                          child: buildButton(1, 'assets/illustrations/speech to sign.png'),
                        ),
                      ],
                    ),
                  ),
                  // About the App Section
                  Expanded(
                    child: AboutSection(),
                  ),
                ],
              ),
            ),
            // Profile Page
            ProfilePage(),
            // Settings Page
            const SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        isSmall: isSmall,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.85),
              Colors.white.withOpacity(0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white.withOpacity(0.22), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: textColor,
              letterSpacing: 1.1,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
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

class AboutSection extends StatefulWidget {
  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;
    final cardWidth = size.width * 0.9;
    return Center(
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Container(
          width: cardWidth,
          margin: EdgeInsets.only(top: 12, bottom: 8),
          padding: EdgeInsets.all(isSmall ? 14 : 20),
          decoration: BoxDecoration(
            color: const Color(0xFF192033),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.22),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Scrollbar(
            thumbVisibility: true,
            radius: const Radius.circular(12),
            thickness: 5,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About the App',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: const Color(0xFF4FC3F7),
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ..._aboutParagraphs.map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          p,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.5,
                            color: Color(0xFFE6E9F0),
                            height: 1.5,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> _aboutParagraphs = [
  "Silent Voices is a mobile application designed to bridge the communication gap between the hearing and the deaf or hard-of-hearing community. It provides a seamless way to convert speech into sign language and sign language into text — in real time.",
  "Unlike traditional accessibility tools that focus only on interpreting signs, Silent Voices flips the communication model by empowering hearing individuals to speak in signs using a friendly 3D avatar. This allows for inclusive, two-way conversations where both parties feel understood.",
  "The app supports multilingual speech input — including English, Hindi, and Marathi — and automatically translates it into Indian Sign Language (ISL) or American Sign Language (ASL). The inclusion of Natural Language Processing ensures that phrases are translated meaningfully rather than literally.",
  "Users can also use sign language gestures via camera input, which are recognized and converted into readable text. This makes Silent Voices an excellent communication bridge, especially in classrooms, hospitals, public offices, and even everyday conversations.",
  "With a beautifully animated avatar that signs with natural expressions and gestures, the app also acts as a passive learning tool. Regular users will start understanding signs naturally, making the world a more inclusive place one conversation at a time.",
  "Whether you are a hearing person trying to communicate with a deaf friend, or a deaf user who prefers using sign language to express themselves — Silent Voices makes communication accessible, respectful, and effortless for everyone."
];

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool isSmall;
  const CustomBottomNavBar({required this.selectedIndex, required this.onTap, required this.isSmall});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> with SingleTickerProviderStateMixin {
  late double notchPosition;
  late AnimationController _controller;
  late Animation<double> _notchAnim;

  final List<String> icons = [
    'assets/icons/home.png',
    'assets/icons/profile.png',
    'assets/icons/settings.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _notchAnim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    notchPosition = widget.selectedIndex.toDouble();
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {
        notchPosition = widget.selectedIndex.toDouble();
      });
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barColor = const Color(0xFF0C1220);
    final navActiveColor = const Color(0xFF4FC3F7);
    final inactiveColor = const Color(0xFFB8DAD9);
    final notchColor = Colors.white.withOpacity(0.10);
    final iconSize = widget.isSmall ? 26.0 : 32.0;
    final barHeight = widget.isSmall ? 60.0 : 74.0;
    final notchRadius = widget.isSmall ? 28.0 : 34.0;
    final notchYOffset = widget.isSmall ? 8.0 : 10.0;
    final iconLift = widget.isSmall ? 8.0 : 12.0;
    final width = MediaQuery.of(context).size.width;
    final itemCount = icons.length;
    final itemWidth = width / itemCount;

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: barColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Animated Notch
          AnimatedBuilder(
            animation: _notchAnim,
            builder: (context, child) {
              double pos = lerpDouble(
                oldNotchPosition,
                notchPosition,
                _notchAnim.value,
              )!;
              return Positioned(
                left: pos * itemWidth + (itemWidth / 2) - notchRadius,
                bottom: 0,
                child: CustomPaint(
                  painter: _NotchPainter(
                    color: barColor,
                    shadowColor: navActiveColor.withOpacity(0.25),
                  ),
                  child: SizedBox(
                    width: notchRadius * 2,
                    height: notchRadius + notchYOffset,
                  ),
                ),
              );
            },
          ),
          // Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(itemCount, (i) {
              final isActive = widget.selectedIndex == i;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => widget.onTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                      top: isActive ? 0 : notchYOffset + 4,
                      bottom: 0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          decoration: isActive
                              ? BoxDecoration(
                                  color: navActiveColor.withOpacity(0.13),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: navActiveColor.withOpacity(0.38),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                )
                              : null,
                          child: Transform.translate(
                            offset: Offset(0, isActive ? -iconLift : 0),
                            child: Transform.scale(
                              scale: isActive ? 1.18 : 1.0,
                              child: Image.asset(
                                icons[i],
                                width: iconSize,
                                height: iconSize,
                                color: isActive ? navActiveColor : inactiveColor,
                                colorBlendMode: BlendMode.srcIn,
                                opacity: AlwaysStoppedAnimation(isActive ? 1.0 : 0.7),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  double get oldNotchPosition {
    // If the animation is running, use the previous position
    return notchPosition == widget.selectedIndex.toDouble()
        ? notchPosition
        : widget.selectedIndex.toDouble();
  }
}

class _NotchPainter extends CustomPainter {
  final Color color;
  final Color shadowColor;
  _NotchPainter({required this.color, required this.shadowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final Paint shadow = Paint()
      ..color = shadowColor
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final double w = size.width;
    final double h = size.height;
    final double r = w / 2;
    final Path path = Path();
    path.moveTo(0, h);
    path.quadraticBezierTo(r, 0, w, h);
    path.close();

    // Draw shadow first
    canvas.saveLayer(null, Paint());
    canvas.translate(0, 4);
    canvas.drawPath(path, shadow);
    canvas.restore();
    // Draw notch
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 