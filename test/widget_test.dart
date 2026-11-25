import 'package:balloon_game/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BalloonGameApp welcome screen test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BalloonGameApp());
    expect(find.text('Welcome to Balloon Pop'), findsOneWidget);
    expect(find.text('Start Play'), findsOneWidget);
  });
}
