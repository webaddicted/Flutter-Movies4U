import 'package:movies4u/data/home/now_playing_respo.dart';

class MovieRespo {
  // int page;
  // int totalResults;
  // int totalPages;
  // List<NowPlayResult> results;
  //
  // MovieRespo({this.page, this.totalResults, this.totalPages, this.results});
  //
  // MovieRespo.fromJson(Map<String, dynamic> json) {
  //   page = json['page'];
  //   totalResults = json['total_results'];
  //   totalPages = json['total_pages'];
  //   if (json['results'] != null) {
  //     results = new List<NowPlayResult>();
  //     json['results'].forEach((v) {
  //       results.add(new NowPlayResult.fromJson(v));
  //     });
  //   }
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['page'] = this.page;
  //   data['total_results'] = this.totalResults;
  //   data['total_pages'] = this.totalPages;
  //   if (this.results != null) {
  //     data['results'] = this.results.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
// class Movie {
//   int voteCount;
//   int id;
//   bool video;
//   var voteAverage;
//   String title;
//   double popularity;
//   String posterPath;
//   String originalLanguage;
//   String originalTitle;
//   List<int> genreIds;
//   String backdropPath;
//   bool adult;
//   String overview;
//   String releaseDate;
//
//   Movie(
//       {this.voteCount,
//         this.id,
//         this.video,
//         this.voteAverage,
//         this.title,
//         this.popularity,
//         this.posterPath,
//         this.originalLanguage,
//         this.originalTitle,
//         this.genreIds,
//         this.backdropPath,
//         this.adult,
//         this.overview,
//         this.releaseDate});
//
//   Movie.fromJson(Map<String, dynamic> json) {
//     voteCount = json['vote_count'];
//     id = json['id'];
//     video = json['video'];
//     voteAverage = json['vote_average'];
//     title = json['title'];
//     popularity = json['popularity'];
//     posterPath = json['poster_path'];
//     originalLanguage = json['original_language'];
//     originalTitle = json['original_title'];
//     genreIds = json['genre_ids'].cast<int>();
//     backdropPath = json['backdrop_path'];
//     adult = json['adult'];
//     overview = json['overview'];
//     releaseDate = json['release_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['vote_count'] = this.voteCount;
//     data['id'] = this.id;
//     data['video'] = this.video;
//     data['vote_average'] = this.voteAverage;
//     data['title'] = this.title;
//     data['popularity'] = this.popularity;
//     data['poster_path'] = this.posterPath;
//     data['original_language'] = this.originalLanguage;
//     data['original_title'] = this.originalTitle;
//     data['genre_ids'] = this.genreIds;
//     data['backdrop_path'] = this.backdropPath;
//     data['adult'] = this.adult;
//     data['overview'] = this.overview;
//     data['release_date'] = this.releaseDate;
//     return data;
//   }
// }

