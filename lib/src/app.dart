import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'home/home_page.dart';

/// Controller to manage app settings using GetX
class SettingsController extends GetxController {
  var themeMode = ThemeMode.dark.obs;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode.value,
          getPages: [
            GetPage(name: '/', page: () => const HomePage()),
          ],
          initialRoute: '/',
        ));
  }
}
