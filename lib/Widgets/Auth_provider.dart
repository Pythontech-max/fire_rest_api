import 'dart:convert';

import 'package:fire_rest_api/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../keys.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  AuthStatus _authStatus = AuthStatus.signUp;
  AuthStatus get authStatus => _authStatus;
  bool _isloading = false;
  bool get isloading => _isloading;

  setIsLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setAuthStatus() {
    _authStatus = _authStatus == AuthStatus.signUp
        ? AuthStatus.signIn
        : AuthStatus.signUp;
    notifyListeners();
  }

  authenticate() async {
    _isloading = true;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 2));

    try {
      final response = await http.post(
          Uri.parse(_authStatus == AuthStatus.signUp
              ? ApiConstant.apiSignUp
              : ApiConstant.apiSignIn),
          body: jsonEncode({
            "email": emailController.text,
            "password": passwordController.text,
            "returnSecureToken": true,
          }));
      print(response.body);
    } catch (error) {
      Keys.snackBar(error.toString());
    }
    _isloading = false;
    notifyListeners();
  }
}

enum AuthStatus { signIn, signUp }
