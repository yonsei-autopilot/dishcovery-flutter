import '../entities/user.dart';

abstract class AuthRepository {
  Future<MenuUser> loginWithGoogle();
}