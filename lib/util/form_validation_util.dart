class FormValidationUtil{
  //email regex
  final RegExp emailRegex = RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',);

  //password regex
  final RegExp passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$',);
  final RegExp atLeastOneDigitRegex = RegExp(r'^(?=.*[0-9])',);
  final RegExp atLeastOneSpecialCharRegex = RegExp(r'^(?=.*[!@#$%^&*])',);
  final RegExp atLeastOneLetterRegex = RegExp(r'^(?=.*[a-zA-Z])',);

  //-----------------------------------validate email address
  String? isEmailValid(String email){
    if(!emailRegex.hasMatch(email)){
      return "Invalid email format";
    }
    //if email valid then return null as a error message
    return null;
  }

  //------------------------------------------validate password
  String? isPasswordValid(String password){
    if(password.length < 8){
      return "Password length cannot be less than 8";
    }

    if(passwordRegex.hasMatch(password)) {
      return null;
    }

    if(!atLeastOneLetterRegex.hasMatch(password)){
      return "password should contains at least one letter";
    }else if(!atLeastOneDigitRegex.hasMatch(password)){
      return "password should contains at least one digit";
    }else if(!atLeastOneSpecialCharRegex.hasMatch(password)){
      return "password should contains at least one special char";
    }
    return null;
  }


}