class APIEndpoint {
  const APIEndpoint._();

  static const String BASE_URL = 'http://192.168.1.102:8000/api/';
  static const String LOGIN_URL = '${BASE_URL}login';
  static const String REGISTER_URL = '${BASE_URL}register';
  static const String LOGOUT_URL = '${BASE_URL}logout';

  static const String USER_PROFILE_URL = '${BASE_URL}profile';

  static const Map<String, String> HEADERS = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
