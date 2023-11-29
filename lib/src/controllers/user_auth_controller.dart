import 'package:edtech/service/auth_service.dart';
import 'package:edtech/util/dev.dart';
import 'package:get/get.dart';

class UserAuthController extends GetxController{
//firebase service class instance
  final AuthService _authService = AuthService();

  final RxnString _errorMessage = RxnString(null);
  String? get errorMessage => _errorMessage.value;

  final RxBool _isLoadingState = RxBool(false);
  bool get isLoadingState => _isLoadingState.value;

  final RxBool _isSuccess = RxBool(false);
  bool get isSuccess => _isSuccess.value;

  //----------------------------------------login user by email and password
  Future<void> sigIn(
      {required String email, required String password}) async{
    _isLoadingState.value = true;

    await _authService.signInWithEmailAndPassword(email: email, password: password)
    .then((value){
      _isLoadingState.value = false;
      _isSuccess.value = true;
    })
    .onError((error, stackTrace) {
    devLog(tag: "Login Error", message: error.toString());
        _errorMessage.value = error.toString();
        _isLoadingState.value = false;
    _isSuccess.value = false;
    });

  }

  //---------------------------------------------------create new user
  Future<void> signup({required String email, required String password}) async{
    _isLoadingState.value = true;

    await _authService.createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
      _isLoadingState.value = false;
      _isSuccess.value = true;
    })
        .onError((error, stackTrace) {
      devLog(tag: "Signup Error", message: error.toString());
      _errorMessage.value = error.toString();
      _isLoadingState.value = false;
      _isSuccess.value = false;
    });
  }
}