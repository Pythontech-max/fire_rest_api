import 'package:fire_rest_api/Widgets/Auth_provider.dart';
import 'package:fire_rest_api/Widgets/Custom_text_feild.dart';
import 'package:fire_rest_api/Widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  controller: authProvider.emailController,
                  iconData: Icons.email,
                  hintText: 'Email'),
              CustomTextField(
                  controller: authProvider.passwordController,
                  iconData: Icons.key,
                  hintText: 'Password'),
              if (authProvider.authStatus == AuthStatus.signUp)
                CustomTextField(
                    controller: authProvider.confirmPasswordController,
                    iconData: Icons.key,
                    hintText: 'Confirm Password'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              if(!authProvider.isloading)
              AuthButton(
                title: authProvider.authStatus == AuthStatus.signUp ? 'Sign Up' : 'Sign In',
                onTap: () {authProvider.authenticate();},
              ),
              if( authProvider.isloading) const CircularProgressIndicator(),
              AuthButton(
                title: 'Forget Password',
                onTap: () {},
              ),
              AuthButton(
                title: authProvider.authStatus == AuthStatus.signUp ? 'Already have an account' : 'Do not have account',
                onTap: () {authProvider.setAuthStatus();},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
