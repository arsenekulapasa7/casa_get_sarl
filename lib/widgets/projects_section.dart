import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/project_models.dart';
import '../screens/project_detail_page.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key, required this.language});

  final String language;

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showPreviousImage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _showNextImage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget _buildProjectCarousel({
    required bool isMobile,
    required List<Project> projects,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(18),
        bottomLeft: Radius.circular(isMobile ? 0 : 18),
        topRight: Radius.circular(isMobile ? 18 : 0),
        bottomRight: Radius.circular(isMobile ? 0 : 0),
      ),
      child: SizedBox(
        height: isMobile ? 220 : 260,
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: projects.length,
              onPageChanged: (page) => setState(() => _currentPage = page),
              itemBuilder: (context, index) {
                final imagePath = projects[index].imagePath;
                return imagePath.startsWith('data:')
                    ? Image.network(imagePath, fit: BoxFit.cover)
                    : Image.asset(imagePath, fit: BoxFit.cover);
              },
            ),
            Positioned(
              left: 12,
              right: 12,
              top: 0,
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CarouselButton(
                    icon: Icons.chevron_left,
                    onPressed: _showPreviousImage,
                    tooltip: 'Previous image',
                  ),
                  _CarouselButton(
                    icon: Icons.chevron_right,
                    onPressed: _showNextImage,
                    tooltip: 'Next image',
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  projects.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 7,
                    width: index == _currentPage ? 22 : 7,
                    decoration: BoxDecoration(
                      color: index == _currentPage
                          ? Colors.white
                          : Colors.white.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = AppStrings.projectCards(widget.language);
    final selectedProject =
        projects[_currentPage.clamp(0, projects.length - 1)];
    final isMobile = MediaQuery.of(context).size.width < 768;

    void openProject() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProjectDetailPage(
            project: selectedProject,
            language: widget.language,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      color: Colors.white,
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
                AppStrings.projectsTitle(widget.language),
                style: TextStyle(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 22),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black12),
                ),
                child: isMobile
                    ? Column(
                        children: [
                          _buildProjectCarousel(
                            isMobile: true,
                            projects: projects,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProject.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBlue,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  selectedProject.summary,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.7,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                OutlinedButton(
                                  onPressed: openProject,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.primaryBlue,
                                    side: const BorderSide(
                                      color: AppColors.primaryBlue,
                                      width: 1.5,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('View Project →'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildProjectCarousel(
                              isMobile: false,
                              projects: projects,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          selectedProject.title,
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryBlue,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.accentGold
                                              .withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                        child: const Text(
                                          'Status: Operational',
                                          style: TextStyle(
                                            color: AppColors.primaryBlue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    selectedProject.summary,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.7,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  OutlinedButton(
                                    onPressed: openProject,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.primaryBlue,
                                      side: const BorderSide(
                                        color: AppColors.primaryBlue,
                                        width: 1.5,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 12,
                                      ),
                                    ),
                                    child: const Text('View Project →'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CarouselButton extends StatelessWidget {
  const _CarouselButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, color: Colors.white),
      style: IconButton.styleFrom(
        backgroundColor: Colors.black54,
        minimumSize: const Size(38, 38),
      ),
    );
  }
}
