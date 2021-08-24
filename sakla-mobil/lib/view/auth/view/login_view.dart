import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../../../core/components/bezier_container.dart';
import '../controller/login_controller.dart';

class LoginView extends StatelessWidget {
  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C1E3D),
      body: SingleChildScrollView(
        child: Container(
          height: context.height,
          child: Stack(
            children: [
              Positioned(child: BezierContainer()),
              buildBody(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.height * 0.03),
      child: Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.height / 5,
            ),
            buildTitle(),
            SizedBox(
              height: context.height / 15,
            ),
            buildTextFormFieldForEmail(),
            SizedBox(
              height: context.height / 40,
            ),
            buildTextFormFieldForPassword(context),
            SizedBox(
              height: context.height / 40,
            ),
            buildLoginButton(context),
            SizedBox(
              height: context.height / 20,
            ),
            buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildSignUpButton(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: 'If you dont have any account?',
            style: TextStyle(color: Colors.white, fontSize: 17)),
        TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => _controller.navigateToSignUpView(),
            text: ' Sign UP ',
            style: TextStyle(color: Color(0xff7781EB), fontSize: 17)),
      ])),
    );
  }

  Widget buildTitle() {
    return Text.rich(TextSpan(children: [
      TextSpan(
        text: 'sakla\n',
        style: TextStyle(
            color: Color(0xff555EBD),
            fontSize: 50,
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
        text: 'Welcome back!',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      ),
    ]));
  }

  Widget buildTextFormFieldForPassword(BuildContext context) {
    return Obx(() => TextFormField(
          controller: _controller.loginPassController,
          keyboardType: TextInputType.visiblePassword,
          validator: (String? input) {
            if (input!.length < 6) {
              return 'Your password must be at least 6 digits !!!';
            }
          },
          cursorColor: Colors.white,
          obscureText: _controller.isPasswordShows,
          style: TextStyle(color: Colors.white, fontSize: 20),
          decoration: InputDecoration(
            suffix: IconButton(
              icon: Icon(
                _controller.isPasswordShows
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                _controller.changePasswordIcon();
              },
            ),
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff404993)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ));
  }

  Widget buildTextFormFieldForEmail() {
    return TextFormField(
      controller: _controller.loginEmailController,
      keyboardType: TextInputType.emailAddress,
      validator: (input) {
        if (input!.length < 4 || !input.contains('@') || !input.contains('.')) {
          return 'Please enter a valid email address !!!';
        }
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff404993)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Obx(() => InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            _controller.login();
          },
          child: Ink(
            width: context.width / 1.1,
            height: context.height / 16,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff3B4183), Color(0xff515AB6)]),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              color: Color(0xffED7917),
              borderRadius: BorderRadius.circular(50),
            ),
            child: _controller.isLogin
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text('Login',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ),
          ),
        ));
  }
}
