/// id : 527774
/// keywords : [{"id":780,"name":"kung fu"},{"id":1820,"name":"trip"},{"id":1938,"name":"sword"},{"id":3389,"name":"warrior woman"},{"id":12554,"name":"dragon"},{"id":167234,"name":"vietnamese"},{"id":192494,"name":"south asian"},{"id":192913,"name":"warrior"}]

class KeywordRespo {
  int? id;
  List<Keywords>? keywords;

  KeywordRespo({
      this.id, 
      this.keywords});

  KeywordRespo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['keywords'] != null) {
      keywords = [];
      json['keywords'].forEach((v) {
        keywords?.add(Keywords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    if (keywords != null) {
      map['keywords'] = keywords?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 780
/// name : "kung fu"

class Keywords {
  int? id;
  String? name;

  Keywords({
      this.id, 
      this.name});

  Keywords.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}