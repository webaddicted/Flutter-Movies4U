import 'package:movies4u/constant/api_constant.dart';

class SearchMovieReq {
  String apiKey = ApiConstant.API_KEY;
  String query = "";
  String page = "1";

  SearchMovieReq.empty(String query, String page) {
    this.apiKey = ApiConstant.API_KEY;
    this.query = query;
    this.page = page;
  }

  SearchMovieReq({this.apiKey, this.page});

  SearchMovieReq.fromJson(Map<String, String> json) {
    apiKey = json['api_key'];
    query = json['query'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['api_key'] = this.apiKey;
    data['query'] = this.query;
    data['page'] = this.page;
    return data;
  }
}
