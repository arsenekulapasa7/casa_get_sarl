import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.language,
  });

  final String language;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final bool isTablet = screenWidth >= 768 && screenWidth < 1100;

    final title = AppStrings.heroTitle(language);
    final subtitle = AppStrings.heroSubtitle(language);
    final primaryButtonText = AppStrings.primaryButton(language);
    final secondaryButtonText = AppStrings.secondaryButton(language);

    final titleFont = isMobile
        ? 26.0
        : isTablet
            ? 38.0
            : 52.0;
    final subtitleFont = isMobile ? 14.0 : isTablet ? 16.0 : 18.0;
    final buttonPadding = isMobile
        ? const EdgeInsets.symmetric(horizontal: 22, vertical: 16)
        : const EdgeInsets.symmetric(horizontal: 28, vertical: 18);

    return Container(
      width: double.infinity,
      height: isMobile ? 480 : isTablet ? 540 : 620,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : isTablet ? 40.0 : 80.0,
        vertical: isMobile ? 28.0 : 40.0,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/accueil.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xAA0A2A42),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFont,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.16,
                  shadows: const [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black38,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isMobile ? 520 : 820),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: subtitleFont,
                    color: Colors.white70,
                    height: 1.45,
                    shadows: const [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black38,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 16.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGold,
                      foregroundColor: AppColors.primaryBlue,
                      padding: buttonPadding,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      primaryButtonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 18 : 24,
                        vertical: isMobile ? 14 : 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          secondaryButtonText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
