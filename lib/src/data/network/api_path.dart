enum ApiPath { googleLogin, simpleLogin, menuTranslation }

extension ApiPathExt on ApiPath {
  String get path {
    switch (this) {
      case ApiPath.googleLogin:
        return "/auth/login/google";
      case ApiPath.simpleLogin:
        return "/auth/login/simple";
      case ApiPath.menuTranslation:
        return "/menus/translation";
    }
  }
}
