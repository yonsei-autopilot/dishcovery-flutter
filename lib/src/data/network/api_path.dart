enum ApiPath {
  login,
}

extension ApiPathExt on ApiPath {
  String get path {
    switch (this) {
      case ApiPath.login:
        return "/auth/login/google";
    }
  }
}
