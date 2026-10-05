import 'package:flutter_test/flutter_test.dart';
import 'package:uni_sphere/main.dart';

void main() {
  testWidgets('Uni-Sphere student dashboard loads properly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const UniSphereApp());
    await tester.pumpAndSettle();

    // Verify student greeting and credits are displayed
    expect(find.text('Hello, Zara!'), findsOneWidget);
    expect(find.text('72'), findsWidgets);
    expect(find.text('3.7'), findsWidgets);
    expect(find.text('89%'), findsWidgets);
    expect(find.text('Data\nStructures'), findsOneWidget);
  });
}
