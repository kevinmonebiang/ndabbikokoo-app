import 'package:flutter_test/flutter_test.dart';

import 'package:ndabbikokoo_app/app.dart';

void main() {
  testWidgets('app loads login screen', (tester) async {
    await tester.pumpWidget(const NdabbikokooApp());
    await tester.pumpAndSettle();

    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.text('Numero membre, email ou telephone'), findsOneWidget);
  });
}
