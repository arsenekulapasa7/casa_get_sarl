import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../services/content_store.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
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

  late final List<String> _videoAssets = [
    AppStrings.leisureVideo(0, 'images/video/vision.mp4'),
    AppStrings.leisureVideo(1, 'images/video/objectif.mp4'),
    AppStrings.leisureVideo(2, 'images/video/mission.mp4'),
  ];

  late final List<VideoPlayerController> _videoControllers = _videoAssets
      .map(
        (asset) => ContentStore.isDataUrl(asset)
            ? VideoPlayerController.networkUrl(Uri.parse(asset))
            : VideoPlayerController.asset(asset),
      )
      .toList();
  final List<String?> _videoErrors = List<String?>.filled(3, null);

  @override
  void initState() {
    super.initState();
    for (var index = 0; index < _videoControllers.length; index++) {
      _loadVideo(index);
    }
  }

  Future<void> _loadVideo(int index) async {
    final controller = _videoControllers[index];
    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      if (mounted) setState(() {});

      try {
        await controller.play();
      } catch (_) {
        if (mounted) setState(() {});
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _videoErrors[index] = 'Vidéo indisponible';
        });
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _changeLanguage(String value) {
    setState(() => language = value);
    widget.onLanguageChanged?.call(value);
  }

  Future<void> _toggleVideo(VideoPlayerController controller) async {
    try {
      if (controller.value.isPlaying) {
        await controller.pause();
      } else {
        await controller.play();
      }
      if (mounted) setState(() {});
    } catch (_) {
      if (mounted) setState(() {});
    }
  }

  void _openPage(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(
            begin: begin,
            end: end,
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
    if (index == 3) return;
    if (index == 4) return;
    if (index == 5) {
      _openPage(
        context,
        HomeScreen(
          language: language,
          onLanguageChanged: widget.onLanguageChanged ?? (_) {},
          initialIndex: 5,
        ),
      );
      return;
    }

    _openPage(
      context,
      HomeScreen(
        language: language,
        onLanguageChanged: widget.onLanguageChanged ?? (_) {},
        initialIndex: index,
      ),
    );
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
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 24,
                    vertical: 18,
                  ),
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
                          _videoCard(
                            title: 'VISION',
                            text: AppStrings.leisureVideoDescription(
                              0,
                              'Devenir la référence en Afrique Centrale pour la formation de footballeurs professionnels.',
                            ),
                            controller: _videoControllers[0],
                            error: _videoErrors[0],
                          ),
                          _videoCard(
                            title: 'OBJECTIF',
                            text: AppStrings.leisureVideoDescription(
                              1,
                              'Professionnaliser 1000 jeunes talents filles et garçons d’ici 2036.',
                            ),
                            controller: _videoControllers[1],
                            error: _videoErrors[1],
                          ),
                          _videoCard(
                            title: 'MISSION',
                            text: AppStrings.leisureVideoDescription(
                              2,
                              'Former, encadrer, éduquer et guider vers les clubs professionnels.',
                            ),
                            controller: _videoControllers[2],
                            error: _videoErrors[2],
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

  Widget _videoCard({
    required String title,
    required String text,
    required VideoPlayerController controller,
    required String? error,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: error == null && controller.value.isInitialized
            ? () => _toggleVideo(controller)
            : null,
        child: SizedBox(
          height: 190,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (error != null)
                const ColoredBox(
                  color: AppColors.primaryBlue,
                  child: Center(
                    child: Icon(
                      Icons.videocam_off_rounded,
                      color: AppColors.accentGold,
                      size: 34,
                    ),
                  ),
                )
              else if (controller.value.isInitialized)
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                )
              else
                const ColoredBox(
                  color: AppColors.primaryBlue,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentGold,
                    ),
                  ),
                ),
              const ColoredBox(color: Color(0x990B1F36)),
              if (controller.value.isInitialized && !controller.value.isPlaying)
                const Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentGold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.7,
                        color: Colors.white,
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
