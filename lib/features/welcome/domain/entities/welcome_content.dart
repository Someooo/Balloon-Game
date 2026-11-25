class WelcomeContent {
  const WelcomeContent({
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.logoAssetPath,
  });

  static const WelcomeContent defaultContent = WelcomeContent(
    title: 'Welcome to Balloon Pop',
    subtitle: 'Tap below to launch the Unity experience',
    buttonLabel: 'Start Play',
    logoAssetPath: 'assets/images/Balloon GameLogo.jpg',
  );

  final String title;
  final String subtitle;
  final String buttonLabel;
  final String logoAssetPath;
}
