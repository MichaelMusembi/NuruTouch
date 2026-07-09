import 'package:flutter_test/flutter_test.dart';
import 'package:nurutouch/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Splash screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: NuruTouchApp()));

    // Verify that the splash screen shows NuruTouch.
    expect(find.text('NuruTouch'), findsWidgets);

    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
