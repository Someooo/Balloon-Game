import 'package:flutter/material.dart';
import 'package:flutter_embed_unity/flutter_embed_unity.dart';

class UnityPreviewScreen extends StatefulWidget {
  const UnityPreviewScreen({super.key});

  @override
  State<UnityPreviewScreen> createState() => _UnityPreviewScreenState();
}

class _UnityPreviewScreenState extends State<UnityPreviewScreen> {
  static const String _targetGameObject = 'GameManager';
  static const String _targetMethod = 'RestartGame';
  static const String _initialMessage = 'Waiting for Unity events...';

  late final ValueNotifier<String> _latestMessageNotifier;

  @override
  void initState() {
    super.initState();
    _latestMessageNotifier = ValueNotifier<String>(_initialMessage);
  }

  @override
  void dispose() {
    _latestMessageNotifier.dispose();
    super.dispose();
  }

  void _handleUnityMessage(String message) {
    if (!mounted) {
      return;
    }
    final String sanitizedMessage = message.trim();
    _latestMessageNotifier.value =
        sanitizedMessage.isEmpty ? _initialMessage : sanitizedMessage;
  }

  void _restartGame() {
    sendToUnity(_targetGameObject, _targetMethod, '');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Balloon Game'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: ColoredBox(
                color: Colors.black,
                child: EmbedUnity(
                  onMessageFromUnity: _handleUnityMessage,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ValueListenableBuilder<String>(
                        valueListenable: _latestMessageNotifier,
                        builder: (
                          BuildContext context,
                          String latestMessage,
                          Widget? child,
                        ) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Latest Message from Unity:',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                latestMessage,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: _restartGame,
                        child: const Text('Restart Game'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
