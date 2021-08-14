import 'package:dio/dio.dart';
import 'package:movies4u/constant/string_const.dart';

import 'api_base_helper.dart';

/// Wrapper class for Api Response
class ApiResponse<T> {
  ApiStatus? status;
  T? data;
  String? message;
  ApiError? apiError;

  ApiResponse.withoutData({this.status, this.apiError});

  ApiResponse({this.status, this.data, this.apiError});

  /// loading
  static ApiResponse<T> loading<T>() {
    return ApiResponse<T>(status: ApiStatus.LOADING);
  }

  /// success
  static ApiResponse success<T>(T data) {
    return ApiResponse<T>(status: ApiStatus.COMPLETED, data: data);
  }

  /// error
  static ApiResponse error<T>(
      {int? errCode, String? errMsg, T? errBdy, T? data}) {
    var apiError = ApiError(
        statusCode: errCode!, errorMessage: errMsg!, errorBody: errBdy);
    return ApiResponse.withoutData(status: ApiStatus.ERROR, apiError: apiError);
  }

  /// method wraps response in ApiResponse class
  static ApiResponse<dynamic> returnResponse<T>(
      Response response, T apiResponse) {
    if (response.statusCode == ApiResponseCode.INTERNET_UNAVAILABLE) {
      return ApiResponse.error(
          errCode: response.statusCode, errMsg: StringConst.NO_DATA_FOUND);
    } else if (response.statusCode == ApiResponseCode.SUCCESS_201 ||
        response.statusCode == ApiResponseCode.SUCCESS_200) {
      return ApiResponse.success(apiResponse);
    } else if (response.statusCode! >= ApiResponseCode.ERROR_400 &&
        response.statusCode! <= ApiResponseCode.ERROR_499) {
      return ApiResponse.error(
          errCode: response.statusCode,
          errMsg: response.statusMessage,
          errBdy: apiResponse,
          data: apiResponse);
    } else {
      return ApiResponse.error(
          errCode: ApiResponseCode.ERROR_500,
          errMsg: StringConst.SOMETHING_WENT_WRONG,
          errBdy: StringConst.SOMETHING_WENT_WRONG,
          data: null);
    }
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

/// Error class to store Api Error Response
class ApiError<T> {
  int? statusCode;
  String? errorMessage;
  T? errorBody;

  ApiError({statusCode, this.errorMessage, this.errorBody});
}

/// Enum to check Api Status
enum ApiStatus { LOADING, COMPLETED, ERROR }
