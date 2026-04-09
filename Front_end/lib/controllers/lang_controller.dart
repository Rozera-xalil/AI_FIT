import 'dart:ui';

import 'package:get/get.dart';

class LangController extends GetxController {
  final _locale = const Locale('en', 'US').obs;
  Locale get locale => _locale.value;

  void setLang(String code) {
    switch (code) {
      case 'ku': _locale.value = const Locale('ku', 'TR'); break;
      case 'fr': _locale.value = const Locale('fr', 'FR'); break;
      default: _locale.value = const Locale('en', 'US');
    }
    Get.updateLocale(_locale.value);
  }

  String get currentCode {
    switch (_locale.value.languageCode) {
      case 'ku': return 'ku';
      case 'fr': return 'fr';
      default: return 'en';
    }
  }

  String get currentLabel {
    switch (currentCode) {
      case 'ku': return 'Kurdî';
      case 'fr': return 'Français';
      default: return 'English';
    }
  }
}