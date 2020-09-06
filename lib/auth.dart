import 'package:amazon_cognito_identity_dart_2/cognito.dart';

// Cognito User Pool
// 自分で決めたドメイン
// ex.) 'foo-bar123'
const cognitoDomain = 'foo-bar123';

// ユーザープールID
// ex.) 'us-east-1_XXXXXXXXX'
const cognitoUserPoolId = 'us-east-1_XXXXXXXXX';

// アプリクライアントID
// ex.) 'xxxxxxxxxxxxxxxxxxxxxxxxxx'
const cognitoClientId = 'xxxxxxxxxxxxxxxxxxxxxxxxxx';

// コールバックURL
// "://"が含まれないことに注意
const callbackScheme = 'myapp';

// 今回はAUthorization Codeでのレスポンスが欲しいので'code'を指定
// ほかにも'token'なども指定可能
const cognitoOAuthResponseType = 'code';

// ユーザープールで設定したScopeのうちここで使いたいScopeをスペースで区切って入力
const cognitoScope = 'openid email';

// Create Cognito User Pool
// 上で設定したプールIDとアプリクライアントIDをつかって, CognitoUserPoolクラスのオブジェクトを作成.
// これ以降, このオブジェクトを使いまくります
final cognitoUserPool = CognitoUserPool(cognitoUserPoolId, cognitoClientId);

// Cognito ID Pool
// IDプールのID
// ex.) 'us-east-1:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
const cognitoIdentityPoolId = 'us-east-1:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx';

// Lambda / API Gateway
// ex.) 'https://xxxxxxxxxx.execute-api.us-east-1.amazonaws.com'
const apiEndpoint = 'https://xxxxxxxxxx.execute-api.us-east-1.amazonaws.com';
