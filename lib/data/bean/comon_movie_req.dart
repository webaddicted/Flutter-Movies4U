import 'package:movies4u/constant/api_constant.dart';

class CommonMovieReq {
  String? apiKey = ApiConstant.apiKey;
  String? page = "1";

  CommonMovieReq.empty() {
    apiKey = ApiConstant.apiKey;
//    this.language = ApiConstant.LANGUAGE;
    page = '1';
  }

  CommonMovieReq.page(String this.page) {
    apiKey = ApiConstant.apiKey;
  }


  CommonMovieReq({
    this.apiKey =ApiConstant.apiKey,
    this.page = "1"});

  CommonMovieReq.fromJson(Map<String, dynamic> json) {
    apiKey = json['api_key'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['api_key'] = apiKey;
    map['page'] = page;
    return map;
  }

}
