import 'package:flutter_application/oauth2_interceptor.dart';

abstract class AuthenticationModel with OAuthInfoMixin {
  String get accessToken;
  String get refreshToken;
}
