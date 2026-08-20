import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({
    super.key,
    required this.language,
    required this.onLanguageChanged,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final String language;
  final ValueChanged<String> onLanguageChanged;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  void _openMobileMenu(BuildContext context, List<String> navItems) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null && scaffold.hasEndDrawer) {
      scaffold.openEndDrawer();
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: navItems.asMap().entries.map((entry) {
            return ListTile(
              leading: Icon(_iconForIndex(entry.key)),
              title: Text(entry.value),
              selected: selectedIndex == entry.key,
              onTap: () {
                Navigator.of(sheetContext).pop();
                onItemSelected(entry.key);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _iconForIndex(int index) {
    return switch (index) {
      0 => Icons.home_rounded,
      1 => Icons.info_outline_rounded,
      2 => Icons.design_services_rounded,
      3 => Icons.folder_copy_rounded,
      4 => Icons.surfing_rounded,
      5 => Icons.auto_stories_rounded,
      6 => Icons.contact_mail_rounded,
      _ => Icons.circle_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool isMobile = width < 900;
    final bool isCompact = width < 430;
    final navItems = AppStrings.navItems(language);
    final brandSubtitle = AppStrings.brandSubtitle(language);

    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isCompact ? 10.0 : 16.0) : 40.0,
        vertical: 12.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isCompact ? 6.0 : 8.0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Icon(
                    Icons.business_rounded,
                    color: AppColors.accentGold,
                    size: isCompact ? 24 : 28,
                  ),
                ),
                SizedBox(width: isCompact ? 8 : 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CASA GET SARL',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isCompact ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (!isCompact)
                        Text(
                          brandSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textDark,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile)
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    ...navItems.asMap().entries.map((entry) => _navItem(entry.value, entry.key)),
                    _languageSelector(),
                  ],
                ),
              ),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _languageSelector(),
                const SizedBox(width: 4),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  icon: const Icon(Icons.menu, color: AppColors.primaryBlue),
                  onPressed: () => _openMobileMenu(context, navItems),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title, int index) {
    final bool isSelected = selectedIndex == index;
    final bool isLeisure = title.toLowerCase() == 'leisure' || title.toLowerCase() == 'loisirs';
    final bool isBlog = title.toLowerCase() == 'blog';

    final Color baseColor = isBlog ? AppColors.blogPurple : isLeisure ? AppColors.leisureBlue : AppColors.primaryBlue;
    final Color softColor = isBlog ? AppColors.blogLight : isLeisure ? AppColors.leisureLight : AppColors.backgroundLight;
    final IconData icon = _iconForIndex(index);

    final decoration = isSelected
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: [baseColor, baseColor.withOpacity(0.82)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: baseColor.withOpacity(0.22),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          )
        : BoxDecoration(
            color: softColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: baseColor.withOpacity(0.18)),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onItemSelected(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
          decoration: decoration,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : baseColor,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                  color: isSelected ? Colors.white : baseColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.language, size: 16, color: AppColors.primaryBlue),
          const SizedBox(width: 6),
          _langOption(AppStrings.languageFr),
          const Text(' | ', style: TextStyle(color: Colors.grey)),
          _langOption(AppStrings.languageEn),
        ],
      ),
    );
  }

  Widget _langOption(String lang) {
    final bool isSelected = language == lang;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onLanguageChanged(lang),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          lang,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppColors.accentGold : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
