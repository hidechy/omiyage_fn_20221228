class Environment {
  Environment._();

  static const String apiEndPoint = String.fromEnvironment('API_END_POINT');
  static String get apiBasePath => 'api';
}
