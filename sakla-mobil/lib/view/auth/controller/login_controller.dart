import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sakla/core/constants/locale_cache_enum.dart';
import 'package:sakla/core/init/cache/locale_manager.dart';
import '../../../core/constants/navigation/navigation_constants.dart';

class LoginController extends GetxController {
  FocusNode myFocusNodeEmail = FocusNode();
  FocusNode myFocusNodePassword = FocusNode();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  GlobalKey keyEmail = GlobalKey<FormFieldState>();
  GlobalKey keyPass = GlobalKey<FormFieldState>();

  var isPasswordShow = true.obs;
  get isPasswordShows => isPasswordShow.value;
  set isPasswordShows(isPasswordShow) =>
      this.isPasswordShow.value = isPasswordShow;

  var responseBodyLength;
  var userPassword;
  var userNameAndSurname;
  var userEmail;

  var isLogins = false.obs;
  get isLogin => isLogins.value;
  set isLogin(isSignUp) => isLogins.value = isSignUp;

  void changeSignUpStatus() {
    isLogin = !isLogin;
  }

  void changePasswordIcon() {
    isPasswordShows = !isPasswordShows;
  }

  Future login() async {
    final prefs = LocaleManager.instance;
    if (formKey.currentState!.validate()) {
      changeSignUpStatus();
      var response = await http.post(
          Uri.parse(
              'https://expers-68-market-back-end.herokuapp.com/api/v1/bringUserInfoWithEmailSakla/${loginEmailController.text}'),
          body: {
            'name_surname	': 'id.toString()',
            'email': 'id.toString()',
            'password': 'widget.sessionID.toString()',
          });

      //TODO: change back end auth
      if (response.body.toString().length > 2) {
        userPassword = jsonDecode(response.body)[0]['password'].toString();
        userNameAndSurname =
            jsonDecode(response.body)[0]['name_surname'].toString();
        userEmail = jsonDecode(response.body)[0]['email'].toString();

        if (userPassword == loginPassController.text) {
          await prefs.setStringValue(PreferencesKeys.E_MAIL, userEmail);
          await prefs.setStringValue(
              PreferencesKeys.NAME_SURNAME, userNameAndSurname);
          await navigateToBaseView();
        } else {
          changeSignUpStatus();
          Get.snackbar('Error', 'Wrong Email or Password');
        }
      }
    }
  }

  Future<void>? navigateToBaseView() {
    Get.offAndToNamed(NavigationConstants.BASE);
  }

  Future<void>? navigateToSignUpView() {
    Get.offAndToNamed(NavigationConstants.SIGN_UP);
  }
}
