import 'package:crypto_flutter/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'auth.dart';

class AuthScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppFocus.unfocus(context),
      child: WillPopScope(
        onWillPop: () async => false,
        // child: Scaffold(
        //   body: Center(
        //     child: Text('authenticate page'),
        //   ),
        // ),
        child: Obx(() => buildItem(context)),
      ),
    );
  }

  Widget buildItem(BuildContext context) {
    double h = SizeConfig().screenHeight;
    double w = SizeConfig().screenWidth;

    return Material(
      child: Scaffold(
        body: Container(
          color: ColorConstants.backgroundColor,
          child: SingleChildScrollView(
            child: Form(
              key: controller.isShowLogin.value
                  ? controller.signInKey
                  : controller.signUpKey,
              child: Stack(
                children: [
                  Container(
                    height: controller.isShowLogin.value ? 1 * h : 1.1 * h,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                        padding: const EdgeInsets.only(top: 90, left: 20),
                        color: ColorConstants.facebookColor.withOpacity(.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: controller.isShowLogin.value
                                      ? 'Welcome'
                                      : 'Welcome to',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.yellow[700],
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w300),
                                  children: [
                                    TextSpan(
                                        text: controller.isShowLogin.value
                                            ? ' Back'
                                            : ' Crypto',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.yellow[700],
                                            fontWeight: FontWeight.bold))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                controller.isShowLogin.value
                                    ? 'Signin to Continue'
                                    : 'Signup to Continue',
                                style: const TextStyle(
                                    color: ColorConstants.WHITE_COLOR,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // buildButtonHalfContainer(true),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    // curve: Curves.easeIn,
                    top: 200,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      padding: const EdgeInsets.all(20.0),
                      height: controller.isShowLogin.value ? 250 : 300,
                      width: w - 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: ColorConstants.WHITE_COLOR,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                //offset: Offset(5, 5),
                                blurRadius: 15,
                                spreadRadius: 5)
                          ]),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.changeActive(number: 1);
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            color: controller.isShowLogin.value
                                                ? ColorConstants.activeColor
                                                : ColorConstants.textColor2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      controller.isShowLogin.value
                                          ? Container(
                                              height: 2,
                                              width: 55,
                                              color: Colors.orange)
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.changeActive(number: 2);
                                    // setState(() {
                                    //   controller.isShowLogin = false;
                                    // });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                            color: !controller.isShowLogin.value
                                                ? ColorConstants.activeColor
                                                : ColorConstants.textColor2,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      !controller.isShowLogin.value
                                          ? Container(
                                              height: 2,
                                              width: 55,
                                              color: Colors.orange)
                                          : const SizedBox(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            if (!controller.isShowLogin.value)
                              buildSignupSection()
                            else
                              buildLoginSection()
                          ],
                        ),
                      ),
                    ),
                  ),
                  buildButtonHalfContainer(false),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    top: !controller.isShowLogin.value ? h - 120 : h - 50,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        Text(
                          controller.isShowLogin.value
                              ? 'Or Signin with'
                              : 'Or Signup with',
                          style: const TextStyle(
                              color: ColorConstants.BLACK_COLOR,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20, left: 20, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildButtonSocial(
                                  'Facebook',
                                  MaterialCommunityIcons.facebook,
                                  ColorConstants.facebookColor),
                              buildButtonSocial(
                                  'Google',
                                  MaterialCommunityIcons.google_plus,
                                  ColorConstants.googleColor),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildLoginSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          buildTextField(MaterialCommunityIcons.email_outline, 'Email', false,
              true, controller.signInEmailController),
          buildTextField(MaterialCommunityIcons.lock_outline, '*******', true,
              false, controller.signInPassController),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      activeColor: ColorConstants.textColor1,
                      value: controller.isRememberMe.value,
                      onChanged: (value) {
                        // setState(() {
                        //   isRememberMe = !isRememberMe;
                        // });
                      }),
                  const Text('Remember me'),
                ],
              ),
              TextButton(onPressed: () {}, child: const Text('Forgot Password?'))
            ],
          )
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          buildTextField(MaterialCommunityIcons.account_outline, 'User Name',
              false, false, controller.signUpNameController),
          buildTextField(MaterialCommunityIcons.email_outline, 'Email', false,
              true, controller.signUpEmailController),
          buildTextField(MaterialCommunityIcons.lock_outline, 'Password', true,
              false, controller.signUpPassController),
          Wrap(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                width: 200,
                child: RichText(
                  text: TextSpan(
                      text: 'By pressing "Submit" you agree to our',
                      style: const TextStyle(
                          fontSize: 10,
                          color: ColorConstants.textColor2,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                      children: [
                        TextSpan(
                            text: ' Term & conditions',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.yellow[700],
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextButton buildButtonSocial(String text, IconData icon, Color color) {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            backgroundColor: color,
            side: const BorderSide(width: 1, color: Colors.grey),
            minimumSize: const Size(145, 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: ColorConstants.WHITE_COLOR),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 5,
            ),
            Text(text)
          ],
        ));
  }

  Widget buildButtonHalfContainer(bool showShadow) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        top: controller.isShowLogin.value ? 475 : 535,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: ColorConstants.WHITE_COLOR,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  if (showShadow)
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 5),
                        blurRadius: 15,
                        spreadRadius: 1.5),
                ]),
            child: !showShadow
                ? GestureDetector(
                    onTap: () {
                      // Get.to(() => OverView());
                      //Get.off(() => OverView());
                      controller.isShowLogin.value
                          ? controller.submitLogin()
                          : controller.submitRegister();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                            colors: [Color(0xffeeee00), Color(0xffee0000)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const Center(),
          ),
        ));
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controllerField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
          controller: controllerField,
          obscureText: isPassword,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorConstants.iconColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorConstants.textColor1),
                borderRadius: BorderRadius.circular(35.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorConstants.textColor1),
                borderRadius: BorderRadius.circular(35.0)),
            contentPadding: const EdgeInsets.all(8.0),
            hintText: hintText,
            hintStyle:
                const TextStyle(fontSize: 14, color: ColorConstants.textColor2),
          ),
          autocorrect: false,
          // validator: isPassword == false && isEmail == false
          //     ? controller.checkName
          //     : isEmail
          //         ? controller.checkEmail
          //         : controller.checkPassword),
          validator: (value) {
            if (isEmail) {
              return controller.checkEmail(value);
            }
            if (isPassword) return controller.checkPassword(value);
            if (!isEmail && !isPassword) return controller.checkName(value);
            return null;
          }),
    );
  }
}
