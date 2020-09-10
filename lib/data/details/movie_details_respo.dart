///// adult : false
///// backdrop_path : "/wO5QSWZPBT71gMLvrRex0bVc0V9.jpg"
///// belongs_to_collection : {"id":726619,"name":"The Kissing Booth Collection","poster_path":"/wY0OtbE3WvZFnGNL37Jw28RvUSx.jpg","backdrop_path":"/6o99Ld3NBMBGbLXWoUWWm8Pq9LA.jpg"}
///// budget : 0
///// genres : [{"id":35,"name":"Comedy"},{"id":10749,"name":"Romance"}]
///// homepage : "https://www.netflix.com/title/81026818"
///// id : 583083
///// imdb_id : "tt9784456"
///// original_language : "en"
///// original_title : "The Kissing Booth 2"
///// overview : "With college decisions looming, Elle juggles her long-distance romance with Noah, changing relationship with bestie Lee and feelings for a new classmate."
///// popularity : 165.625
///// poster_path : "/mb7wQv0adK3kjOUr9n93mANHhPJ.jpg"
///// production_companies : [{"id":104090,"logo_path":"/kBKzEDKymaAjhs2TuTWbynJctNr.png","name":"Komixx Entertainment","origin_country":"GB"}]
///// production_countries : [{"iso_3166_1":"GB","name":"United Kingdom"},{"iso_3166_1":"US","name":"United States of America"}]
///// release_date : "2020-07-24"
///// revenue : 0
///// runtime : 132
///// spoken_languages : [{"iso_639_1":"en","name":"English"}]
///// status : "Released"
///// tagline : "Rules can be broken...but so can hearts."
///// title : "The Kissing Booth 2"
///// video : false
///// vote_average : 8.2
///// vote_count : 2844
//
//class Movie_details {
//  bool _adult;
//  String _backdropPath;
//  Belongs_to_collection _belongsToCollection;
//  int _budget;
//  List<Genres> _genres;
//  String _homepage;
//  int _id;
//  String _imdbId;
//  String _originalLanguage;
//  String _originalTitle;
//  String _overview;
//  double _popularity;
//  String _posterPath;
//  List<Production_companies> _productionCompanies;
//  List<Production_countries> _productionCountries;
//  String _releaseDate;
//  int _revenue;
//  int _runtime;
//  List<Spoken_languages> _spokenLanguages;
//  String _status;
//  String _tagline;
//  String _title;
//  bool _video;
//  double _voteAverage;
//  int _voteCount;
//
//  bool get adult => _adult;
//  String get backdropPath => _backdropPath;
//  Belongs_to_collection get belongsToCollection => _belongsToCollection;
//  int get budget => _budget;
//  List<Genres> get genres => _genres;
//  String get homepage => _homepage;
//  int get id => _id;
//  String get imdbId => _imdbId;
//  String get originalLanguage => _originalLanguage;
//  String get originalTitle => _originalTitle;
//  String get overview => _overview;
//  double get popularity => _popularity;
//  String get posterPath => _posterPath;
//  List<Production_companies> get productionCompanies => _productionCompanies;
//  List<Production_countries> get productionCountries => _productionCountries;
//  String get releaseDate => _releaseDate;
//  int get revenue => _revenue;
//  int get runtime => _runtime;
//  List<Spoken_languages> get spokenLanguages => _spokenLanguages;
//  String get status => _status;
//  String get tagline => _tagline;
//  String get title => _title;
//  bool get video => _video;
//  double get voteAverage => _voteAverage;
//  int get voteCount => _voteCount;
//
//  Movie_details({
//      bool adult,
//      String backdropPath,
//      Belongs_to_collection belongsToCollection,
//      int budget,
//      List<Genres> genres,
//      String homepage,
//      int id,
//      String imdbId,
//      String originalLanguage,
//      String originalTitle,
//      String overview,
//      double popularity,
//      String posterPath,
//      List<Production_companies> productionCompanies,
//      List<Production_countries> productionCountries,
//      String releaseDate,
//      int revenue,
//      int runtime,
//      List<Spoken_languages> spokenLanguages,
//      String status,
//      String tagline,
//      String title,
//      bool video,
//      double voteAverage,
//      int voteCount}){
//    _adult = adult;
//    _backdropPath = backdropPath;
//    _belongsToCollection = belongsToCollection;
//    _budget = budget;
//    _genres = genres;
//    _homepage = homepage;
//    _id = id;
//    _imdbId = imdbId;
//    _originalLanguage = originalLanguage;
//    _originalTitle = originalTitle;
//    _overview = overview;
//    _popularity = popularity;
//    _posterPath = posterPath;
//    _productionCompanies = productionCompanies;
//    _productionCountries = productionCountries;
//    _releaseDate = releaseDate;
//    _revenue = revenue;
//    _runtime = runtime;
//    _spokenLanguages = spokenLanguages;
//    _status = status;
//    _tagline = tagline;
//    _title = title;
//    _video = video;
//    _voteAverage = voteAverage;
//    _voteCount = voteCount;
//}
//
//  Movie_details.fromJson(dynamic json) {
//    _adult = json["adult"];
//    _backdropPath = json["backdropPath"];
//    _belongsToCollection = json["belongsToCollection"] != null ? Belongs_to_collection.fromJson(json["belongsToCollection"]) : null;
//    _budget = json["budget"];
//    if (json["genres"] != null) {
//      _genres = [];
//      json["genres"].forEach((v) {
//        _genres.add(Genres.fromJson(v));
//      });
//    }
//    _homepage = json["homepage"];
//    _id = json["id"];
//    _imdbId = json["imdbId"];
//    _originalLanguage = json["originalLanguage"];
//    _originalTitle = json["originalTitle"];
//    _overview = json["overview"];
//    _popularity = json["popularity"];
//    _posterPath = json["posterPath"];
//    if (json["productionCompanies"] != null) {
//      _productionCompanies = [];
//      json["productionCompanies"].forEach((v) {
//        _productionCompanies.add(Production_companies.fromJson(v));
//      });
//    }
//    if (json["productionCountries"] != null) {
//      _productionCountries = [];
//      json["productionCountries"].forEach((v) {
//        _productionCountries.add(Production_countries.fromJson(v));
//      });
//    }
//    _releaseDate = json["releaseDate"];
//    _revenue = json["revenue"];
//    _runtime = json["runtime"];
//    if (json["spokenLanguages"] != null) {
//      _spokenLanguages = [];
//      json["spokenLanguages"].forEach((v) {
//        _spokenLanguages.add(Spoken_languages.fromJson(v));
//      });
//    }
//    _status = json["status"];
//    _tagline = json["tagline"];
//    _title = json["title"];
//    _video = json["video"];
//    _voteAverage = json["voteAverage"];
//    _voteCount = json["voteCount"];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["adult"] = _adult;
//    map["backdropPath"] = _backdropPath;
//    if (_belongsToCollection != null) {
//      map["belongsToCollection"] = _belongsToCollection.toJson();
//    }
//    map["budget"] = _budget;
//    if (_genres != null) {
//      map["genres"] = _genres.map((v) => v.toJson()).toList();
//    }
//    map["homepage"] = _homepage;
//    map["id"] = _id;
//    map["imdbId"] = _imdbId;
//    map["originalLanguage"] = _originalLanguage;
//    map["originalTitle"] = _originalTitle;
//    map["overview"] = _overview;
//    map["popularity"] = _popularity;
//    map["posterPath"] = _posterPath;
//    if (_productionCompanies != null) {
//      map["productionCompanies"] = _productionCompanies.map((v) => v.toJson()).toList();
//    }
//    if (_productionCountries != null) {
//      map["productionCountries"] = _productionCountries.map((v) => v.toJson()).toList();
//    }
//    map["releaseDate"] = _releaseDate;
//    map["revenue"] = _revenue;
//    map["runtime"] = _runtime;
//    if (_spokenLanguages != null) {
//      map["spokenLanguages"] = _spokenLanguages.map((v) => v.toJson()).toList();
//    }
//    map["status"] = _status;
//    map["tagline"] = _tagline;
//    map["title"] = _title;
//    map["video"] = _video;
//    map["voteAverage"] = _voteAverage;
//    map["voteCount"] = _voteCount;
//    return map;
//  }
//
//}
//
///// iso_639_1 : "en"
///// name : "English"
//
//class Spoken_languages {
//  String _iso6391;
//  String _name;
//
//  String get iso6391 => _iso6391;
//  String get name => _name;
//
//  Spoken_languages({
//      String iso6391,
//      String name}){
//    _iso6391 = iso6391;
//    _name = name;
//}
//
//  Spoken_languages.fromJson(dynamic json) {
//    _iso6391 = json["iso6391"];
//    _name = json["name"];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["iso6391"] = _iso6391;
//    map["name"] = _name;
//    return map;
//  }
//
//}
//
///// iso_3166_1 : "GB"
///// name : "United Kingdom"
//
//class Production_countries {
//  String _iso31661;
//  String _name;
//
//  String get iso31661 => _iso31661;
//  String get name => _name;
//
//  Production_countries({
//      String iso31661,
//      String name}){
//    _iso31661 = iso31661;
//    _name = name;
//}
//
//  Production_countries.fromJson(dynamic json) {
//    _iso31661 = json["iso31661"];
//    _name = json["name"];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["iso31661"] = _iso31661;
//    map["name"] = _name;
//    return map;
//  }
//
//}
//
///// id : 104090
///// logo_path : "/kBKzEDKymaAjhs2TuTWbynJctNr.png"
///// name : "Komixx Entertainment"
///// origin_country : "GB"
//
//class Production_companies {
//  int _id;
//  String _logoPath;
//  String _name;
//  String _originCountry;
//
//  int get id => _id;
//  String get logoPath => _logoPath;
//  String get name => _name;
//  String get originCountry => _originCountry;
//
//  Production_companies({
//      int id,
//      String logoPath,
//      String name,
//      String originCountry}){
//    _id = id;
//    _logoPath = logoPath;
//    _name = name;
//    _originCountry = originCountry;
//}
//
//  Production_companies.fromJson(dynamic json) {
//    _id = json["id"];
//    _logoPath = json["logoPath"];
//    _name = json["name"];
//    _originCountry = json["originCountry"];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["id"] = _id;
//    map["logoPath"] = _logoPath;
//    map["name"] = _name;
//    map["originCountry"] = _originCountry;
//    return map;
//  }
//
//}
//
///// id : 35
///// name : "Comedy"
//
//class Genres {
//  int _id;
//  String _name;
//
//  int get id => _id;
//  String get name => _name;
//
//  Genres({
//      int id,
//      String name}){
//    _id = id;
//    _name = name;
//}
//
//  Genres.fromJson(dynamic json) {
//    _id = json["id"];
//    _name = json["name"];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["id"] = _id;
//    map["name"] = _name;
//    return map;
//  }
//
//}
//
///// id : 726619
///// name : "The Kissing Booth Collection"
///// poster_path : "/wY0OtbE3WvZFnGNL37Jw28RvUSx.jpg"
///// backdrop_path : "/6o99Ld3NBMBGbLXWoUWWm8Pq9LA.jpg"
//
//class Belongs_to_collection {
//  int _id;
//  String _name;
//  String _posterPath;
//  String _backdropPath;
//
//  int get id => _id;
//  String get name => _name;
//  String get posterPath => _posterPath;
//  String get backdropPath => _backdropPath;
//
//  Belongs_to_collection({
//      int id,
//      String name,
//      String posterPath,
//      String backdropPath}){
//    _id = id;
//    _name = name;
//    _posterPath = posterPath;
//    _backdropPath = backdropPath;
//}
//
//  Belongs_to_collection.fromJson(dynamic json) {
//    _id = json["id"];
//    _name = json["name"];
//    _posterPath = json["posterPath"];
//    _backdropPath = json["backdropPath"];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["id"] = _id;
//    map["name"] = _name;
//    map["posterPath"] = _posterPath;
//    map["backdropPath"] = _backdropPath;
//    return map;
//  }
//
//}


class MovieDetailsRespo {
  bool adult;
  String backdropPath;
  BelongsToCollection belongsToCollection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  MovieDetailsRespo(
      {this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCompanies,
        this.productionCountries,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.spokenLanguages,
        this.status,
        this.tagline,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  MovieDetailsRespo.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'] != null
        ? new BelongsToCollection.fromJson(json['belongs_to_collection'])
        : null;
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = new List<ProductionCompanies>();
      json['production_companies'].forEach((v) {
        productionCompanies.add(new ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = new List<ProductionCountries>();
      json['production_countries'].forEach((v) {
        productionCountries.add(new ProductionCountries.fromJson(v));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = new List<SpokenLanguages>();
      json['spoken_languages'].forEach((v) {
        spokenLanguages.add(new SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    if (this.belongsToCollection != null) {
      data['belongs_to_collection'] = this.belongsToCollection.toJson();
    }
    data['budget'] = this.budget;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.productionCountries != null) {
      data['production_countries'] =
          this.productionCountries.map((v) => v.toJson()).toList();
    }
    data['release_date'] = this.releaseDate;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}

class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguages {
  String iso6391;
  String name;

  SpokenLanguages({this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['name'] = this.name;
    return data;
  }
}