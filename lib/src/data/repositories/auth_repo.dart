import 'package:smart_menu_flutter/src/data/local/auth_storage.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login_request.dart';
import 'package:smart_menu_flutter/src/domain/dtos/login_response.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DioService dioService;
  final AuthStorage tokenStorage;

  AuthRepositoryImpl(this.dioService, this.tokenStorage);

  @override
  Future<String> googleAuthenticate() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception("Failed authentication from google");
    }

    final GoogleSignInAuthentication authentication = await googleUser.authentication;
    String? accessToken = authentication.accessToken;
    if (accessToken == null) {
      throw Exception("Failed authentication from google; access token is null");
    }
    return accessToken;
  }

  @override
  Future<LoginResponse> login(String accessToken) async {
    return dioService.request(
      path: ApiPath.login, 
      method: HttpMethod.POST,
      body: LoginRequest(accessToken: accessToken).toJson(),
      decoder: (json) => LoginResponse.fromJson(json),
    );
  }
  
  @override
  void saveTokens(String accessToken, String refreshToken) {
    tokenStorage.setAccessToken(accessToken);
    tokenStorage.setRefreshToken(refreshToken);
  }
}
