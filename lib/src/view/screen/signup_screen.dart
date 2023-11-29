import 'package:edtech/data/response/status.dart';
import 'package:edtech/route/routes_name.dart';
import 'package:edtech/src/controllers/otp_verification_controller.dart';
import 'package:edtech/src/controllers/user_auth_controller.dart';
import 'package:edtech/src/controllers/user_input_controller.dart';
import 'package:edtech/src/model/user_model.dart';
import 'package:edtech/src/view/widgets/custom_button.dart';
import 'package:edtech/src/view/widgets/custom_checkbox.dart';
import 'package:edtech/src/view/widgets/user_input_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  final Function()? signInFrom;
  const SignupScreen({super.key, this.signInFrom});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  late UserInputController _userInputController;
  late OtpVerificationController _otpVerificationController;

  //from filed controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repPasswordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userInputController = Get.put(UserInputController());
    _otpVerificationController = Get.put(OtpVerificationController());
    debugPrint("signup");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<UserInputController>();
    Get.delete<OtpVerificationController>();

    //-----------------disposed all from field controllers
    _emailController.dispose();
    _passwordController.dispose();
    _repPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  UserInputField(
                    labelText: "User",
                    prefixIcon: const Icon(Icons.person),
                    onChanged: (user) {},
                  ),

                  const Gap(40),
                  //----------------------------------------user input text field
                  Obx(() => UserInputField(
                        controller: _emailController,
                        labelText: "Email",
                        errorText: _userInputController.emailErrorText,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                        onChanged: (email) {
                          _userInputController.validateEmail(email);
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
                        onChanged: (password) {
                          _userInputController.validatePassword(password);
                        },
                        //----------------------------password validator
                        validator: (password) {
                          _userInputController.validatePassword(password!);
                          return _userInputController.passwordErrorText;
                        },
                        suffixIcon: IconButton(
                            onPressed: () {
                              _userInputController.updateIsObscure();
                            },
                            icon: Icon(_userInputController.isObscure
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      )),
                ],
              )),

          //------------------forgot password & remember me
          const Gap(15),
          Obx(() => CustomCheckBox(
              value: _userInputController.isChecked,
              onChanged: (value) {
                _userInputController.updateIsChecked();
              },
              child: Row(
                children: [
                  Text(
                    "I agree to the",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  //-------------------------------------terms and condition
                  const Gap(4),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Terms and Condition.",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ))),

          //-----------------------------------------sign in button
          const Gap(45),
          Obx(() => CustomButton(
            onPressed: () async {
              if (_fromKey.currentState!.validate()) {
                await _otpVerificationController.sendOtp(_emailController.text);

                if (_otpVerificationController.otpResponse.status ==
                    Status.success) {

                  if (!context.mounted) return;
                  //if status is success then navigate to the otp verification screen
                  Navigator.pushNamed(context, RoutesName.otpVerificationScreen,
                      arguments: UserModel(
                          email: _emailController.text,
                          password: _passwordController.text,
                          otp: _otpVerificationController
                              .otpResponse.data!.otp!));
                }
              }
            },
            child:
            _otpVerificationController.otpResponse.status == Status.loading
                ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
                : const Text(
              "Signup",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),

          // Already have an account
          const Gap(30),
          Text(
            "Already have an account?",
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          //-----------------------------------------------sig in from here
          InkWell(
            onTap: widget.signInFrom,
            child: const Text(
              "Sign In from here",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  height: 2),
            ),
          ), //forgot password & remember me
          const Gap(15)
        ],
      ),
    ));
  }
}
