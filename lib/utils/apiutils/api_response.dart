import 'package:dio/dio.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/utils/apiutils/api_base_helper.dart';

class ApiResponse<T> {
  ApiStatus status;
  T data;
  String message;
  ApiError apierror;

  ApiResponse({ApiStatus status, T data, ApiError apierror}) {
    this.status = status;
    this.data = data;
    this.apierror = apierror;
  }

  static ApiResponse<T> loading<T>() {
    return ApiResponse<T>(status: ApiStatus.LOADING, data: null);
  }

  static ApiResponse success<T>(T data) {
    return ApiResponse<T>(status: ApiStatus.COMPLETED, data: data);
  }

  static ApiResponse<T> error<T>(
      {int errCode, String errMsg, String errBdy, T data}) {
    ApiError apiError = ApiError(
        statusCode: errCode,
        errorMessage: errMsg,
        errorBody: errBdy == null ? "" : errBdy);
    return ApiResponse<T>(
        status: ApiStatus.ERROR, apierror: apiError, data: data);
  }

  static ApiResponse<T> returnResponse<T>(Response response, T movieRespo) {
    if (response.statusCode == ApiRespoCode.no_internet_connection)
      return ApiResponse.error(
          errCode: response.statusCode,
          errMsg: ApiConstant.NoInternetConnection,
          data: null);
    else if (response.statusCode == ApiRespoCode.success)
      return ApiResponse.success(movieRespo);
    else {
      return ApiResponse.error(
          errCode: response.statusCode,
          errMsg: response.statusMessage,
          errBdy: response.data.toString(),
          data: null);
    }
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

//  static checkDaa<T>(Response response, T datatt) {
//    try {
//      final dataRespo = apiHelper.returnResponse(response, datatt);
//      return dataRespo;
//    } catch (error, stacktrace) {
//      return error(
//          ApiError(533, error.toString(), stacktrace.toString()), null);
//    }
//  }
}

class ApiError {
  int statusCode;
  String errorMessage;
  String errorBody;

  ApiError({this.statusCode, this.errorMessage, this.errorBody});
}

enum ApiStatus { LOADING, COMPLETED, ERROR }
