import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_name'      : 'KRD FIT',
      'app_slogan'    : 'Smart Workout Planner',
      'app_tagline'   : 'For Kurds — For Life',
      // ... (rest of the English translations)
    },
    'ku_TR': {
      'app_name'      : 'KRD FIT',
      'app_slogan'    : 'Plansaziya Werzîşa Biaqil',
      'app_tagline'   : 'Ji bo Kurdan — Ji bo Jiyanê',
      // ... (rest of the Kurdish translations)
    },
    'fr_FR': {
      'app_name'      : 'KRD FIT',
      'app_slogan'    : 'Planificateur Sportif Intelligent',
      'app_tagline'   : 'Pour les Kurdes — Pour la Vie',
      // ... (rest of the French translations)
    },
  };
}