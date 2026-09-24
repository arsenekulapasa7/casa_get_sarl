import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.language});

  final String language;

  Future<void> _openLink(BuildContext context, String value) async {
    final uri = Uri.parse(value);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          language == AppStrings.languageFr
              ? 'Impossible d’ouvrir ce lien sur cet appareil.'
              : 'This link could not be opened on this device.',
        ),
      ),
    );
  }

  Future<void> _showMessageDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    try {
      final shouldSend = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(
            language == AppStrings.languageFr
                ? 'Envoyer un message'
                : 'Send a message',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: language == AppStrings.languageFr
                        ? 'Nom du client'
                        : 'Client name',
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return language == AppStrings.languageFr
                          ? 'Veuillez saisir votre nom.'
                          : 'Please enter your name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: messageController,
                  minLines: 4,
                  maxLines: 6,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: language == AppStrings.languageFr
                        ? 'Votre message'
                        : 'Your message',
                    prefixIcon: const Icon(Icons.message_outlined),
                    border: const OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return language == AppStrings.languageFr
                          ? 'Veuillez saisir votre message.'
                          : 'Please enter your message.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                language == AppStrings.languageFr ? 'Annuler' : 'Cancel',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.of(dialogContext).pop(true);
                }
              },
              icon: const Icon(Icons.send_rounded, size: 18),
              label: Text(
                language == AppStrings.languageFr ? 'Envoyer' : 'Send',
              ),
            ),
          ],
        ),
      );

      if (shouldSend != true || !context.mounted) return;

      final uri = Uri.https('wa.me', '/243988431960', <String, String>{
        'text':
            'Nom: ${nameController.text.trim()}\n\nMessage: ${messageController.text.trim()}',
      });
      await _openLink(context, uri.toString());
    } finally {
      nameController.dispose();
      messageController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      color: AppColors.primaryBlue,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 52,
        horizontal: isMobile ? 20 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 20 : 28),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              children: [
                Text(
                  AppStrings.contactSubtitle(language),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 18,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _contactItem(
                      Icons.person,
                      'Mr FERDINAND MUHEMEDI MAKUSUDI\nPresident General Manager',
                      isMobile,
                    ),
                    _contactItem(
                      Icons.phone,
                      'Mobile\n+243 835 020 992',
                      isMobile,
                      onTap: () => _openLink(context, 'tel:+243835020992'),
                    ),
                    _contactItem(
                      Icons.chat,
                      'WhatsApp\n+256 780 577 334',
                      isMobile,
                      onTap: () =>
                          _openLink(context, 'https://wa.me/+256780577334'),
                    ),
                    _contactItem(
                      Icons.email_outlined,
                      'Email\ncasagetprojetimmobilier@gmail.com',
                      isMobile,
                      onTap: () => _openLink(
                        context,
                        'mailto:casagetprojetimmobilier@gmail.com?subject=Demande%20de%20renseignements',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () =>
                          _openLink(context, 'https://instagram.com/casaget'),
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Instagram'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentGold,
                        foregroundColor: AppColors.primaryBlue,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 24,
                          vertical: isMobile ? 14 : 18,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () =>
                          _openLink(context, 'https://facebook.com/casaget'),
                      icon: const Icon(Icons.facebook),
                      label: const Text('Facebook'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentGold,
                        foregroundColor: AppColors.primaryBlue,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 24,
                          vertical: isMobile ? 14 : 18,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _openLink(context, 'https://x.com/casaget'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentGold,
                        foregroundColor: AppColors.primaryBlue,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 24,
                          vertical: isMobile ? 14 : 18,
                        ),
                      ),
                      child: const Text('X'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _showMessageDialog(context),
                  icon: const Icon(Icons.send_rounded),
                  label: Text(
                    language == AppStrings.languageFr
                        ? 'Envoyer un message'
                        : 'Send a message',
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactItem(
    IconData icon,
    String value,
    bool isMobile, {
    VoidCallback? onTap,
  }) {
    final width = isMobile ? 220.0 : 260.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: width,
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: isMobile ? 30 : 38,
              height: isMobile ? 30 : 38,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColors.accentGold,
                size: isMobile ? 16 : 18,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 12 : 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
