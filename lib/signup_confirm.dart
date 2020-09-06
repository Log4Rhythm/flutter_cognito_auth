import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

class SignupConfirmScreen extends StatelessWidget {
  final _registrationKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CognitoUserPoolData cognitoUserPoolData =
        ModalRoute.of(context).settings.arguments;
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
                  'Confirmation',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 8),
                Text(
                  '入力したメールアドレスに送信されたコードを確認してください',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _registrationKeyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Registration key',
                    prefixIcon: Icon(
                      Icons.dialpad,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                RaisedButton(
                  onPressed: () async {
                    String userRegistrationKey =
                        _registrationKeyController.text;
                    try {
                      await cognitoUserPoolData.user
                          .confirmRegistration(userRegistrationKey);
                      Navigator.pushNamed(context, '/signin');
                    } on CognitoClientException catch (e) {
                      print(e);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '確認',
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
