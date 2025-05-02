import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);
  Future<MenuUser> call() {
    return repo.loginWithGoogle();
  }
}

class CheckLoginUseCase {
  final AuthRepository repo;
  CheckLoginUseCase(this.repo);
  Future<bool> call() {
    return repo.isLoggedIn();
  }
}
