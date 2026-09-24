import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/project_models.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import 'home_screen.dart';
import 'leisure_page.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({
    super.key,
    required this.project,
    required this.language,
  });

  final Project project;
  final String language;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late String language = widget.language;

  void _changeLanguage(String value) => setState(() => language = value);

  void _openPage(Widget page) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void _handleNavItem(int index) {
    if (index == 4) {
      _openPage(LeisurePage(language: language));
      return;
    }

    _openPage(
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
      appBar: Navbar(
        language: language,
        onLanguageChanged: _changeLanguage,
        selectedIndex: 2,
        onItemSelected: _handleNavItem,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          isMobile ? 20 : 32,
          24,
          isMobile ? 20 : 32,
          0,
        ),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: AspectRatio(
                      aspectRatio: isMobile ? 1.35 : 2.3,
                      child: widget.project.imagePath.startsWith('data:')
                          ? Image.network(
                              widget.project.imagePath,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              widget.project.imagePath,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    widget.project.title,
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontSize: isMobile ? 28 : 42,
                      fontWeight: FontWeight.bold,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.project.summary,
                    style: TextStyle(
                      color: AppColors.accentGold,
                      fontSize: isMobile ? 17 : 20,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...widget.project.description
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
                  if (widget.project.gallery.length > 1) ...[
                    const SizedBox(height: 12),
                    Text(
                      language == AppStrings.languageFr
                          ? 'Galerie du projet'
                          : 'Project gallery',
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.project.gallery.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: widget.project.gallery[index].startsWith('data:')
                            ? Image.network(
                                widget.project.gallery[index],
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                widget.project.gallery[index],
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 42),
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
