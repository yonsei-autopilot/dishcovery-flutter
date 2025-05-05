enum ApiPath { login, menuTranslation }

extension ApiPathExt on ApiPath {
  String get path {
    switch (this) {
      case ApiPath.login:
        return "/auth/login/google";
      case ApiPath.menuTranslation:
        return "/menus/translation";
    }
  }
}
