class MovieImgRespo {
    int id;
    List<Backdrops> backdrops;
    List<Backdrops> posters;
    List<Backdrops> profiles;
    MovieImgRespo({this.id, this.backdrops, this.posters, this.profiles});

    MovieImgRespo.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        if (json['backdrops'] != null) {
            backdrops = new List<Backdrops>();
            json['backdrops'].forEach((v) {
                backdrops.add(new Backdrops.fromJson(v));
            });
        }
        if (json['posters'] != null) {
            posters = new List<Backdrops>();
            json['posters'].forEach((v) {
                posters.add(new Backdrops.fromJson(v));
            });
        }
        if (json['profiles'] != null) {
            profiles = new List<Backdrops>();
            json['profiles'].forEach((v) {
                profiles.add(new Backdrops.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        if (this.backdrops != null) {
            data['backdrops'] = this.backdrops.map((v) => v.toJson()).toList();
        }
        if (this.posters != null) {
            data['posters'] = this.posters.map((v) => v.toJson()).toList();
        }
        if (this.profiles != null) {
            data['profiles'] = this.profiles.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Backdrops {
    var aspectRatio;
    String filePath;
    var height;
    String iso6391;
    var voteAverage;
    var voteCount;
    var width;

    Backdrops(
        {this.aspectRatio,
            this.filePath,
            this.height,
            this.iso6391,
            this.voteAverage,
            this.voteCount,
            this.width});

    Backdrops.fromJson(Map<String, dynamic> json) {
        aspectRatio = json['aspect_ratio'];
        filePath = json['file_path'];
        height = json['height'];
        iso6391 = json['iso_639_1'];
        voteAverage = json['vote_average'];
        voteCount = json['vote_count'];
        width = json['width'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['aspect_ratio'] = this.aspectRatio;
        data['file_path'] = this.filePath;
        data['height'] = this.height;
        data['iso_639_1'] = this.iso6391;
        data['vote_average'] = this.voteAverage;
        data['vote_count'] = this.voteCount;
        data['width'] = this.width;
        return data;
    }
}