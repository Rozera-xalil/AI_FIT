import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controllers/lang_controller.dart';
import 'controllers/tasks_controller.dart';
import 'controllers/recom_controller.dart';
import 'services/notification_service.dart';
import 'screens/splash_screen.dart';
import 'languages/app_translations.dart';
import 'constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  await NotificationService.init();
  runApp(const KrdFitApp());
}

class KrdFitApp extends StatelessWidget {
  const KrdFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KRD FIT',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        scaffoldBackgroundColor: C.bg,
        fontFamily: 'Rajdhani',
        colorScheme: const ColorScheme.dark(
          primary: C.purple,
          secondary: C.gold,
          surface: C.bgSurface,
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(LangController(), permanent: true);
        Get.put(TasksController(), permanent: true);
        Get.put(RecomController(), permanent: true);
      }),
      home: const SplashScreen(),
    );
  }
}