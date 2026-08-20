import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import 'blog_page.dart';
import 'home_screen.dart';
import 'leisure_page.dart';

class CreditMaisonPage extends StatefulWidget {
  const CreditMaisonPage({super.key, required this.language});

  final String language;

  @override
  State<CreditMaisonPage> createState() => _CreditMaisonPageState();
}

class _CreditMaisonPageState extends State<CreditMaisonPage> {
  late String language = widget.language;

  bool get isFrench => language == AppStrings.languageFr;

  void _changeLanguage(String value) {
    setState(() => language = value);
  }

  void _openPage(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  void _handleNavItem(BuildContext context, int index) {
    if (index == 3) {
      _openPage(context, LeisurePage(language: language));
      return;
    }
    if (index == 4) {
      _openPage(context, BlogPage(language: language));
      return;
    }

    _openPage(
      context,
      HomeScreen(
        language: language,
        onLanguageChanged: _changeLanguage,
        initialIndex: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 768;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Navbar(
          language: language,
          onLanguageChanged: _changeLanguage,
          selectedIndex: -1,
          onItemSelected: (index) => _handleNavItem(context, index),
        ),
      ),
      body: ListView(
        children: [
          _hero(isMobile),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 18 : 48,
              vertical: isMobile ? 28 : 46,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(
                      isFrench
                          ? '5 types de biens financés'
                          : '5 property types financed',
                      isFrench
                          ? 'Une solution pensée pour les familles, les entrepreneurs et les communautés.'
                          : 'A solution designed for families, entrepreneurs and communities.',
                    ),
                    const SizedBox(height: 22),
                    _propertyGrid(isMobile),
                    const SizedBox(height: 38),
                    _conditions(isMobile),
                    const SizedBox(height: 26),
                    _contactPanel(isMobile),
                  ],
                ),
              ),
            ),
          ),
          Footer(language: language),
        ],
      ),
    );
  }

  Widget _hero(bool isMobile) {
    return SizedBox(
      height: isMobile ? 360 : 470,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('images/credit_maison.jpeg', fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.primaryBlue.withOpacity(0.92),
                ],
              ),
            ),
          ),
          Positioned(
            left: isMobile ? 22 : 54,
            right: isMobile ? 22 : 54,
            bottom: isMobile ? 24 : 42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFrench
                      ? 'CRÉDIT MAISONS POUR TOUS'
                      : 'HOME FINANCING FOR ALL',
                  style: TextStyle(
                    fontSize: isMobile ? 30 : 48,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isFrench
                      ? 'Construire vite, construire durable, construire pour le peuple africain.'
                      : 'Build fast, build sustainably, build for the African people.',
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 20,
                    color: AppColors.accentGold,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _propertyGrid(bool isMobile) {
    final properties = isFrench
        ? [
            (
              'Maison d’habitation',
              'Résidence familiale moderne, confortable et sécurisée.',
              Icons.home_rounded,
            ),
            (
              'Maison inachevée',
              'Finalisation de construction et achèvement des travaux.',
              Icons.construction_rounded,
            ),
            (
              'Maison commerciale',
              'Boutique, bureau ou local commercial pour vos activités.',
              Icons.storefront_rounded,
            ),
            (
              'Structure sanitaire',
              'Clinique ou centre de santé moderne pour la communauté.',
              Icons.local_hospital_rounded,
            ),
            (
              'Hôtel',
              'Petit hôtel ou hébergement pour le développement touristique.',
              Icons.hotel_rounded,
            ),
          ]
        : [
            (
              'Family home',
              'A modern, comfortable and secure family residence.',
              Icons.home_rounded,
            ),
            (
              'Unfinished home',
              'Complete construction and finish the remaining work.',
              Icons.construction_rounded,
            ),
            (
              'Commercial property',
              'A shop, office or commercial space for your activity.',
              Icons.storefront_rounded,
            ),
            (
              'Healthcare facility',
              'A modern clinic or health centre for the community.',
              Icons.local_hospital_rounded,
            ),
            (
              'Hotel',
              'A small hotel or accommodation for tourism development.',
              Icons.hotel_rounded,
            ),
          ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: properties.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isMobile ? 3.2 : 1.45,
      ),
      itemBuilder: (context, index) {
        final property = properties[index];
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.accentGold.withOpacity(0.35)),
          ),
          child: Row(
            children: [
              Icon(property.$3, color: AppColors.primaryBlue, size: 34),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.$1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      property.$2,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _conditions(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isFrench ? 'Conditions de financement' : 'Financing conditions',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              _condition(
                isFrench ? 'Apport client' : 'Client contribution',
                '20%',
              ),
              _condition(
                isFrench ? 'Crédit via CASA GET' : 'CASA GET financing',
                '80%',
              ),
              _condition(
                isFrench ? 'Remboursement' : 'Repayment',
                isFrench ? '120 mois' : '120 months',
              ),
              _condition(
                isFrench ? 'Frais de dossier' : 'Application fee',
                isFrench
                    ? '180\$ à Durba | 250\$ ailleurs'
                    : '\$180 in Durba | \$250 elsewhere',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _condition(String label, String value) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.textDark),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: AppColors.accentGold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactPanel(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: AppColors.accentGold,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 18,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isFrench
                    ? 'Parlons de votre projet'
                    : 'Let’s discuss your project',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '+243 815 887 612\n+243 988 431 960\ncasagetprojetimmobilier@gmail.com',
                style: TextStyle(height: 1.6, color: AppColors.primaryBlue),
              ),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone_in_talk_rounded),
            label: Text(isFrench ? 'Appelez maintenant' : 'Call now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
