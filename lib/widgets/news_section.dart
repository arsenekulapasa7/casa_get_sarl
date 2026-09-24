import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/project_models.dart';
import '../screens/news_article_page.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({super.key, required this.language});

  final String language;

  @override
  Widget build(BuildContext context) {
    final posts = AppStrings.newsPosts(language);
    final isMobile = MediaQuery.sizeOf(context).width < 768;

    return Container(
      width: double.infinity,
      color: AppColors.blogLight,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 52,
        horizontal: isMobile ? 20 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                AppStrings.newsTitle(language),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 34,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.newsSubtitle(language),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 15 : 17,
                  height: 1.55,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 22),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isMobile
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 36) / 3;

                  return Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: posts
                        .map(
                          (post) => SizedBox(
                            width: cardWidth,
                            child: _NewsCard(
                              post: post,
                              language: language,
                              isMobile: isMobile,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({
    required this.post,
    required this.language,
    required this.isMobile,
  });

  final BlogPost post;
  final String language;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.primaryBlue.withOpacity(0.10)),
      ),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NewsArticlePage(post: post, language: language),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: isMobile ? 190 : 175,
              width: double.infinity,
              child: post.imagePath.startsWith('data:')
                  ? Image.network(
                      post.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.primaryBlue,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.article_rounded,
                          color: Colors.white,
                          size: 42,
                        ),
                      ),
                    )
                  : Image.asset(
                      post.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.primaryBlue,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.article_rounded,
                          color: Colors.white,
                          size: 42,
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blogLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            post.category,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.blogPurple,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          post.date,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post.excerpt,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        color: AppColors.accentGold,
                        size: 17,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        post.readTime,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.blogPurple,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
