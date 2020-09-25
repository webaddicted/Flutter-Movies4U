class NowPlayingRespo {
    Dates dates;
    int page;
    List<Result> results;
    int total_pages;
    int total_results;

    NowPlayingRespo({this.dates, this.page, this.results, this.total_pages, this.total_results});

    factory NowPlayingRespo.fromJson(Map<String, dynamic> json) {
        return NowPlayingRespo(
            dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
            page: json['page'],
            results: json['results'] != null ? (json['results'] as List).map((i) => Result.fromJson(i)).toList() : null,
            total_pages: json['total_pages'],
            total_results: json['total_results'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['page'] = this.page;
        data['total_pages'] = this.total_pages;
        data['total_results'] = this.total_results;
        if (this.dates != null) {
            data['dates'] = this.dates.toJson();
        }
        if (this.results != null) {
            data['results'] = this.results.map((v) => v.toJson()).toList();
        }
        return data;
    }

}
class Result {
    bool adult;
    String backdrop_path;
    List<int> genre_ids;
    int id;
    String original_language;
    String original_title;
    String overview;
    double popularity;
    String poster_path;
    String release_date;
    String title;
    bool video;
    dynamic vote_average;
    int vote_count;

    Result({this.adult, this.backdrop_path, this.genre_ids, this.id, this.original_language, this.original_title, this.overview, this.popularity, this.poster_path, this.release_date, this.title, this.video, this.vote_average, this.vote_count});

    factory Result.fromJson(Map<String, dynamic> json) {
        return Result(
            adult: json['adult'],
            backdrop_path: json['backdrop_path'],
            genre_ids: json['genre_ids'] != null ? new List<int>.from(json['genre_ids']) : null,
            id: json['id'],
            original_language: json['original_language'],
            original_title: json['original_title'],
            overview: json['overview'],
            popularity: json['popularity'],
            poster_path: json['poster_path'],
            release_date: json['release_date'],
            title: json['title'],
            video: json['video'],
            vote_average: json['vote_average'].toDouble(),
            vote_count: json['vote_count'].toInt(),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['adult'] = this.adult;
        data['backdrop_path'] = this.backdrop_path;
        data['id'] = this.id;
        data['original_language'] = this.original_language;
        data['original_title'] = this.original_title;
        data['overview'] = this.overview;
        data['popularity'] = this.popularity;
        data['poster_path'] = this.poster_path;
        data['release_date'] = this.release_date;
        data['title'] = this.title;
        data['video'] = this.video;
        data['vote_average'] = this.vote_average;
        data['vote_count'] = this.vote_count;
        if (this.genre_ids != null) {
            data['genre_ids'] = this.genre_ids;
        }
        return data;
    }
}

class Dates {
    String maximum;
    String minimum;

    Dates({this.maximum, this.minimum});

    factory Dates.fromJson(Map<String, dynamic> json) {
        return Dates(
            maximum: json['maximum'],
            minimum: json['minimum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['maximum'] = this.maximum;
        data['minimum'] = this.minimum;
        return data;
    }
}

