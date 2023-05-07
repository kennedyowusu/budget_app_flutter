class APIEndpoint {
  const APIEndpoint._();

  static const String BASE_URL = 'http://192.168.1.102:8000/api/';
  static const String LOGIN_URL = '${BASE_URL}login';
  static const String REGISTER_URL = '${BASE_URL}register';
  static const String LOGOUT_URL = '${BASE_URL}logout';

  static const String CATEGORY_URL = "${BASE_URL}groups";
  static const String TRANSACTION_URL = "${BASE_URL}expenses";
  // static const String GROUP_EXPENSES_URL =
  //     "${BASE_URL}groups/{group_id}/expenses";

  static String getGroupExpensesUrl(int groupId) {
    return "${BASE_URL}groups/$groupId/expenses";
  }

  debugPrint(groupId) {
    debugPrint("Group ID received in getTransactions Endpoint: $groupId");
  }

  static const String USER_PROFILE_URL = '${BASE_URL}profile';

  static const Map<String, String> HEADERS = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
