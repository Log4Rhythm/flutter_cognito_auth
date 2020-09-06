import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _resetCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CognitoUser cognitoUser = ModalRoute.of(context).settings.arguments;
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
                  'Create new password',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 8),
                Text(
                  'リセットコードと新しいパスワードを入力してください',
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _resetCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Reset code',
                    prefixIcon: Icon(
                      Icons.dialpad,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                RaisedButton(
                  onPressed: () async {
                    String userResetCode = _resetCodeController.text;
                    String userNewPassword = _newPasswordController.text;

                    try {
                      await cognitoUser.confirmPassword(
                          userResetCode, userNewPassword);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/signin', (route) => false);
                    } catch (e) {
                      print(e);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    '作成',
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
