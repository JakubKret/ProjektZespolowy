import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hdk_mobile_app/main.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const ProviderScope(child: Krwiodawstwo()));
    await tester.pumpAndSettle();

    expect(find.text('Krwiodawstwo'), findsOneWidget);
  });
}
