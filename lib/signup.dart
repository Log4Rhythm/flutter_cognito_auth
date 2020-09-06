import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cognito_auth/auth.dart';
import 'package:flutter_cognito_auth/auth_functions.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:jwt_decode/jwt_decode.dart';

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
                      onPressed: () async {
                        // auth_functions.dartに定義した関数(認証エンドポイントのURL作成用)
                        final url = createOAuthUrl(
                            cognitoUserPool,
                            cognitoDomain,
                            'Google',
                            cognitoOAuthResponseType,
                            callbackScheme,
                            cognitoScope);
                        try {
                          final result = await FlutterWebAuth.authenticate(
                              url: url, callbackUrlScheme: callbackScheme);
                          final cognitoAuthCode =
                              Uri.parse(result).queryParameters['code'];

                          // トークンエンドポイントのURLを作成
                          final tokenEndpoint = Uri.https(
                              cognitoDomain +
                                  '.auth.' +
                                  cognitoUserPool.getRegion() +
                                  '.amazoncognito.com',
                              '/oauth2/token');

                          http.Response response;

                          try {
                            // トークンエンドポイントにhttpリクエストを送る
                            response = await http.post(
                              tokenEndpoint,
                              headers: {
                                'Content-Type':
                                    'application/x-www-form-urlencoded'
                              },
                              body: {
                                'grant_type': 'authorization_code',
                                'client_id': cognitoUserPool.getClientId(),
                                'code': cognitoAuthCode,
                                'redirect_uri': callbackScheme + '://',
                                'scope': cognitoScope,
                              },
                            );

                            // レスポンスから各種トークンを取得
                            final refreshToken =
                                json.decode(response.body)['refresh_token'];
                            final idToken =
                                json.decode(response.body)['id_token'];
                            final accessToken =
                                json.decode(response.body)['access_token'];
                            print(refreshToken);
                            print(idToken);
                            print(accessToken);

                            // これ以下, 一意なユーザーIDを取得する
                            final cognitoIdToken = CognitoIdToken(idToken);
                            // ユーザプールのsubを取得する場合
                            final payload =
                                Jwt.parseJwt(cognitoIdToken.getJwtToken());
                            final userIdSub = payload['sub'];
                            print('sub: ' + userIdSub);

                            // IDプールのIdentity IDを取得する場合
                            CognitoCredentials cognitoCredentials =
                                CognitoCredentials(
                                    cognitoIdentityPoolId, cognitoUserPool);
                            await cognitoCredentials.getAwsCredentials(
                                cognitoIdToken.getJwtToken());
                            final userIdIdentityId =
                                cognitoCredentials.userIdentityId;
                            print('IdentityID: ' + userIdIdentityId);

                            print('Successfully logged in.');
                          } catch (e) {
                            print(e);
                          }
                        } on PlatformException catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Google で登録'),
                    ),
                    OutlineButton(
                      onPressed: () {
                        // 上記のGoogleで登録のcreateOAuthUrl()に渡す3つ目の引数を'LINE'(Cognitoで登録したプロバイダー名)にかえるだけ
                        // それ以外はすべて同じ
                      },
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
