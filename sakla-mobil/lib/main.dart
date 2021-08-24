import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sakla/core/init/cache/locale_manager.dart';
import 'package:sakla/view/auth/view/splash_view.dart';

import 'core/constants/locale_cache_enum.dart';
import 'core/constants/navigation/navigation_constants.dart';
import 'core/init/navigation/app_pages.dart';
import 'core/init/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.prefrenceInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sakla',
      initialRoute: NavigationConstants.INITIAL,
      theme: AppTheme.instance.darkTheme,
      home: SplashView(),
      getPages: AppPages.pages,
    );
  }
}
