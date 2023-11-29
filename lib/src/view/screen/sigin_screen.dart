import 'package:edtech/route/routes_name.dart';
import 'package:edtech/src/controllers/otp_verification_controller.dart';
import 'package:edtech/src/controllers/user_auth_controller.dart';
import 'package:edtech/src/controllers/user_input_controller.dart';
import 'package:edtech/src/view/widgets/custom_button.dart';
import 'package:edtech/src/view/widgets/custom_checkbox.dart';
import 'package:edtech/src/view/widgets/user_input_field.dart';
import 'package:edtech/util/util.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  final Function()? signUpFrom;

  const SignInScreen({super.key, this.signUpFrom});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //getX controllers
  late UserAuthController _userAuthController;
  late UserInputController _userInputController;

  //from filed controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userAuthController = Get.put(UserAuthController());
    _userInputController = Get.put(UserInputController());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<UserAuthController>();
    Get.delete<UserInputController>();
    Get.delete<OtpVerificationController>();

    //-----------------disposed all from field controllers
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          //title : Sign in now
          const Gap(50),
          // const Center(
          //   child: Text("Sign In Now", style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.w600,
          //     color: royalBlue
          //   ),),
          // ), //title

          //email or username input text fields
          const Gap(30),
          Form(
              key: _fromKey,
              child: Column(
                children: [
                  //----------------------------------------user input text field
                  Obx(() => UserInputField(
                        controller: _emailController,
                        labelText: "Email",
                        errorText: _userInputController.emailErrorText,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                        //-------------------------------------email onchange
                        onChanged: (email) {
                          _userInputController.validateEmail(email);
                          debugPrint(email);
                        },
                        //--------------------------------------email validator
                        validator: (email) {
                          _userInputController.validatePassword(email!);
                          return _userInputController.emailErrorText;
                        },
                      )),

                  const Gap(40),
                  //------------------------------------------------user password
                  Obx(() => UserInputField(
                        controller: _passwordController,
                        isObscure: _userInputController.isObscure,
                        labelText: "Password",
                        errorText: _userInputController.passwordErrorText,
                        prefixIcon: const Icon(Icons.lock_rounded),
                        //-------------------------------------password onChange
                        onChanged: (password) {
                          _userInputController.validatePassword(password);
                          debugPrint(password);
                        },
                        //----------------------------password validator
                        validator: (password) {
                          _userInputController.validatePassword(password!);
                          return _userInputController.passwordErrorText;
                        },
                        suffixIcon: IconButton(
                            //--------------------------------password toggle
                            onPressed: () {
                              //update the text obscure state
                              _userInputController.updateIsObscure();
                            },
                            //-------------------------------visibility icon
                            icon: Icon(_userInputController.isObscure
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      )),
                ],
              )),

          //------------------forgot password & remember me
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //------------------------------------------------remember me checkbox
              Obx(() => CustomCheckBox(
                    value: _userInputController.isChecked,
                    onChanged: (value) {
                      //update the checkbox state
                      _userInputController.updateIsChecked();
                      debugPrint(
                          "isChecked : ${_userInputController.isChecked}");
                    },
                    child: Text(
                      "Remember me",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  )),

              //--------------------------------------------------------------forgot password
              InkWell(
                onTap: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),

          //-----------------------------------------sign in button
          const Gap(75),
          Obx(() => CustomButton(
            onPressed: () async {
              if (_fromKey.currentState!.validate()) {
                await _userAuthController.sigIn(
                    email: _emailController.text,
                    password: _passwordController.text);

                if (!context.mounted) return;

                if(_userAuthController.isSuccess){
                  //---------------------------------------------other wise navigate to the dashboard
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.dashboardScreen,
                      ModalRoute.withName(RoutesName.homeScreen));
                }else{
                  //if any exception thrown then display that into the snack bar
                  Util.showSnackBar(context, message: _userAuthController.errorMessage);
                }
              }
            },
            child: _userAuthController.isLoadingState
                ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
                : const Text(
              "Sign in",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),

          // Don't have any account
          const Gap(30),
          Text(
            "Don't have an account?",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          //-----------------------------------------------signup from here
          InkWell(
            onTap: widget.signUpFrom,
            child: const Text(
              "Sign up from here",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  height: 2),
            ),
          ), //forgot password & remember me
        ],
      ),
    ));
  }
}
