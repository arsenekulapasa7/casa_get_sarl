import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({
    super.key,
    required this.language,
  });

  final String language;

  @override
  Widget build(BuildContext context) {
    final cards = AppStrings.serviceCards(language);
    final icons = [
      Icons.factory_rounded,
      Icons.construction_rounded,
      Icons.solar_power_rounded,
      Icons.manage_accounts_rounded,
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final cardWidth = isMobile ? screenWidth - 48 : (screenWidth < 1100 ? 240.0 : 260.0);

    return Container(
      width: double.infinity,
      color: AppColors.backgroundLight,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 42 : 64,
        horizontal: isMobile ? 20 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                AppStrings.servicesTitle(language),
                style: TextStyle(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.servicesSubtitle(language),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 15 : 17,
                  color: AppColors.textDark,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: isMobile ? 14 : 18,
                runSpacing: isMobile ? 14 : 18,
                alignment: WrapAlignment.center,
                children: cards
                    .asMap()
                    .entries
                    .map(
                      (entry) => SizedBox(
                        width: cardWidth,
                        child: Container(
                          padding: EdgeInsets.all(isMobile ? 18 : 22),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: isMobile ? 46 : 52,
                                height: isMobile ? 46 : 52,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundLight,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  icons[entry.key],
                                  color: AppColors.accentGold,
                                  size: isMobile ? 24 : 28,
                                ),
                              ),
                              SizedBox(height: isMobile ? 12 : 16),
                              Text(
                                entry.value['title'] ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                              SizedBox(height: isMobile ? 8 : 10),
                              Text(
                                entry.value['text'] ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: isMobile ? 13 : 14,
                                  height: 1.6,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
