import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/services_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import 'blog_page.dart';
import 'leisure_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    this.initialIndex = 0,
  });

  final String language;
  final ValueChanged<String> onLanguageChanged;
  final int initialIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _homeIndex = 0;
  static const int _aboutIndex = 1;
  static const int _servicesIndex = 2;
  static const int _projectsIndex = 3;
  static const int _leisureIndex = 4;
  static const int _blogIndex = 5;
  static const int _contactIndex = 6;

  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(7, (_) => GlobalKey());
  int _selectedIndex = _homeIndex;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    if (widget.initialIndex != _homeIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _scrollToSection(widget.initialIndex);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final offset = _scrollController.offset;
    setState(() {
      _showBackToTop = offset > 300;
    });

    final viewportTop = MediaQuery.of(context).padding.top + 120.0;
    int bestIndex = 0;
    double closestDistance = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final sectionContext = _sectionKeys[i].currentContext;
      if (sectionContext == null) continue;

      final renderBox = sectionContext.findRenderObject();
      if (renderBox is! RenderBox) continue;

      final sectionTop = renderBox.localToGlobal(Offset.zero).dy;
      final distance = (sectionTop - viewportTop).abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        bestIndex = i;
      }
    }

    if (_selectedIndex != bestIndex) {
      setState(() => _selectedIndex = bestIndex);
    }
  }

  void _openPremiumPage(Widget page) {
    Navigator.of(context).push(
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
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  void _scrollToSection(int index) {
    if (index == _leisureIndex) {
      setState(() => _selectedIndex = index);
      _openPremiumPage(LeisurePage(language: widget.language));
      return;
    }

    if (index == _blogIndex) {
      setState(() => _selectedIndex = index);
      _openPremiumPage(BlogPage(language: widget.language));
      return;
    }

    if (index == _contactIndex) {
      setState(() => _selectedIndex = index);
      final sectionContext = _sectionKeys[_contactIndex].currentContext;
      if (sectionContext != null) {
        Scrollable.ensureVisible(
          sectionContext,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
          alignment: 0.12,
        );
      }
      return;
    }

    final sectionContext = _sectionKeys[index].currentContext;
    if (sectionContext == null) return;

    setState(() => _selectedIndex = index);
    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.12,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
    setState(() => _selectedIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    final navItems = AppStrings.navItems(widget.language);

    return Scaffold(
      appBar: Navbar(
        language: widget.language,
        onLanguageChanged: widget.onLanguageChanged,
        selectedIndex: _selectedIndex,
        onItemSelected: _scrollToSection,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primaryBlue),
              child: Text(
                'CASA GET SARL',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ...navItems.asMap().entries.map((entry) => ListTile(
                  title: Text(entry.value),
                  selected: _selectedIndex == entry.key,
                  selectedColor: AppColors.accentGold,
                  onTap: () {
                    _scrollToSection(entry.key);
                    Navigator.of(context).pop();
                  },
                )),
          ],
        ),
      ),
      floatingActionButton: _showBackToTop
          ? Padding(
              padding: const EdgeInsets.only(bottom: 18, right: 8),
              child: FloatingActionButton.extended(
                onPressed: _scrollToTop,
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 12,
                icon: const Icon(Icons.arrow_upward_rounded),
                label: const Text(
                  'Haut',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(key: _sectionKeys[0], child: HeroSection(language: widget.language)),
          SliverToBoxAdapter(key: _sectionKeys[1], child: AboutSection(language: widget.language)),
          SliverToBoxAdapter(key: _sectionKeys[2], child: ServicesSection(language: widget.language)),
          SliverToBoxAdapter(key: _sectionKeys[3], child: ProjectsSection(language: widget.language)),
          SliverToBoxAdapter(key: _sectionKeys[6], child: ContactSection(language: widget.language)),
          SliverToBoxAdapter(child: Footer(language: widget.language)),
        ],
      ),
    );
  }
}
