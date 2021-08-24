import 'package:get/route_manager.dart';

import '../../../view/auth/view/login_view.dart';
import '../../../view/auth/view/sign_up_view.dart';
import '../../../view/baseview/base_view.dart';
import '../../constants/navigation/navigation_constants.dart';

class AppPages {
  static final pages = [
    GetPage(name: NavigationConstants.LOGIN, page: () => LoginView()),
    GetPage(name: NavigationConstants.SIGN_UP, page: () => SignUpView()),
    GetPage(name: NavigationConstants.BASE, page: () => BaseView()),
  ];
}


