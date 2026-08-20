import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../screens/credit_maison_page.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key, required this.language});

  final String language;

  @override
  Widget build(BuildContext context) {
    final cards = AppStrings.serviceCards(language);
    final icons = [
      Icons.construction_rounded,
      Icons.factory_rounded,
      Icons.solar_power_rounded,
      Icons.manage_accounts_rounded,
      Icons.home_work_rounded,
    ];
    final images = [
      'images/Projet/projet 2.jpeg',
      'images/Projet/projet.jpeg',
      'images/accueil.jpeg',
      'images/Projet/proj.jpeg',
      'images/credit_maison.jpeg',
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final cardWidth = isMobile
        ? screenWidth - 48
        : (screenWidth < 1300 ? 270.0 : 285.0);

    return Container(
      width: double.infinity,
      color: AppColors.backgroundLight,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 42 : 64,
        horizontal: isMobile ? 20 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1500),
          child: Column(
            children: [
              Text(
                AppStrings.aboutTitle(language),
                style: TextStyle(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.aboutDescription(language),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 15 : 17,
                  color: AppColors.textDark,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 28),
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
              isMobile
                  ? Column(
                      children: cards
                          .asMap()
                          .entries
                          .map(
                            (entry) => Padding(
                              padding: EdgeInsets.only(
                                bottom: entry.key == cards.length - 1 ? 0 : 14,
                              ),
                              child: SizedBox(
                                width: cardWidth,
                                child: Container(
                                  height: entry.key == 4
                                      ? (isMobile ? 400 : 390)
                                      : (isMobile ? 360 : 350),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(images[entry.key]),
                                      fit: BoxFit.cover,
                                      colorFilter: const ColorFilter.mode(
                                        Color(0x990A2A42),
                                        BlendMode.darken,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(isMobile ? 18 : 22),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: isMobile ? 46 : 52,
                                          height: isMobile ? 46 : 52,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.9,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
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
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: isMobile ? 8 : 10),
                                        Text(
                                          entry.value['text'] ?? '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: isMobile ? 13 : 14,
                                            height: 1.6,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (entry.key == 4) ...[
                                          const SizedBox(height: 14),
                                          OutlinedButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                      ) => CreditMaisonPage(
                                                        language: language,
                                                      ),
                                                  transitionsBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child,
                                                      ) {
                                                        final tween =
                                                            Tween(
                                                              begin:
                                                                  const Offset(
                                                                    1,
                                                                    0,
                                                                  ),
                                                              end: Offset.zero,
                                                            ).chain(
                                                              CurveTween(
                                                                curve: Curves
                                                                    .easeOutCubic,
                                                              ),
                                                            );
                                                        return SlideTransition(
                                                          position: animation
                                                              .drive(tween),
                                                          child: FadeTransition(
                                                            opacity: animation,
                                                            child: child,
                                                          ),
                                                        );
                                                      },
                                                  transitionDuration:
                                                      const Duration(
                                                        milliseconds: 500,
                                                      ),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 16,
                                            ),
                                            label: Text(
                                              language == AppStrings.languageFr
                                                  ? 'Découvrir'
                                                  : 'Discover',
                                            ),
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              side: const BorderSide(
                                                color: Colors.white70,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 14,
                                                    vertical: 9,
                                                  ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: cards
                            .asMap()
                            .entries
                            .map(
                              (entry) => Padding(
                                padding: EdgeInsets.only(
                                  right: entry.key == cards.length - 1 ? 0 : 18,
                                ),
                                child: SizedBox(
                                  width: cardWidth,
                                  child: Container(
                                    height: entry.key == 4 ? 390 : 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(images[entry.key]),
                                        fit: BoxFit.cover,
                                        colorFilter: const ColorFilter.mode(
                                          Color(0x990A2A42),
                                          BlendMode.darken,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: _cardContent(
                                      context,
                                      entry,
                                      isMobile: false,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardContent(
    BuildContext context,
    MapEntry<int, Map<String, String>> entry, {
    required bool isMobile,
  }) {
    final icons = [
      Icons.construction_rounded,
      Icons.factory_rounded,
      Icons.solar_power_rounded,
      Icons.manage_accounts_rounded,
      Icons.home_work_rounded,
    ];

    return Padding(
      padding: EdgeInsets.all(isMobile ? 18 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isMobile ? 46 : 52,
            height: isMobile ? 46 : 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
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
              color: Colors.white,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Text(
            entry.value['text'] ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              height: 1.6,
              color: Colors.white,
            ),
          ),
          if (entry.key == 4) ...[
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreditMaisonPage(language: language),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward_rounded, size: 16),
              label: Text(
                language == AppStrings.languageFr ? 'Découvrir' : 'Discover',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
