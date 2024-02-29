import 'package:flutter/material.dart';
import '../../../core/extension/context_extensions.dart';
import '../../../core/theme/text/app_text.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.bodyMedium(
          context,
          title,
          color: context.xMaterialColorTheme.onSurfaceVariant,
        ),
        AppText.bodyLarge(
          context,
          subTitle,
          color: context.xMaterialColorTheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
