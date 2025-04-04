import 'package:flutter_test/flutter_test.dart';
import 'package:mindful_moments/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MindfulMomentsApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsNothing);
    expect(find.text('Mindful Moments'), findsOneWidget);
  });
}
