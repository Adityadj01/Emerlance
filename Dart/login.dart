import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:emerlance/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'emerlance',
      onLogin: (_) => Future(() => null),
      onSignup: (_) => Future(() => null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      },
      onRecoverPassword: (_) => Future(() => null),
    );
  }
}