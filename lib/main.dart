import 'package:flutter/material.dart';
import 'package:flutter_cognito_auth/forgot_password.dart';
import 'package:flutter_cognito_auth/reset_password.dart';
import 'package:flutter_cognito_auth/signup_confirm.dart';
import 'package:flutter_cognito_auth/signin.dart';
import 'package:flutter_cognito_auth/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cognito Auth',
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => SignupScreen(),
        '/signup_confirm': (BuildContext context) => SignupConfirmScreen(),
        '/signin': (BuildContext context) => SigninScreen(),
        '/forgot_password': (BuildContext context) => ForgotPasswordScreen(),
        '/reset_password': (BuildContext context) => ResetPasswordScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignupScreen(),
    );
  }
}
