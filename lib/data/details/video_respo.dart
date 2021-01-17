class VideoRespo {
    int id;
    List<Results> results;

    VideoRespo({this.id, this.results});

    VideoRespo.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        if (json['results'] != null) {
            results = new List<Results>();
            json['results'].forEach((v) {
                results.add(new Results.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        if (this.results != null) {
            data['results'] = this.results.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Results {
    String id;
    String iso6391;
    String iso31661;
    String key;
    String name;
    String site;
    int size;
    String type;

    Results(
        {this.id,
            this.iso6391,
            this.iso31661,
            this.key,
            this.name,
            this.site,
            this.size,
            this.type});

    Results.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        iso6391 = json['iso_639_1'];
        iso31661 = json['iso_3166_1'];
        key = json['key'];
        name = json['name'];
        site = json['site'];
        size = json['size'];
        type = json['type'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['iso_639_1'] = this.iso6391;
        data['iso_3166_1'] = this.iso31661;
        data['key'] = this.key;
        data['name'] = this.name;
        data['site'] = this.site;
        data['size'] = this.size;
        data['type'] = this.type;
        return data;
    }
}