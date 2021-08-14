import 'package:movies4u/constant/api_constant.dart';

class CommonMovieReq {
  String? apiKey = ApiConstant.API_KEY;
  String? page = "1";

  CommonMovieReq.empty() {
    this.apiKey = ApiConstant.API_KEY;
//    this.language = ApiConstant.LANGUAGE;
    this.page = '1';
  }

  CommonMovieReq.page(String page) {
    this.apiKey = ApiConstant.API_KEY;
//    this.language = ApiConstant.LANGUAGE;
    this.page = page;
  }


  CommonMovieReq({
    this.apiKey =ApiConstant.API_KEY,
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
