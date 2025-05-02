import 'package:smart_menu_flutter/src/domain/entities/user.dart';
import 'package:smart_menu_flutter/src/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthRepository implements AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<MenuUser> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication authentication =
        await googleUser!.authentication;

    print(authentication.accessToken);
    print(authentication.idToken);
    print(authentication.toString());

    // 서버랑 로그인
    return new MenuUser(id: "0", password: "password");
  }
}
