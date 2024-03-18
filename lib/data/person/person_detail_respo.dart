/// adult : false
/// also_known_as : ["Сильвестр Сталлоне","席維斯·史特龍","ซิลเวสเตอร์ สตอลโลน","シルヴェスター・スタローン","실베스터 스탤론","سيلفستر ستالون","Сільвестер Сталлоне","Michael Sylvester Gardenzio Stallone","Sylvester Enzio Stallone","Σιλβέστερ Σταλόνε","Μάικλ Σιλβέστερ Γκαρντέτσιο Σταλόνε","Italian Stallion","Силвестър Сталоун","西尔维斯特·史泰龙"]
/// biography : "An American actor and filmmaker. He is well known for his Hollywood action roles, including boxer Rocky Balboa in the Rocky series' eight films from 1976 to 2018; soldier John Rambo from the five Rambo films, released between 1982 and 2019; and Barney Ross in the three The Expendables films from 2010 to 2014. He wrote or co-wrote most of the 16 films in all three franchises, and directed many of the films.\n\nStallone's film Rocky was inducted into the National Film Registry as well as having its film props placed in the Smithsonian Museum. Stallone's use of the front entrance to the Philadelphia Museum of Art in the Rocky series led the area to be nicknamed the Rocky Steps. Philadelphia has a statue of his Rocky character placed permanently near the museum. It was announced on December 7, 2010 that Stallone was voted into the International Boxing Hall of Fame in the non-participant category.\n\nIn 1977, Stallone was nominated for two Academy Awards for Rocky, Best Original Screenplay and Best Actor. He became the third man in history to receive these two nominations for the same film, after Charlie Chaplin and Orson Welles. He received positive reviews, as well as his first Golden Globe Award win and a third Academy Award nomination, for reprising the role of Rocky Balboa in Ryan Coogler's 2015 film Creed."
/// birthday : "1946-07-06"
/// deathday : null
/// gender : 2
/// homepage : "http://www.sylvesterstallone.com"
/// id : 16483
/// imdb_id : "nm0000230"
/// known_for_department : "Acting"
/// name : "Sylvester Stallone"
/// place_of_birth : "New York City, New York, USA"
/// popularity : 28.58
/// profile_path : "/qDRGPAcQoW8Wuig9bvoLpHwf1gU.jpg"

class PersonDetailRespo {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  dynamic? deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment = "";
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;

  PersonDetailRespo({
      this.adult, 
      this.alsoKnownAs, 
      this.biography, 
      this.birthday, 
      this.deathday, 
      this.gender, 
      this.homepage, 
      this.id, 
      this.imdbId, 
      this.knownForDepartment,
      this.name, 
      this.placeOfBirth, 
      this.popularity, 
      this.profilePath});

  PersonDetailRespo.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    alsoKnownAs = json['also_known_as'] != null ? json['also_known_as'].cast<String>() : [];
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['adult'] = adult;
    map['also_known_as'] = alsoKnownAs;
    map['biography'] = biography;
    map['birthday'] = birthday;
    map['deathday'] = deathday;
    map['gender'] = gender;
    map['homepage'] = homepage;
    map['id'] = id;
    map['imdb_id'] = imdbId;
    map['known_for_department'] = knownForDepartment;
    map['name'] = name;
    map['place_of_birth'] = placeOfBirth;
    map['popularity'] = popularity;
    map['profile_path'] = profilePath;
    return map;
  }

}