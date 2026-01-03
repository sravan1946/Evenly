import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:evenly/main.dart';

void main() {
  testWidgets('App starts and shows home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: EvenlyApp(),
      ),
    );

    // Verify that the app title is shown.
    expect(find.text('Evenly'), findsOneWidget);
    expect(find.text('Start New Split'), findsOneWidget);
  });
}
