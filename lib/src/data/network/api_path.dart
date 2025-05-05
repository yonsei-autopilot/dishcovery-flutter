enum ApiPath { login, menuExplanation }

extension ApiPathExt on ApiPath {
  String get path {
    switch (this) {
      case ApiPath.login:
        return "/auth/login/google";
      case ApiPath.menuExplanation:
        return "/menus/explanation";
    }
  }
}
