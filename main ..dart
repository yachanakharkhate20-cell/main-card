import 'package:flutter/material.dart';

// Entry point of the app.
void main() => runApp(const ProfileCardApp());

/// Central place for the colors used across the UI.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4F46E5); // Indigo
  static const Color secondary = Color(0xFF7C3AED); // Violet
  static const Color background = Color(0xFFF4F5FB);
  static const Color textDark = Color(0xFF1F2937);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color iconTint = Color(0x1A4F46E5); // Primary at ~10% opacity
  static const Color shadow = Color(0x334F46E5); // Primary at ~20% opacity
}

/// Root widget: sets up MaterialApp and the Material 3 theme.
class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const ProfileScreen(),
    );
  }
}

/// The single screen of the app.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive padding: tighter on very narrow phones.
    final double width = MediaQuery.sizeOf(context).width;
    final double horizontalPadding = width < 360 ? 12 : 24;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Card',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        // LayoutBuilder gives us the available height so the card can be
        // vertically centered, while SingleChildScrollView prevents overflow.
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 16,
                    ),
                    // Limit the card width on tablets / desktop / web.
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: const ProfileCard(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The profile card: avatar, name, role and contact details.
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: AppColors.shadow,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(24, 32, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Avatar ---
            ProfileAvatar(initials: 'YK'),
            SizedBox(height: 20),

            // --- Name & role ---
            Text(
              'Yachana_kharkhate.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'MERN Stack Full-Stack Developer',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 24),
            Divider(height: 1, color: Color(0xFFE5E7EB)),
            SizedBox(height: 24),

            // --- Contact information (reusable ContactRow) ---
            ContactRow(
              icon: Icons.email,
              title: 'Email',
              value: 'Yachana_kharkhate.@example.com',
            ),
            SizedBox(height: 18),
            ContactRow(
              icon: Icons.phone,
              title: 'Phone',
              value: '+91 98765 43210',
            ),
            SizedBox(height: 18),
            ContactRow(
              icon: Icons.location_on,
              title: 'Location',
              value: 'Madhya Pradesh, India',
            ),
          ],
        ),
      ),
    );
  }
}

/// Circular avatar with a gradient ring and centered initials.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      // The padding acts as the visible thickness of the gradient ring.
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
      ),
      child: CircleAvatar(
        radius: 48,
        backgroundColor: AppColors.primary,
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

/// Reusable row showing an icon with a small title and a value beneath it.
class ContactRow extends StatelessWidget {
  const ContactRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon inside a softly tinted rounded square.
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.iconTint,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 16),
        // Expanded lets long text wrap instead of overflowing on narrow screens.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
