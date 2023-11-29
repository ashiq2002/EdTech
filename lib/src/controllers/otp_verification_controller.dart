import 'package:edtech/data/repository/otp_base_repository.dart';
import 'package:edtech/data/repository/otp_repository.dart';
import 'package:edtech/data/response/api_response.dart';
import 'package:edtech/src/model/otp_response_model.dart';
import 'package:edtech/util/dev.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  final OtpBaseRepository _repository =
      OtpRepository(); //create otp repository instance

  final Rx<ApiResponse<OtpResponseModel>> _otpResponse =
      Rx(ApiResponse.initialState());
  ApiResponse<OtpResponseModel> get otpResponse => _otpResponse.value;

  Future<void> sendOtp(String userEmail) async{
    _otpResponse.value = ApiResponse.loadingState();
    //
    await _repository.sendOtp(
        url: 'https://flutter.rohitchouhan.com/email-otp/v3.php?app_name=EdTech&app_email=mdashiqhossain6@gmail.com&user_email=$userEmail&otp_length=6&type=digits',
        // headerParam: OtpModel(
        //         appName: "EdTech",
        //         appEmail: "mdashiqhosain6@gmial.com",
        //         userEmail: userEmail.trim(),
        //         otpLength: 6,
        //         type: "digits").toJson()
    )
        .then((value){
          _otpResponse.value = ApiResponse.successState(value);
    })
        .onError((error, stackTrace) {
      _otpResponse.value = ApiResponse.errorState(error.toString());
      devLog(tag: "OTP", message: "Otp Error $error");
    });
  }
}
