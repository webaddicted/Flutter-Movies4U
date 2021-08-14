/// id : 527774
/// results : [{"iso_639_1":"en","iso_3166_1":"US","name":"International Trailer","key":"3UFWsEY8Hdc","site":"YouTube","size":1080,"type":"Trailer","official":true,"published_at":"2021-02-09T21:09:34.000Z","id":"602662620a94d4003d6e53fb"},{"iso_639_1":"en","iso_3166_1":"US","name":"Raya and the Last Dragon | Big Game Ad","key":"SAV6GbzQX08","site":"YouTube","size":1080,"type":"Teaser","official":true,"published_at":"2021-02-07T23:28:45.000Z","id":"6022a414458199003eaa2691"},{"iso_639_1":"en","iso_3166_1":"US","name":"Official Trailer","key":"1VIZ89FEjYI","site":"YouTube","size":1080,"type":"Trailer","official":true,"published_at":"2021-01-26T14:00:00.000Z","id":"601023e492e55b003d69e023"},{"iso_639_1":"en","iso_3166_1":"US","name":"Official Teaser Trailer","key":"9BPMTr-NS9s","site":"YouTube","size":1080,"type":"Trailer","official":true,"published_at":"2020-10-21T12:45:41.000Z","id":"5f902e4cfed59700394ed242"}]

class VideoRespo {
  int? id;
  List<Results>? results;

  VideoRespo({
      this.id, 
      this.results});

  VideoRespo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// iso_639_1 : "en"
/// iso_3166_1 : "US"
/// name : "International Trailer"
/// key : "3UFWsEY8Hdc"
/// site : "YouTube"
/// size : 1080
/// type : "Trailer"
/// official : true
/// published_at : "2021-02-09T21:09:34.000Z"
/// id : "602662620a94d4003d6e53fb"

class Results {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Results({
      this.iso6391, 
      this.iso31661, 
      this.name, 
      this.key, 
      this.site, 
      this.size, 
      this.type, 
      this.official, 
      this.publishedAt, 
      this.id});

  Results.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    key = json['key'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    official = json['official'];
    publishedAt = json['published_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['iso_639_1'] = iso6391;
    map['iso_3166_1'] = iso31661;
    map['name'] = name;
    map['key'] = key;
    map['site'] = site;
    map['size'] = size;
    map['type'] = type;
    map['official'] = official;
    map['published_at'] = publishedAt;
    map['id'] = id;
    return map;
  }

}