enum UserTypes { loggedInAsGuest }

class GlobalVariables {
  static String languageCode = LanguageCode.languageCodeArabic;
  static UserTypes userType = UserTypes.loggedInAsGuest;
}

class LanguageCode {
  static const String languageCodeEnglish = "en";
  static const String languageCodeArabic = "ar";
}
