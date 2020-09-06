import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cognito_auth/auth.dart';

class SigninScreen extends StatelessWidget {
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
                  'Signin',
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
                SizedBox(height: 8),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot_password');
                  },
                  child: Text(
                    'パスワードを忘れた',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    String userEmail = _emailController.text;
                    String userPassword = _passwordController.text;

                    CognitoUser cognitoUser =
                        CognitoUser(userEmail, cognitoUserPool);
                    final authenticationDetails = AuthenticationDetails(
                        username: userEmail, password: userPassword);
                    try {
                      final cognitoUserSession = await cognitoUser
                          .authenticateUser(authenticationDetails);

                      final refreshToken =
                          cognitoUserSession.getRefreshToken().toString();
                      final idToken =
                          cognitoUserSession.getIdToken().toString();
                      final accessToken =
                          cognitoUserSession.getAccessToken().toString();
                      print(refreshToken);
                      print(idToken);
                      print(accessToken);
                      print('Successfully logged in.');
                    } catch (e) {
                      print(e);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'ログイン',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/signup', (route) => false);
                  },
                  child: Text('新規登録はこちら'),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlineButton(
                      onPressed: () {
                        // signup.dartのGoogleで登録と同じ
                      },
                      child: Text('Google でログイン'),
                    ),
                    OutlineButton(
                      onPressed: () {
                        // signup.dartのLINEで登録と同じ
                      },
                      child: Text('LINE でログイン'),
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
