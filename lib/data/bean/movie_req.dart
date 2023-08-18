import 'package:movies4u/constant/api_constant.dart';

/// api_key : "asfdadasdsadad"

class MovieReq {
  String? apiKey = ApiConstant.apiKey;

  MovieReq({
    this.apiKey =ApiConstant.apiKey});

  MovieReq.fromJson(Map<String, dynamic> json) {
    apiKey = json['api_key'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['api_key'] = apiKey;
    return map;
  }

}
