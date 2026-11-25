import 'package:flutter/material.dart';

class WelcomeLogoBadge extends StatelessWidget {
  const WelcomeLogoBadge({
    required this.logoAssetPath,
    super.key,
  });

  final String logoAssetPath;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: colorScheme.primaryContainer,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        logoAssetPath,
        fit: BoxFit.cover,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
        ) {
          return Icon(
            Icons.bubble_chart_rounded,
            size: 56,
            color: colorScheme.onPrimaryContainer,
          );
        },
      ),
    );
  }
}
