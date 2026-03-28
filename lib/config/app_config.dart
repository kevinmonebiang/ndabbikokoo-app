class AppConfig {
  static const String appName = 'PIL - GWEHA';
  static const String associationName = 'PIL - GWEHA NDAB BIKOKOO';
  static const String logoAsset = 'assets/branding/logo.png';

  static const bool useMockData = bool.fromEnvironment(
    'USE_MOCK_DATA',
    defaultValue: true,
  );

  static const String odooBaseUrl = String.fromEnvironment(
    'ODOO_BASE_URL',
    defaultValue: '',
  );

  static const String odooLoginPath = String.fromEnvironment(
    'ODOO_LOGIN_PATH',
    defaultValue: '/api/mobile/member/login',
  );

  static const String odooPortalPath = String.fromEnvironment(
    'ODOO_PORTAL_PATH',
    defaultValue: '/api/mobile/member/portal',
  );
}

