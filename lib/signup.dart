import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_auth/auth.dart';

class SignupScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  'Signup',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(
                      Icons.alternate_email,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                RaisedButton(
                  onPressed: () async {
                    String userEmail = _emailController.text;
                    String userPassword = _passwordController.text;

                    try {
                      CognitoUserPoolData cognitoUserPoolData =
                          await cognitoUserPool.signUp(userEmail, userPassword);
                      Navigator.pushNamed(context, '/signup_confirm',
                          arguments: cognitoUserPoolData);
                    } on CognitoClientException catch (e) {
                      print(e);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '登録',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/signin', (route) => false);
                  },
                  child: Text('ログインはこちら'),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlineButton(
                      onPressed: () {},
                      child: Text('Google で登録'),
                    ),
                    OutlineButton(
                      onPressed: () {},
                      child: Text('LINE で登録'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
