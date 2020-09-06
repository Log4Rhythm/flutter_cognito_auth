import 'package:amazon_cognito_identity_dart_2/cognito.dart';

// 認証エンドポイントのURLを作成
String createOAuthUrl(
  CognitoUserPool cognitoUserPool,
  String cognitoDomain,
  String identityProvider,
  String responseType,
  String callbackScheme,
  String cognitoScope,
) {
  return Uri.https(
    cognitoDomain +
        '.auth.' +
        cognitoUserPool.getRegion() +
        '.amazoncognito.com',
    '/oauth2/authorize',
    {
      'client_id': cognitoUserPool.getClientId(),
      'identity_provider': identityProvider,
      'response_type': responseType,
      'redirect_uri': callbackScheme + '://',
      'scope': cognitoScope,
    },
  ).toString();
}
