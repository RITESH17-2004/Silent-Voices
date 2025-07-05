import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silent_voices/screens/profile_page.dart';
import 'package:silent_voices/services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService _authService = AuthService();
  // State variables
  String theme = 'Dark';
  String language = 'English';
  double speechSpeed = 0.5;
  String voiceType = 'Male';
  String signLang = 'ASL';
  double animSpeed = 0.5;
  bool highContrast = false;
  bool vibration = true;
  bool screenReader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0F1E),
        elevation: 0,
        title: Text('Settings', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        children: [
          // General Settings
          _sectionTitle('General Settings'),
          const SizedBox(height: 10),
          _cardTile(
            iconWidget: Image.asset('assets/icons/profile.png', width: 28, height: 28, color: Color(0xFF4FC3F7)),
            title: 'Profile',
            subtitle: 'Edit your profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            showTrailing: false,
          ),
          const SizedBox(height: 10),
          _dropdownTile(
            iconWidget: Image.asset('assets/icons/language.png', width: 28, height: 28, color: Color(0xFF4FC3F7)),
            title: 'Language',
            value: language,
            items: const ['English', 'Hindi', 'Marathi'],
            onChanged: (val) => setState(() => language = val!),
          ),
          const SizedBox(height: 18),
          Divider(color: const Color(0xFF2A2D3C)),
          const SizedBox(height: 18),
          // Speech Settings
          _sectionTitle('Speech Settings'),
          const SizedBox(height: 10),
          _sliderTile(
            iconWidget: Image.asset('assets/icons/animation_speed.png', width: 28, height: 28, color: Color(0xFF4FC3F7)),
            title: 'Speech Speed',
            value: speechSpeed,
            min: 0.0,
            max: 1.0,
            labelStart: 'Slow',
            labelEnd: 'Fast',
            onChanged: (val) => setState(() => speechSpeed = val),
          ),
          const SizedBox(height: 10),
          _dropdownTile(
            iconWidget: Image.asset('assets/icons/voice_type.png', width: 28, height: 28, color: Color(0xFF4FC3F7)),
            title: 'Voice Type',
            value: voiceType,
            items: const ['Male', 'Female', 'Robotic'],
            onChanged: (val) => setState(() => voiceType = val!),
          ),
          const SizedBox(height: 18),
          Divider(color: const Color(0xFF2A2D3C)),
          const SizedBox(height: 18),
          // Sign Language Preferences
          _sectionTitle('Sign Language Preferences'),
          const SizedBox(height: 10),
          _dropdownTile(
            iconWidget: Image.asset('assets/icons/language_type.png', width: 28, height: 28, color: Color(0xFF4FC3F7)),
            title: 'Language Type',
            value: signLang,
            items: const ['ASL', 'ISL'],
            onChanged: (val) => setState(() => signLang = val!),
          ),
          const SizedBox(height: 10),
          _sliderTile(
            iconWidget: Image.asset('assets/icons/animation_speed.png', width: 28, height: 28, color: Color(0xFF4FC3F7)),
            title: 'Animation Speed',
            value: animSpeed,
            min: 0.0,
            max: 1.0,
            labelStart: 'Slow',
            labelEnd: 'Fast',
            onChanged: (val) => setState(() => animSpeed = val),
          ),
          const SizedBox(height: 18),
          Divider(color: const Color(0xFF2A2D3C)),
          const SizedBox(height: 18),
          // Others
          _sectionTitle('Others'),
          const SizedBox(height: 10),
          _cardTile(
            iconWidget: Image.asset('assets/icons/feedback.png', width: 28, height: 28, color: Color(0xFF4FC3F7)),
            title: 'Feedback',
            onTap: () {},
            showTrailing: false,
          ),
          const SizedBox(height: 10),
          _logoutButton(),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(left: 2, bottom: 2),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );

  Widget _cardTile({
    Widget? iconWidget,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    bool showTrailing = true,
  }) => Material(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ListTile(
              leading: iconWidget ?? Icon(Icons.info, color: const Color(0xFF4FC3F7)),
              title: Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFB0B3C5),
                        fontSize: 14,
                      ),
                    )
                  : null,
              trailing: showTrailing && onTap != null ? const Icon(Icons.chevron_right, color: Color(0xFF4FC3F7)) : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              minLeadingWidth: 0,
            ),
          ),
        ),
      );

  Widget _dropdownTile({
    Widget? iconWidget,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) => Material(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            leading: iconWidget ?? Icon(Icons.arrow_drop_down, color: const Color(0xFF4FC3F7)),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: DropdownButton<String>(
              value: value,
              dropdownColor: const Color(0xFF1A1D2E),
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              icon: Image.asset(
                'assets/icons/dropdown_arrow.png',
                width: 24,
                height: 24,
                color: Color(0xFF4FC3F7),
              ),
              underline: const SizedBox(),
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e, style: GoogleFonts.poppins()),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            minLeadingWidth: 0,
          ),
        ),
      );

  Widget _sliderTile({
    Widget? iconWidget,
    required String title,
    required double value,
    required double min,
    required double max,
    required String labelStart,
    required String labelEnd,
    required ValueChanged<double> onChanged,
  }) => Material(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: iconWidget ?? Icon(Icons.animation, color: const Color(0xFF4FC3F7)),
                title: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                minLeadingWidth: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(labelStart, style: GoogleFonts.poppins(color: const Color(0xFFB0B3C5), fontSize: 13)),
                    Expanded(
                      child: Slider(
                        value: value,
                        min: min,
                        max: max,
                        onChanged: onChanged,
                        activeColor: const Color(0xFF4FC3F7),
                        inactiveColor: const Color(0xFF2A2D3C),
                      ),
                    ),
                    Text(labelEnd, style: GoogleFonts.poppins(color: const Color(0xFFB0B3C5), fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) => Material(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            leading: Icon(icon, color: const Color(0xFF4FC3F7)),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF4FC3F7),
              inactiveThumbColor: const Color(0xFFB0B3C5),
              inactiveTrackColor: const Color(0xFF2A2D3C),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            minLeadingWidth: 0,
          ),
        ),
      );

  Widget _logoutButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Material(
          color: const Color(0xFF1A1D2E),
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () async {
              // Show confirmation dialog
              bool? shouldLogout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFF1A1D2E),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to logout?',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFB0B3C5),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF4FC3F7),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout == true) {
                try {
                  await _authService.signOut();
                  // The StreamBuilder in main.dart will automatically redirect to login
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error logging out: $e',
                          style: GoogleFonts.poppins(),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      color: Colors.redAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
} 