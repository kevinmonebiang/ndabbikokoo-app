import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ndabbikokoo_app/models/member_portal_data.dart';
import 'package:ndabbikokoo_app/repositories/mock_member_repository.dart';
import 'package:ndabbikokoo_app/screens/home_shell.dart';
import 'package:ndabbikokoo_app/screens/login_screen.dart';
import 'package:ndabbikokoo_app/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MemberPortalData data;

  setUpAll(() async {
    data = await MockMemberRepository().signIn(
      identifier: 'BAS-24017',
      secret: '1234',
    );
  });

  testWidgets('generate app screenshots', (tester) async {
    await _captureLogin(tester, data);
    await _captureDashboard(tester, data);
    await _captureProfile(tester, data);
    await _captureContributions(tester, data);
    await _captureInfo(tester, data);
  });
}

Future<void> _captureLogin(
  WidgetTester tester,
  MemberPortalData data,
) async {
  await tester.binding.setSurfaceSize(const Size(430, 932));
  await tester.pumpWidget(
    _wrap(
      LoginScreen(
        onLogin: ({
          required String identifier,
          required String secret,
        }) async {
          return data;
        },
        onAuthenticated: (_) {},
      ),
    ),
  );
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('../screenshots/01-login.png'),
  );
}

Future<void> _captureDashboard(
  WidgetTester tester,
  MemberPortalData data,
) async {
  await tester.binding.setSurfaceSize(const Size(430, 932));
  await tester.pumpWidget(
    _wrap(
      HomeShell(
        data: data,
        onLogout: () {},
      ),
    ),
  );
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('../screenshots/02-accueil.png'),
  );
}

Future<void> _captureProfile(
  WidgetTester tester,
  MemberPortalData data,
) async {
  await tester.binding.setSurfaceSize(const Size(430, 932));
  await tester.pumpWidget(
    _wrap(
      HomeShell(
        data: data,
        onLogout: () {},
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Profil'));
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('../screenshots/03-profil.png'),
  );
}

Future<void> _captureContributions(
  WidgetTester tester,
  MemberPortalData data,
) async {
  await tester.binding.setSurfaceSize(const Size(430, 932));
  await tester.pumpWidget(
    _wrap(
      HomeShell(
        data: data,
        onLogout: () {},
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Cotisations'));
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('../screenshots/04-cotisations.png'),
  );
}

Future<void> _captureInfo(
  WidgetTester tester,
  MemberPortalData data,
) async {
  await tester.binding.setSurfaceSize(const Size(430, 932));
  await tester.pumpWidget(
    _wrap(
      HomeShell(
        data: data,
        onLogout: () {},
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('Infos'));
  await tester.pumpAndSettle();
  await expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('../screenshots/05-infos.png'),
  );
}

Widget _wrap(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.build(),
    home: child,
  );
}
