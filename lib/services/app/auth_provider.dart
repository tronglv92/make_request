import 'package:dio/dio.dart';
import 'package:makerequest/models/local/token.dart';
import 'package:makerequest/models/remote/login_response.dart';
import 'package:makerequest/services/cache/credential.dart';
import 'package:makerequest/services/rest_api/api_user.dart';
import 'package:makerequest/services/safety/change_notifier_safety.dart';

class AuthProvider extends ChangeNotifierSafety {
  // AuthProvider(this._api, this._credential);
  AuthProvider(this._credential,this._api);
  // /// Authentication api
   ApiUser _api;
  //
  // /// Credential
   Credential _credential;

  @override
  void resetState() {}

  // /// Call api login
  // Future<bool> login(String email, String password) async {
  //   final Response<Map<String, dynamic>> result =
  //   await _api.logIn(email, password).timeout(const Duration(seconds: 30));
  //   final LoginResponse loginResponse = LoginResponse(result.data);
  //   final Token? token = loginResponse.data;
  //   if (token != null) {
  //     /// Save credential
  //     final bool? saveRes = await _credential?.storeCredential(token, cache: true);
  //     return saveRes??false;
  //   } else {
  //     throw DioError(
  //         requestOptions: RequestOptions( path: ''), error: loginResponse.error?.message ?? 'Login error', type: DioErrorType.response);
  //   }
  // }
  //
  // /// Call api login with error
  // Future<LoginResponse> logInWithError() async {
  //   final Response<Map<String, dynamic>> result = await _api.logInWithError().timeout(const Duration(seconds: 30));
  //   final LoginResponse loginResponse = LoginResponse(result.data);
  //   return loginResponse;
  // }
  //
  // /// Call api login with exception
  // Future<void> logInWithException() async {
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //   throw DioError(requestOptions: RequestOptions( path: ''), error: 'Login with exception', type: DioErrorType.response);
  // }
  //
  // /// Call logout
  // Future<bool> logout() async {
  //   await Future<void>.delayed(const Duration(seconds: 1));
  //
  //   /// Save credential
  //   final bool? saveRes = await _credential?.storeCredential(null, cache: true);
  //   return saveRes??false;
  // }
}
