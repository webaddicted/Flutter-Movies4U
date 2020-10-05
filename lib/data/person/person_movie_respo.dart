class PersonMovieRespo {
    List<PersonCast> cast;
    List<PersonCrew> crew;
    int id;

    PersonMovieRespo({this.cast, this.crew, this.id});

    PersonMovieRespo.fromJson(Map<String, dynamic> json) {
        if (json['cast'] != null) {
            cast = new List<PersonCast>();
            json['cast'].forEach((v) {
                cast.add(new PersonCast.fromJson(v));
            });
        }
        if (json['crew'] != null) {
            crew = new List<PersonCrew>();
            json['crew'].forEach((v) {
                crew.add(new PersonCrew.fromJson(v));
            });
        }
        id = json['id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.cast != null) {
            data['cast'] = this.cast.map((v) => v.toJson()).toList();
        }
        if (this.crew != null) {
            data['crew'] = this.crew.map((v) => v.toJson()).toList();
        }
        data['id'] = this.id;
        return data;
    }
}

class PersonCast {
    String character;
    String creditId;
    String releaseDate;
    int voteCount;
    bool video;
    bool adult;
    double voteAverage;
    String title;
    List<int> genreIds;
    String originalLanguage;
    String originalTitle;
    double popularity;
    int id;
    String backdropPath;
    String overview;
    String posterPath;

    PersonCast(
        {this.character,
            this.creditId,
            this.releaseDate,
            this.voteCount,
            this.video,
            this.adult,
            this.voteAverage,
            this.title,
            this.genreIds,
            this.originalLanguage,
            this.originalTitle,
            this.popularity,
            this.id,
            this.backdropPath,
            this.overview,
            this.posterPath});

    PersonCast.fromJson(Map<String, dynamic> json) {
        character = json['character'];
        creditId = json['credit_id'];
        releaseDate = json['release_date'];
        voteCount = json['vote_count'];
        video = json['video'];
        adult = json['adult'];
        voteAverage = json['vote_average'].toDouble();
        title = json['title'];
        genreIds = json['genre_ids'].cast<int>();
        originalLanguage = json['original_language'];
        originalTitle = json['original_title'];
        popularity = json['popularity'];
        id = json['id'];
        backdropPath = json['backdrop_path'];
        overview = json['overview'];
        posterPath = json['poster_path'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['character'] = this.character;
        data['credit_id'] = this.creditId;
        data['release_date'] = this.releaseDate;
        data['vote_count'] = this.voteCount;
        data['video'] = this.video;
        data['adult'] = this.adult;
        data['vote_average'] = this.voteAverage;
        data['title'] = this.title;
        data['genre_ids'] = this.genreIds;
        data['original_language'] = this.originalLanguage;
        data['original_title'] = this.originalTitle;
        data['popularity'] = this.popularity;
        data['id'] = this.id;
        data['backdrop_path'] = this.backdropPath;
        data['overview'] = this.overview;
        data['poster_path'] = this.posterPath;
        return data;
    }
}

class PersonCrew {
    int id;
    String department;
    String originalLanguage;
    String originalTitle;
    String job;
    String overview;
    int voteCount;
    bool video;
    String posterPath;
    String backdropPath;
    String title;
    double popularity;
    List<int> genreIds;
    double voteAverage;
    bool adult;
    String releaseDate;
    String creditId;

    PersonCrew(
        {this.id,
            this.department,
            this.originalLanguage,
            this.originalTitle,
            this.job,
            this.overview,
            this.voteCount,
            this.video,
            this.posterPath,
            this.backdropPath,
            this.title,
            this.popularity,
            this.genreIds,
            this.voteAverage,
            this.adult,
            this.releaseDate,
            this.creditId});

    PersonCrew.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        department = json['department'];
        originalLanguage = json['original_language'];
        originalTitle = json['original_title'];
        job = json['job'];
        overview = json['overview'];
        voteCount = json['vote_count'];
        video = json['video'];
        posterPath = json['poster_path'];
        backdropPath = json['backdrop_path'];
        title = json['title'];
        popularity = json['popularity'];
        genreIds = json['genre_ids'].cast<int>();
        voteAverage = json['vote_average'].toDouble();
        adult = json['adult'];
        releaseDate = json['release_date'];
        creditId = json['credit_id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['department'] = this.department;
        data['original_language'] = this.originalLanguage;
        data['original_title'] = this.originalTitle;
        data['job'] = this.job;
        data['overview'] = this.overview;
        data['vote_count'] = this.voteCount;
        data['video'] = this.video;
        data['poster_path'] = this.posterPath;
        data['backdrop_path'] = this.backdropPath;
        data['title'] = this.title;
        data['popularity'] = this.popularity;
        data['genre_ids'] = this.genreIds;
        data['vote_average'] = this.voteAverage;
        data['adult'] = this.adult;
        data['release_date'] = this.releaseDate;
        data['credit_id'] = this.creditId;
        return data;
    }
}