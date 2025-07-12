abstract class Env {
  // API Configuration
  static const String clientId = String.fromEnvironment(
    'CLIENT_ID',
    defaultValue: '',
  );

  static const String channel = String.fromEnvironment(
    'CHANNEL',
    defaultValue: '',
  );

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: '',
  );

  // Security Keys
  static const String keyPhrase = String.fromEnvironment(
    'KEY_PHRASE',
    defaultValue: '',
  );

  static const String ivPhrase = String.fromEnvironment(
    'IV_PHRASE',
    defaultValue: '',
  );

  // Android Signing Configuration
  static const String storePassword = String.fromEnvironment(
    'STORE_PASSWORD',
    defaultValue: '',
  );

  static const String keyPassword = String.fromEnvironment(
    'KEY_PASSWORD',
    defaultValue: '',
  );

  static const String keyAlias = String.fromEnvironment(
    'KEY_ALIAS',
    defaultValue: '',
  );

  static const String storeFile = String.fromEnvironment(
    'STORE_FILE',
    defaultValue: '',
  );

  // Environment Information
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );

  static const bool isProduction =
      String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev') == 'prod';

  static const bool isDevelopment =
      String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev') == 'dev';

  static const bool isQA =
      String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev') == 'qa';

  // Validation
  static bool get isConfigured {
    return clientId.isNotEmpty && baseUrl.isNotEmpty && channel.isNotEmpty;
  }
}
