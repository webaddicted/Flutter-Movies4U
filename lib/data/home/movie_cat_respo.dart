/// genres : [{"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":16,"name":"Animation"},{"id":35,"name":"Comedy"},{"id":80,"name":"Crime"},{"id":99,"name":"Documentary"},{"id":18,"name":"Drama"},{"id":10751,"name":"Family"},{"id":14,"name":"Fantasy"},{"id":36,"name":"History"},{"id":27,"name":"Horror"},{"id":10402,"name":"Music"},{"id":9648,"name":"Mystery"},{"id":10749,"name":"Romance"},{"id":878,"name":"Science Fiction"},{"id":10770,"name":"TV Movie"},{"id":53,"name":"Thriller"},{"id":10752,"name":"War"},{"id":37,"name":"Western"}]

class MovieCatRespo {
  List<Genres> _genres;

  List<Genres> get genres => _genres;

  MovieCatRespo({
      List<Genres> genres}){
    _genres = genres;
}

  MovieCatRespo.fromJson(dynamic json) {
    if (json["genres"] != null) {
      _genres = [];
      json["genres"].forEach((v) {
        _genres.add(Genres.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_genres != null) {
      map["genres"] = _genres.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 28
/// name : "Action"

class Genres {
  int _id;
  String _name;

  int get id => _id;
  String get name => _name;

  Genres({
      int id, 
      String name}){
    _id = id;
    _name = name;
}

  Genres.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}