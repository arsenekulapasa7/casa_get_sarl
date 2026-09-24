import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/project_models.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import 'home_screen.dart';
import 'leisure_page.dart';

class NewsArticlePage extends StatefulWidget {
  const NewsArticlePage({
    super.key,
    required this.post,
    required this.language,
  });

  final BlogPost post;
  final String language;

  @override
  State<NewsArticlePage> createState() => _NewsArticlePageState();
}

class _NewsArticlePageState extends State<NewsArticlePage> {
  late String language = widget.language;

  void _changeLanguage(String value) {
    setState(() => language = value);
  }

  void _handleNavItem(int index) {
    if (index == 3) return;

    if (index == 4) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LeisurePage(language: language)),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          language: language,
          onLanguageChanged: _changeLanguage,
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 768;

    return Scaffold(
      appBar: Navbar(
        language: language,
        onLanguageChanged: _changeLanguage,
        selectedIndex: 3,
        onItemSelected: _handleNavItem,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          isMobile ? 20 : 32,
          24,
          isMobile ? 20 : 32,
          48,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: isMobile ? 1.45 : 2.4,
                      child: widget.post.imagePath.startsWith('data:')
                          ? Image.network(
                              widget.post.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: AppColors.primaryBlue,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.article_rounded,
                                  color: Colors.white,
                                  size: 56,
                                ),
                              ),
                            )
                          : Image.asset(
                              widget.post.imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.primaryBlue,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.article_rounded,
                            color: Colors.white,
                            size: 56,
                          ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blogLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.post.category,
                          style: const TextStyle(
                            color: AppColors.blogPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        widget.post.date,
                        style: const TextStyle(color: AppColors.textDark),
                      ),
                      Text(
                        widget.post.readTime,
                        style: const TextStyle(color: AppColors.textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.post.title,
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: isMobile ? 28 : 40,
                      fontWeight: FontWeight.bold,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...widget.post.content
                      .split('\n\n')
                      .map(
                        (paragraph) => Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Text(
                            paragraph,
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: isMobile ? 16 : 18,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          Footer(language: language),
        ],
      ),
    );
  }
}
