import 'dart:convert';

import 'package:fire_rest_api/Model/Auth_error_class.dart';
import 'package:fire_rest_api/api_constant.dart';
import 'package:fire_rest_api/helper.dart';
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

  bool varifyPassword() {
    if (_authStatus == AuthStatus.signUp) {
      if (passwordController.text == confirmPasswordController.text &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  authenticate() async {
    _isloading = true;
    notifyListeners();
    print(varifyPassword());
    // await Future.delayed(Duration(seconds: 2));
    if (varifyPassword()) {
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
        if (response.statusCode == 200) {
          // operation Successfull
          print(response.body);
        } else if (response.statusCode == 400) {
          //operation failed
          //print(response.body);
          Auth_Error autherror = Auth_Error.fromJson(jsonDecode(response.body));
          String _error =
              Helper.authErrorHandler(autherror.error!.message.toString());
          Keys.snackBar(_error);

          //  print(error.error!.message);
        } else {
          Keys.snackBar('Error Ocurred');
        }
      } catch (error) {
        Keys.snackBar(error.toString());
      }
    } else {
      if (passwordController.text.isEmpty &&
          confirmPasswordController.text.isEmpty) {
        Keys.snackBar('Please enter the password ');
      } else {
        Keys.snackBar('Password & confirm password does not match');
      }
    }

    _isloading = false;
    notifyListeners();
  }
}

enum AuthStatus { signIn, signUp }
