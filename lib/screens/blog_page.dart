import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import 'home_screen.dart';
import 'leisure_page.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({
    super.key,
    required this.language,
    this.onLanguageChanged,
  });

  final String language;
  final ValueChanged<String>? onLanguageChanged;

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
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
    if (index == 5) return;
    if (index == 4) {
      _openPage(context, LeisurePage(
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
    final posts = AppStrings.blogPosts(language);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Navbar(
          language: language,
          onLanguageChanged: _changeLanguage,
          selectedIndex: 5,
          onItemSelected: (index) => _handleNavItem(context, index),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blogLight, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.blogPurple, const Color(0xFF5B3BB1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.auto_stories_rounded, color: Colors.white, size: 30),
                  const SizedBox(height: 10),
                  const Text(
                    'Blog',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.leisureBlogSubtitle(language),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...posts.map((post) => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.blogLight,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          post.category,
                          style: const TextStyle(
                            color: AppColors.blogPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        post.title,
                        style: const TextStyle(
                          color: AppColors.primaryBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        post.excerpt,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, size: 13, color: AppColors.blogPurple),
                          const SizedBox(width: 6),
                          Text(post.date, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
                          const SizedBox(width: 12),
                          Icon(Icons.access_time_rounded, size: 13, color: AppColors.blogPurple),
                          const SizedBox(width: 6),
                          Text(post.readTime, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
                        ],
                      ),
                    ],
                  ),
                )),
            Footer(language: language),
          ],
        ),
      ),
    );
  }
}
