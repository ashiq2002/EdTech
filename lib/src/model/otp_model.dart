import 'dart:convert';

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
      String? appName, 
      String? appEmail, 
      String? userEmail, 
      int? otpLength,
      String? type,}){
    _appName = appName;
    _appEmail = appEmail;
    _userEmail = userEmail;
    _otpLength = otpLength;
    _type = type;
}

  String? _appName;
  String? _appEmail;
  String? _userEmail;
  int? _otpLength;
  String? _type;
OtpModel copyWith({  String? appName,
  String? appEmail,
  String? userEmail,
  int? otpLength,
  String? type,
}) => OtpModel(  appName: appName ?? _appName,
  appEmail: appEmail ?? _appEmail,
  userEmail: userEmail ?? _userEmail,
  otpLength: otpLength ?? _otpLength,
  type: type ?? _type,
);

  String? get appName => _appName;
  String? get appEmail => _appEmail;
  String? get userEmail => _userEmail;
  int? get otpLength => _otpLength;
  String? get type => _type;

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['app_name'] = _appName!;
    map['app_email'] = _appEmail!;
    map['user_email'] = _userEmail!;
    map['otp_length'] = _otpLength.toString();
    map['type'] = _type!;
    return map;
  }

}