enum ApiPath {
  googleLogin,
  simpleLogin,

  menuTranslation,
  menuExplanation,
  menuOrder,
  foreignLanguageOfMenu,

  disLikeFoods,
  language
}

extension ApiPathExt on ApiPath {
  String get path {
    switch (this) {
      case ApiPath.googleLogin:
        return "/auth/login/google";
      case ApiPath.simpleLogin:
        return "/auth/login/simple";
      case ApiPath.menuTranslation:
        return "/menus/translation";
      case ApiPath.menuExplanation:
        return "/menus/explanation";
      case ApiPath.menuOrder:
        return "/menus/order";
      case ApiPath.foreignLanguageOfMenu:
        return "/menus/foreign-language-of-menu";
      case ApiPath.disLikeFoods:
        return "/user/dislike-foods";
      case ApiPath.language:
        return "/user/language";
    }
  }
}
