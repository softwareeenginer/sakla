import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:sakla/core/constants/locale_cache_enum.dart';
import 'package:sakla/core/constants/navigation/navigation_constants.dart';
import 'package:http/http.dart' as http;
import 'package:sakla/core/init/cache/locale_manager.dart';

class SignUpController extends GetxController {
  final signupEmailController = TextEditingController();
  final signupPassController = TextEditingController();
  final signupPassConfirmController = TextEditingController();

  final signupNameAndSurnameController = TextEditingController();

  final keyEmail = GlobalKey<FormFieldState>();
  final keyPass = GlobalKey<FormFieldState>();
  final keyConfirmPass = GlobalKey<FormFieldState>();

  var isPasswordShow = true.obs;
  get isPasswordShows => isPasswordShow.value;
  set isPasswordShows(isPasswordShow) =>
      this.isPasswordShow.value = isPasswordShow;

  var isSignUps = false.obs;
  get isSignUp => isSignUps.value;
  set isSignUp(isSignUp) => isSignUps.value = isSignUp;

  final formKey = GlobalKey<FormState>();

  void changePasswordIcon() {
    isPasswordShows = !isPasswordShows;
  }

  void changeSignUpStatus() {
    isSignUp = !isSignUp;
  }

  Future<void>? navigateToLoginView() {
    Get.offAllNamed(NavigationConstants.LOGIN);
  }

  Future<void> signUp() async {
    final prefs = await LocaleManager.instance;
    final _url = Uri.parse(
        'https://expers-68-market-back-end.herokuapp.com/api/v1/createNewUserSakla');
    try {
      if (formKey.currentState!.validate()) {
        changeSignUpStatus();
        final response = await http.post(_url, body: {
          'name_surname': signupNameAndSurnameController.text,
          'email': signupEmailController.text,
          'password': signupPassController.text,
        });
        print(response.body);

        if (response.statusCode == HttpStatus.ok) {
          changeSignUpStatus();
          await navigateToBaseView();
          await prefs.setStringValue(
              PreferencesKeys.E_MAIL, signupEmailController.text);
          await prefs.setStringValue(PreferencesKeys.NAME_SURNAME,
              signupNameAndSurnameController.text);
        } else {
          changeSignUpStatus();
          Get.snackbar('Error', 'Please Check Info');
        }
      }
    } catch (e) {
      changeSignUpStatus();
      print(e);
    }
  }

  Future<void>? cacheInfo() async {}

  Future<void>? navigateToBaseView() {
    Get.offAndToNamed(NavigationConstants.BASE);
  }
}
