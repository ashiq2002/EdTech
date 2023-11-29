import 'package:edtech/src/model/otp_response_model.dart';

abstract class OtpBaseRepository{
  Future<OtpResponseModel> sendOtp({required String url, Map<String, String>? headerParam});
}