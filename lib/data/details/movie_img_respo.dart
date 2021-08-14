/// id : 16483
/// profiles : [{"aspect_ratio":0.667,"height":1500,"iso_639_1":null,"file_path":"/qDRGPAcQoW8Wuig9bvoLpHwf1gU.jpg","vote_average":6.194,"vote_count":80,"width":1000},{"aspect_ratio":0.673,"height":594,"iso_639_1":null,"file_path":"/hF0lZY0h9pXn3O9NHAN8eEvraYn.jpg","vote_average":5.51,"vote_count":28,"width":400},{"aspect_ratio":0.667,"height":750,"iso_639_1":null,"file_path":"/jkt84NhFtLdgA9Ts3RAM2sPtOXO.jpg","vote_average":5.51,"vote_count":28,"width":500},{"aspect_ratio":0.667,"height":3000,"iso_639_1":null,"file_path":"/cIMU1c9Veg4wUHYDlgqxLtE7GtN.jpg","vote_average":5.458,"vote_count":19,"width":2000},{"aspect_ratio":0.667,"height":750,"iso_639_1":null,"file_path":"/sBodZqm2hVN7nXtZkqTXWNd28zB.jpg","vote_average":5.18,"vote_count":3,"width":500},{"aspect_ratio":0.667,"height":1500,"iso_639_1":null,"file_path":"/1FdlFC67KSi9GVM3r36rM53m4KR.jpg","vote_average":5.118,"vote_count":4,"width":1000},{"aspect_ratio":0.667,"height":900,"iso_639_1":null,"file_path":"/sUNVcKizlRdhLoC8rqhWIMV3bCv.jpg","vote_average":5.096,"vote_count":24,"width":600},{"aspect_ratio":0.667,"height":1920,"iso_639_1":null,"file_path":"/dotWm0dJLaJnJGFbkTBMwbIluZO.jpg","vote_average":5.028,"vote_count":21,"width":1280},{"aspect_ratio":0.667,"height":1500,"iso_639_1":null,"file_path":"/gVKZHFji9rXGxsravtzDBvXdqA9.jpg","vote_average":4.73,"vote_count":42,"width":1000},{"aspect_ratio":0.667,"height":2100,"iso_639_1":null,"file_path":"/gP5STftJ8ErISwlYiUggmxajrhr.jpg","vote_average":4.354,"vote_count":35,"width":1400},{"aspect_ratio":0.667,"height":3000,"iso_639_1":null,"file_path":"/11NLzCQq1L2x7U25ebG6674JP2i.jpg","vote_average":4.286,"vote_count":18,"width":2000},{"aspect_ratio":0.667,"height":1800,"iso_639_1":null,"file_path":"/ptdU5PAHlBUVKZKDLLSJxRuA3Ry.jpg","vote_average":4.264,"vote_count":24,"width":1200}]

class MovieImgRespo {
  int? id;
  List<Backdrops>? profiles;
  List<Backdrops>? backdrops;
  List<Backdrops>? posters;
  MovieImgRespo({
      this.id, 
      this.profiles,
    this.backdrops,
    this.posters,

  });

  MovieImgRespo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['backdrops'] != null) {
      backdrops = <Backdrops>[];
      json['backdrops'].forEach((v) {
        backdrops?.add(Backdrops.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = <Backdrops>[];
      json['posters'].forEach((v) {
        posters?.add(new Backdrops.fromJson(v));
      });
    }
    if (json['profiles'] != null) {
      profiles = [];
      json['profiles'].forEach((v) {
        profiles?.add(Backdrops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    if (profiles != null) {
      map['profiles'] = profiles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// aspect_ratio : 0.667
/// height : 1500
/// iso_639_1 : null
/// file_path : "/qDRGPAcQoW8Wuig9bvoLpHwf1gU.jpg"
/// vote_average : 6.194
/// vote_count : 80
/// width : 1000

class Backdrops {
  double? aspectRatio;
  int? height;
  dynamic? iso6391;
  String? filePath;
  dynamic? voteAverage;
  int? voteCount;
  int? width;

  Backdrops({
      this.aspectRatio, 
      this.height, 
      this.iso6391, 
      this.filePath, 
      this.voteAverage, 
      this.voteCount, 
      this.width});

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['aspect_ratio'] = aspectRatio;
    map['height'] = height;
    map['iso_639_1'] = iso6391;
    map['file_path'] = filePath;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    map['width'] = width;
    return map;
  }

}