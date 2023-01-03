
class ApiConstant{
  static String apiKey = 'AIzaSyCc-Vohe66YJiMvDNJvWARkXlYLSwCrRKY';
static String baseUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:';
static String apiSignIn = "${baseUrl }signInWithPassword?key=$apiKey";
static String apiSignUp = "${baseUrl }signUp?key=$apiKey";

}

