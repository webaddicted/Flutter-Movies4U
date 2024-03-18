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
    return ApiResponse<T>(status: ApiStatus.loading);
  }

  /// success
  static ApiResponse success<T>(T data) {
    return ApiResponse<T>(status: ApiStatus.success, data: data);
  }

  /// error
  static ApiResponse error<T>(
      {int? errCode, String? errMsg, T? errBdy, T? data}) {
    var apiError = ApiError(
        statusCode: errCode!, errorMessage: errMsg!, errorBody: errBdy);
    return ApiResponse.withoutData(status: ApiStatus.error, apiError: apiError);
  }

  /// method wraps response in ApiResponse class
  static ApiResponse<dynamic> returnResponse<T>(
      Response response, T apiResponse) {
    if (response.statusCode == ApiResponseCode.internetUnavailable) {
      return ApiResponse.error(
          errCode: response.statusCode, errMsg: StringConst.noDataFound);
    } else if (response.statusCode == ApiResponseCode.success201 ||
        response.statusCode == ApiResponseCode.success200) {
      return ApiResponse.success(apiResponse);
    } else if (response.statusCode! >= ApiResponseCode.error400 &&
        response.statusCode! <= ApiResponseCode.error499) {
      return ApiResponse.error(
          errCode: response.statusCode,
          errMsg: response.statusMessage,
          errBdy: apiResponse,
          data: apiResponse);
    } else {
      return ApiResponse.error(
          errCode: ApiResponseCode.error500,
          errMsg: StringConst.somethingWentWrong,
          errBdy: StringConst.somethingWentWrong,
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
enum ApiStatus { loading, success, error }
