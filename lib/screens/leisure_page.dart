import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import 'blog_page.dart';
import 'home_screen.dart';

class LeisurePage extends StatefulWidget {
  const LeisurePage({
    super.key,
    required this.language,
    this.onLanguageChanged,
  });

  final String language;
  final ValueChanged<String>? onLanguageChanged;

  @override
  State<LeisurePage> createState() => _LeisurePageState();
}

class _LeisurePageState extends State<LeisurePage> {
  late String language = widget.language;

  void _changeLanguage(String value) {
    setState(() => language = value);
    widget.onLanguageChanged?.call(value);
  }

  void _openPage(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.easeOutCubic));

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  void _handleNavItem(BuildContext context, int index) {
    if (index == 4) return;
    if (index == 5) {
      _openPage(context, BlogPage(
        language: language,
        onLanguageChanged: widget.onLanguageChanged,
      ));
      return;
    }

    _openPage(context, HomeScreen(
      language: language,
      onLanguageChanged: widget.onLanguageChanged ?? (_) {},
      initialIndex: index,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Navbar(
          language: language,
          onLanguageChanged: _changeLanguage,
          selectedIndex: 4,
          onItemSelected: (index) => _handleNavItem(context, index),
        ),
      ),
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: isMobile ? 210 : 300,
                      child: Image.asset(
                        'images/logofoot.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.08),
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 18,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'KIBALI WILLIAM SHAKESPEARE FOOTBALL ACADEMY',
                            style: TextStyle(
                              fontSize: isMobile ? 18 : 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Former des Champions, Eduquer des Leaders',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accentGold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Filles & Garçons de 6 à 18 ans',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _infoCard(
                        title: 'À PROPOS DE NOUS',
                        body:
                            'La KIBALI WILLIAM SHAKESPEARE FOOTBALL ACADEMY forme les jeunes talents de demain en combinant excellence sportive, éducation et valeurs humaines.',
                      ),
                      const SizedBox(height: 16),
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: isMobile ? 1.7 : 1.25,
                        ),
                        children: [
                          _miniCard(
                            title: 'VISION',
                            text:
                                'Devenir la référence en Afrique Centrale pour la formation de footballeurs professionnels.',
                          ),
                          _miniCard(
                            title: 'OBJECTIF',
                            text:
                                'Professionnaliser 1000 jeunes talents filles et garçons d’ici 2036.',
                          ),
                          _miniCard(
                            title: 'MISSION',
                            text:
                                'Former, encadrer, éduquer et guider vers les clubs professionnels.',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _infoCard(
                        title: 'ACTIVITÉS',
                        body:
                            'Formation quotidienne, encadrement de coachs certifiés, compétitions locales et stages internationaux.',
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.black12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CONTACT',
                              style: TextStyle(
                                fontSize: isMobile ? 18 : 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Durba, Haut-Uélé - RDC\nMobile : +243 815 887 612\nWhatsApp : +256 780 577 334\nEmail : williamshakespearefootballacad@gmail.com',
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.7,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Footer(language: language),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required String body}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(
              fontSize: 15,
              height: 1.8,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniCard({required String title, required String text}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              height: 1.7,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
