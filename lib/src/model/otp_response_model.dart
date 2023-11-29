import 'dart:convert';
/// status : true
/// otp : "007045"

OtpResponseModel otpResponseModelFromJson(String str) => OtpResponseModel.fromJson(json.decode(str));
String otpResponseModelToJson(OtpResponseModel data) => json.encode(data.toJson());

class OtpResponseModel {
  OtpResponseModel({
    bool? status,
    String? otp,}){
    _status = status;
    _otp = otp;
  }

  OtpResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _otp = json['otp'];
  }
  bool? _status;
  String? _otp;
  OtpResponseModel copyWith({  bool? status,
    String? otp,
  }) => OtpResponseModel(  status: status ?? _status,
    otp: otp ?? _otp,
  );
  bool? get status => _status;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['otp'] = _otp;
    return map;
  }

}