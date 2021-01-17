import 'package:movies4u/constant/api_constant.dart';

class CommonMovieReq {
  String apiKey = ApiConstant.API_KEY;
//  String language = ApiConstant.LANGUAGE;
  String page = '1';

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

  CommonMovieReq({this.apiKey, this.page});

  CommonMovieReq.fromJson(Map<String, String> json) {
    apiKey = json['api_key'];
//    language = json['language'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['api_key'] = this.apiKey;
//    data['language'] = this.language;
    data['page'] = this.page;
    return data;
  }
}
