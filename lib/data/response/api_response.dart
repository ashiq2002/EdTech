
import 'package:edtech/data/response/status.dart';

class ApiResponse<T>{
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.initialState():status = Status.initial;
  ApiResponse.loadingState():status = Status.loading;
  ApiResponse.successState(this.data):status = Status.success;
  ApiResponse.errorState(this.message):status = Status.error;
}