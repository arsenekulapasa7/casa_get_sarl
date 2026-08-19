import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    required this.language,
  });

  final String language;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white70,
          height: 1.6,
        ) ??
        const TextStyle(color: Colors.white70, height: 1.6);

    final footerItems = [
      AppStrings.footerLegal(language),
      AppStrings.footerRegistration(language),
      AppStrings.footerAddress(language),
      AppStrings.footerCopyright(language),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      color: AppColors.primaryBlue,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 12,
                runSpacing: 10,
                children: footerItems
                    .asMap()
                    .entries
                    .map((entry) {
                      final index = entry.key;
                      final item = entry.value;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (index > 0)
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                '•',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          Flexible(
                            child: Text(
                              item,
                              style: index == 0
                                  ? const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )
                                  : textStyle,
                            ),
                          ),
                        ],
                      );
                    })
                    .toList(),
              ),
              const SizedBox(height: 18),
              Text(
                AppStrings.footerTagline(language),
                style: const TextStyle(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
