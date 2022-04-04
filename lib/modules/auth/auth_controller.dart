import 'package:crypto_flutter/api/api.dart';
import 'package:crypto_flutter/routes/app_routes.dart';
import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  var signUpNameController = TextEditingController();
  var signUpEmailController = TextEditingController();
  final signUpPassController = TextEditingController();

  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  final signInEmailController = TextEditingController();
  final signInPassController = TextEditingController();
  var isRememberMe = false.obs;
  var isShowLogin = true.obs;



  void changeActive({num? number}) {
    print('debugging');
    if (number == 1 && isShowLogin.value == false) {
      isShowLogin.value = true;
    }
    if (number == 2 && isShowLogin.value == true) {
      isShowLogin.value = false;
    }
  }

  submitLogin() async {
    //signInKey.currentState.validate();
    final isValid = signInKey.currentState!.validate();
    if (true) {
      var result = await fetch(
          url: ApiConstans.signIn,
          newUrl: ApiConstans.authenUrl,
          body: {
            // 'email': signInEmailController.text,
            // 'password': signInPassController.text
            "email": "eve.holt@reqres.in",
            "password": "pistol"
          });
      final prefs = Get.find<SharedPreferences>();
      String token = result['token'];
      if (token.isNotEmpty) {
        prefs.setString(SharePreferencesConstants.token, token);
        Get.toNamed(Routes.HOME);
      }
    }
  }

  void submitRegister() {
    final isValid = signUpKey.currentState!.validate();
    print(isValid);
  }

  String? checkEmail(String? value) {
    if (value!.isNotEmpty && !Regex.isEmail(value)) {
      return 'Email format error.';
    }

    if (value.isEmpty) {
      return 'Email is required.';
    }
    return null;
  }

  String? checkName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? checkPassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < 6 || value.length > 15) {
      return 'Password should be 6~15 characters';
    }

    return null;
  }

  @override
  void onClose() {
    super.onClose();

    signUpNameController.dispose();
    signUpEmailController.dispose();

    signInEmailController.dispose();
    signInPassController.dispose();
  }
}
