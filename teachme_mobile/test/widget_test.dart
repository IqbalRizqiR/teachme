import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:teachme_mobile/app/app.dart';

void main() {
  testWidgets('App renders login screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: TeachMeApp()));
    await tester.pump();
    expect(find.text('teachMe'), findsWidgets);
  });
}
