import 'package:edtech/util/form_validation_util.dart';
import 'package:get/get.dart';

class UserInputController extends GetxController{
  final FormValidationUtil _formValidationUtil = FormValidationUtil();

  //obscure text
  final _isObscure = RxBool(true);
  bool get isObscure => _isObscure.value;

  final _isObscure2 = RxBool(true);
  bool get isObscure2 => _isObscure2.value;

  //remember me checkbox
  final _isChecked = RxBool(false);
  bool get isChecked => _isChecked.value;

  //email error value
  final _emailErrorText = RxnString(null);
  String? get emailErrorText => _emailErrorText.value;

  //password error value
  final _passwordErrorText = RxnString(null);
  String? get passwordErrorText => _passwordErrorText.value;

  //Repeat-Password error value
  final _repeatPassErrorText = RxnString(null);
  String? get repeatPassErrorText => _repeatPassErrorText.value;

  //---------------------------------x---------------------------------------
  //-------------------------------------------------------------------------

  //---------------------update obscure text state
  void updateIsObscure(){
    _isObscure.value = !_isObscure.value;
  }

  void updateIsObscure2(){
    _isObscure2.value = !_isObscure2.value;
  }

  //----------------------------update check box state
  void updateIsChecked(){
    _isChecked.value = !_isChecked.value;
  }

  //-------------------------------------------------------validate email
  void validateEmail(String email){
    _emailErrorText.value = _formValidationUtil.isEmailValid(email);
  }

  //-------------------------------------------------------validate password
  void validatePassword(String password){
    _passwordErrorText.value = _formValidationUtil.isPasswordValid(password);
  }

  //------------------------------------------------validate Repeat-Password
  void validateRepeatPassword(String pass1, String pass2){
    if(pass1 != pass2){
      _repeatPassErrorText.value = "password are not same";
    }else{
      _repeatPassErrorText.value = null;
    }
  }
}