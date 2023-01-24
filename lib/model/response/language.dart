/// This represents an Language model class
class Language {
  Language(
      {required this.isChecked,
      required this.name,
      required this.langCode,
      required this.image});

  final String name;
  final String langCode;
  final String image;
  bool isChecked;
}
