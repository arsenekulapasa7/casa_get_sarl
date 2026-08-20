 import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.language,
  });

  final String language;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 42 : 72,
        horizontal: isMobile ? 20 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 20 : 28),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              children: [
                Text(
                  AppStrings.contactSubtitle(language),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 18,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _contactItem(
                      Icons.person,
                      'Mr FERDINAND MUHEMEDI MAKUSUDI\nPresident General Manager',
                      isMobile,
                    ),
                    _contactItem(
                      Icons.phone,
                      'Mobile\n+243 835 020 992',
                      isMobile,
                    ),
                    _contactItem(
                      Icons.chat,
                      'WhatsApp\n+256 780 577 334',
                      isMobile,
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGold,
                    foregroundColor: AppColors.primaryBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 22 : 30,
                      vertical: isMobile ? 14 : 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Send Inquiry',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactItem(IconData icon, String value, bool isMobile) {
    final width = isMobile ? 220.0 : 260.0;

    return Container(
      width: width,
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: isMobile ? 30 : 38,
            height: isMobile ? 30 : 38,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.accentGold,
              size: isMobile ? 16 : 18,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 12 : 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
