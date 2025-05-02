import 'package:smart_menu_flutter/src/data/local/token_storage.dart';
import 'package:smart_menu_flutter/src/domain/entities/user.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TokenStorage tokenStorage;

  AuthRepositoryImpl(this.tokenStorage);

  @override
  Future<MenuUser> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication authentication =
        await googleUser!.authentication;

    tokenStorage.setAccessToken("test");
    tokenStorage.setRefreshToken("test");

    // 서버랑 로그인
    return MenuUser(id: "0", password: "password");
  }

  @override
  Future<bool> isLoggedIn() async {
    final String? accessToken = tokenStorage.getAccessToken();
    final String? refreshToken = tokenStorage.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      await Future.wait([
        tokenStorage.removeAccessToken(),
        tokenStorage.removeRefreshToken()
      ]);
      return false;
    }

    return true;
  }
}
