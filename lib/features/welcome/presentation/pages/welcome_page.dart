import 'package:balloon_game/features/welcome/domain/entities/welcome_content.dart';
import 'package:balloon_game/features/welcome/presentation/widgets/start_play_button.dart';
import 'package:balloon_game/features/welcome/presentation/widgets/welcome_header_section.dart';
import 'package:balloon_game/features/welcome/presentation/widgets/welcome_logo_badge.dart';
import 'package:balloon_game/unity_preview_screen.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    this.content = WelcomeContent.defaultContent,
    super.key,
  });

  final WelcomeContent content;

  void _navigateToUnityPreview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const UnityPreviewScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WelcomeLogoBadge(logoAssetPath: content.logoAssetPath),
                const SizedBox(height: 32),
                WelcomeHeaderSection(
                  title: content.title,
                  subtitle: content.subtitle,
                ),
                const SizedBox(height: 40),
                StartPlayButton(
                  label: content.buttonLabel,
                  onPressed: () => _navigateToUnityPreview(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
