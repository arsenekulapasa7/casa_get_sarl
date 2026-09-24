import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../services/content_store.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _heroTitleFr;
  late final TextEditingController _heroTitleEn;
  late final TextEditingController _heroSubtitleFr;
  late final TextEditingController _heroSubtitleEn;
  late final TextEditingController _contactSubtitleFr;
  late final TextEditingController _contactSubtitleEn;
  late final TextEditingController _newsTitleFr;
  late final TextEditingController _newsExcerptFr;
  late final TextEditingController _newsImage;
  late final List<TextEditingController> _videoControllers;
  late final List<TextEditingController> _videoDescriptionControllers;
  late final List<TextEditingController> _projectImageControllers;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _heroTitleFr = TextEditingController(
      text: AppStrings.heroTitle(AppStrings.languageFr),
    );
    _heroTitleEn = TextEditingController(
      text: AppStrings.heroTitle(AppStrings.languageEn),
    );
    _heroSubtitleFr = TextEditingController(
      text: AppStrings.heroSubtitle(AppStrings.languageFr),
    );
    _heroSubtitleEn = TextEditingController(
      text: AppStrings.heroSubtitle(AppStrings.languageEn),
    );
    _contactSubtitleFr = TextEditingController(
      text: AppStrings.contactSubtitle(AppStrings.languageFr),
    );
    _contactSubtitleEn = TextEditingController(
      text: AppStrings.contactSubtitle(AppStrings.languageEn),
    );
    _newsTitleFr = TextEditingController(
      text: ContentStore.instance.value('news.fr.title'),
    );
    _newsExcerptFr = TextEditingController(
      text: ContentStore.instance.value('news.fr.excerpt'),
    );
    _newsImage = TextEditingController(
      text: ContentStore.instance.value('news.fr.image'),
    );
    _videoControllers = List.generate(
      3,
      (index) => TextEditingController(
        text: ContentStore.instance.value('leisure.video_$index'),
      ),
    );
    _videoDescriptionControllers = List.generate(
      3,
      (index) => TextEditingController(
        text: ContentStore.instance.value('leisure.video_description_$index'),
      ),
    );
    _projectImageControllers = List.generate(
      3,
      (index) => TextEditingController(
        text: ContentStore.instance.value('project.image_$index'),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in [
      _heroTitleFr,
      _heroTitleEn,
      _heroSubtitleFr,
      _heroSubtitleEn,
      _contactSubtitleFr,
      _contactSubtitleEn,
      _newsTitleFr,
      _newsExcerptFr,
      _newsImage,
      ..._videoControllers,
      ..._videoDescriptionControllers,
      ..._projectImageControllers,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    await ContentStore.instance.save(
      heroTitleFr: _heroTitleFr.text.trim(),
      heroTitleEn: _heroTitleEn.text.trim(),
      heroSubtitleFr: _heroSubtitleFr.text.trim(),
      heroSubtitleEn: _heroSubtitleEn.text.trim(),
      contactSubtitleFr: _contactSubtitleFr.text.trim(),
      contactSubtitleEn: _contactSubtitleEn.text.trim(),
    );
    await ContentStore.instance.saveValues({
      'news.fr.title': _newsTitleFr.text.trim(),
      'news.fr.excerpt': _newsExcerptFr.text.trim(),
      'news.fr.image': _newsImage.text.trim(),
      'news.fr.date': _formatDate(DateTime.now()),
      for (var index = 0; index < _videoControllers.length; index++)
        'leisure.video_$index': _videoControllers[index].text.trim(),
      for (var index = 0; index < _videoDescriptionControllers.length; index++)
        'leisure.video_description_$index': _videoDescriptionControllers[index]
            .text
            .trim(),
      for (var index = 0; index < _projectImageControllers.length; index++)
        'project.image_$index': _projectImageControllers[index].text.trim(),
    });
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contenus enregistrés sur cet appareil.')),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickFile(
    TextEditingController controller, {
    required FileType type,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: type,
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return;

    final file = result.files.single;
    final extension = file.extension?.toLowerCase() ?? '';
    final mimeType = type == FileType.video
        ? 'video/${extension == 'mov' ? 'quicktime' : extension}'
        : 'image/${extension == 'jpg' ? 'jpeg' : extension}';
    controller.text = 'data:$mimeType;base64,${base64Encode(file.bytes!)}';
    if (mounted) setState(() {});
  }

  Widget _mediaField(
    TextEditingController controller,
    String label, {
    required FileType type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _field(controller, label, required: false)),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            tooltip: 'Téléverser',
            onPressed: () => _pickFile(controller, type: type),
            icon: const Icon(Icons.upload_file_rounded),
          ),
          IconButton.filledTonal(
            tooltip: 'Supprimer',
            onPressed: controller.text.isEmpty
                ? null
                : () => setState(controller.clear),
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) {
          if (!required || (value != null && value.trim().isNotEmpty)) {
            return null;
          }
          return 'Ce champ est obligatoire.';
        },
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: maxLines > 1,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration du site'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Modifier les contenus',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Les changements sont sauvegardés localement sur cet appareil.',
            ),
            const SizedBox(height: 28),
            const Text(
              'Accueil · Français',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            _field(_heroTitleFr, 'Titre principal'),
            _field(_heroSubtitleFr, 'Description principale', maxLines: 4),
            const SizedBox(height: 10),
            const Text(
              'Accueil · English',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            _field(_heroTitleEn, 'Main title'),
            _field(_heroSubtitleEn, 'Main description', maxLines: 4),
            const SizedBox(height: 10),
            const Text(
              'Contact',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            _field(
              _contactSubtitleFr,
              'Phrase de contact · Français',
              maxLines: 2,
            ),
            _field(_contactSubtitleEn, 'Contact phrase · English', maxLines: 2),
            const SizedBox(height: 10),
            const Text(
              'Ajouter une actualité',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            _field(_newsTitleFr, 'Titre de la nouvelle'),
            _field(_newsExcerptFr, 'Résumé de la nouvelle', maxLines: 3),
            _mediaField(
              _newsImage,
              'Image de l’actualité',
              type: FileType.image,
            ),
            const SizedBox(height: 10),
            const Text(
              'Vidéos de la page Loisirs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            ..._videoControllers.asMap().entries.map(
              (entry) => Column(
                children: [
                  _mediaField(
                    entry.value,
                    'Vidéo ${entry.key + 1} (ex. images/video/ma-video.mp4)',
                    type: FileType.video,
                  ),
                  _field(
                    _videoDescriptionControllers[entry.key],
                    'Description de la vidéo ${entry.key + 1}',
                    maxLines: 3,
                    required: false,
                  ),
                ],
              ),
            ),
            const Text(
              'Images des projets',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            ..._projectImageControllers.asMap().entries.map(
              (entry) => _mediaField(
                entry.value,
                'Image projet ${entry.key + 1} (ex. images/Projet/projet.jpeg)',
                type: FileType.image,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_rounded),
              label: Text(
                _saving ? 'Enregistrement...' : 'Enregistrer les changements',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
