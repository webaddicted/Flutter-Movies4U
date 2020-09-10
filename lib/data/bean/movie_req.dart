/// api_key : "asfdadasdsadad"

class MovieReq {
  String _apiKey;

  String get apiKey => _apiKey;

  MovieReq(this._apiKey);

  MovieReq.map(dynamic obj) {
    this._apiKey = obj["api_key"];
  }

  Map<String, String> toMap() {
    var map = new Map<String, String>();
    map["api_key"] = _apiKey;
    return map;
  }

}
