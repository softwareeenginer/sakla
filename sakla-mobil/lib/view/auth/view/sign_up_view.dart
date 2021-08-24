import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakla/core/constants/navigation/navigation_constants.dart';
import 'package:sakla/view/auth/controller/sign_up_controller.dart';
import '../../../core/components/bezier_container.dart';
import 'login_view.dart';

class SignUpView extends StatelessWidget {
  final _controller = Get.put(SignUpController());
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.height * 0.03),
      child: Form(
        key: _controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.height / 15,
            ),
            buildTitle(),
            SizedBox(
              height: context.height / 15,
            ),
            buildTextFormFieldForNameAndSurname(),
            SizedBox(
              height: context.height / 40,
            ),
            buildTextFormFieldForEmail(),
            SizedBox(
              height: context.height / 40,
            ),
            buildTextFormFieldForPass(),
            SizedBox(
              height: context.height / 40,
            ),
            buildTextFormFieldForrRePass(),
            SizedBox(
              height: context.height / 20,
            ),
            // buildPrivacyPolicyText(),
            // SizedBox(
            //   height: context.height / 30,
            // ),
            buildSignUpButton(context),
            SizedBox(
              height: context.height / 30,
            ),
            buildLoginPageButton(context)
          ],
        ),
      ),
    );
  }

  Widget buildTextFormFieldForNameAndSurname() {
    return TextFormField(
      controller: _controller.signupNameAndSurnameController,
      keyboardType: TextInputType.name,
      validator: (input) {
        if (input!.length < 4) {
          return 'Please enter a valid name and surname !!!';
        }
      },
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white, fontSize: 20),
      decoration: InputDecoration(
        labelText: 'Name and Surname',
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

  Widget buildLoginPageButton(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: 'Already have account?',
            style: TextStyle(color: Colors.white, fontSize: 17)),
        TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.offAndToNamed(NavigationConstants.LOGIN),
            text: ' Login',
            style: TextStyle(color: Color(0xff7781EB), fontSize: 17)),
      ])),
    );
  }

  Widget buildPrivacyPolicyText() {
    return Center(
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
              text: 'By continuing, you agree to our',
              style: TextStyle(color: Colors.white, fontSize: 17)),
          TextSpan(
              text: ' Terms of\n',
              style: TextStyle(color: Color(0xff7781EB), fontSize: 17)),
          TextSpan(
              text: '\Service',
              style: TextStyle(color: Color(0xff7781EB), fontSize: 17)),
          TextSpan(
              text: ' and',
              style: TextStyle(color: Colors.white, fontSize: 17)),
          TextSpan(
              text: ' Privacy Policy',
              style: TextStyle(color: Color(0xff7781EB), fontSize: 17))
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildSignUpButton(BuildContext context) {
    return Obx(() => InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            _controller.signUp();
          },
          child: Ink(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 16,
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
            child: _controller.isSignUp
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Text('Sign Up',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  ),
          ),
        ));
  }

  Widget buildTextFormFieldForrRePass() {
    return Obx(() => TextFormField(
          key: _controller.keyConfirmPass,
          keyboardType: TextInputType.visiblePassword,
          validator: (input) {
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
            labelText: 'Re-enter password',
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

  Widget buildTextFormFieldForPass() {
    return Obx(() => TextFormField(
          key: _controller.keyPass,
          controller: _controller.signupPassController,
          keyboardType: TextInputType.visiblePassword,
          validator: (input) {
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
      key: _controller.keyEmail,
      controller: _controller.signupEmailController,
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
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {},
      child: Ink(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 16,
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
        child: Center(
          child: Text('Login',
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
      ),
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
        text: 'Sign up',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      ),
    ]));
  }
}
