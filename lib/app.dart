import 'package:flutter/material.dart';

import 'config/app_config.dart';
import 'models/member_portal_data.dart';
import 'repositories/member_repository.dart';
import 'repositories/mock_member_repository.dart';
import 'repositories/odoo_member_repository.dart';
import 'screens/home_shell.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

class NdabbikokooApp extends StatefulWidget {
  const NdabbikokooApp({super.key});

  @override
  State<NdabbikokooApp> createState() => _NdabbikokooAppState();
}

class _NdabbikokooAppState extends State<NdabbikokooApp> {
  late final MemberRepository _repository;
  MemberPortalData? _session;

  @override
  void initState() {
    super.initState();
    _repository = AppConfig.useMockData
        ? MockMemberRepository()
        : OdooMemberRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: _session == null
          ? LoginScreen(
              onLogin: _repository.signIn,
              onAuthenticated: _openSession,
            )
          : HomeShell(
              data: _session!,
              onLogout: _closeSession,
            ),
    );
  }

  void _openSession(MemberPortalData data) {
    setState(() {
      _session = data;
    });
  }

  void _closeSession() {
    setState(() {
      _session = null;
    });
  }
}
