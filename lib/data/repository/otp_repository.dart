import 'package:edtech/data/network/api_dao.dart';
import 'package:edtech/data/network/api_services.dart';
import 'package:edtech/data/repository/otp_base_repository.dart';
import 'package:edtech/src/model/otp_response_model.dart';

class OtpRepository extends OtpBaseRepository{
  final ApiDao _apiDao = ApiServices();

  @override
  Future<OtpResponseModel> sendOtp({required String url, Map<String, String>? headerParam}) async {
    try{
      var result = await _apiDao.getApi(url: url, headerParam: headerParam);
      return otpResponseModelFromJson(result);
    }catch(e){
      rethrow;
    }
  }
}