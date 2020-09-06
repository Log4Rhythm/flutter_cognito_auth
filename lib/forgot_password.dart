import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_auth/auth.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 64),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reset your password',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 8),
                Text(
                  '登録済みのメールアドレスを入力してください\nリセットコードを送信します',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                SizedBox(height: 32),
                RaisedButton(
                  onPressed: () async {
                    String userEmail = _emailController.text;

                    CognitoUser cognitoUser =
                        CognitoUser(userEmail, cognitoUserPool);
                    try {
                      await cognitoUser.forgotPassword();
                      Navigator.pushNamed(context, '/reset_password',
                          arguments: cognitoUser);
                    } catch (e) {
                      print(e);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '送信',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
