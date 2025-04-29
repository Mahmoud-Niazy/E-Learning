import 'package:e_learning/core/localization/languages/ar.dart';
import 'package:e_learning/core/localization/languages/en.dart';
import 'package:get/get.dart';

class AppLanguages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'ar': arabicLanguage,
    'en': englishLanguage,
  };

}