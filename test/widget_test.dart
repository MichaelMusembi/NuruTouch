import 'package:flutter_test/flutter_test.dart';
import 'package:nurutouch/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Splash screen test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: NuruTouchApp()));
    // Let FutureProvider resolve
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // After resolving and navigating we are on the language screen
    // The language title from the localization should be there
    expect(find.text('Select Language'), findsWidgets);
  });
}
