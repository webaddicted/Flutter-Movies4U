import 'package:movies4u/constant/api_constant.dart';

/// api_key : ""
/// query : ""
/// page : ""

class SearchMovieReq {
  String? apiKey = ApiConstant.API_KEY;
  String? query = "";
  String? page = "";
  SearchMovieReq.empty(String query, String page) {
    this.apiKey = ApiConstant.API_KEY;
    this.query = query;
    this.page = page;
  }

  SearchMovieReq({
      this.apiKey = ApiConstant.API_KEY,
      this.query = "",
      this.page = "1"});

  SearchMovieReq.fromJson(Map<String, dynamic> json) {
    apiKey = json['api_key'];
    query = json['query'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['api_key'] = apiKey;
    map['query'] = query;
    map['page'] = page;
    return map;
  }

}