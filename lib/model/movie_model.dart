import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/data/bean/movie_respo.dart';
import 'package:movies4u/data/details/credits_crew_respo.dart';
import 'package:movies4u/data/details/keyword_respo.dart';
import 'package:movies4u/data/details/movie_details_respo.dart';
import 'package:movies4u/data/details/movie_img_respo.dart';
import 'package:movies4u/data/details/video_respo.dart';
import 'package:movies4u/data/home/movie_cat_respo.dart';
import 'package:movies4u/data/home/now_playing_respo.dart';
import 'package:movies4u/data/person/person_detail_respo.dart';
import 'package:movies4u/data/person/person_movie_respo.dart';
import 'package:movies4u/data/person/tranding_person_respo.dart';
import 'package:movies4u/data/repo/movie_repository.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieModel extends Model {
  MovieRepository _movieRepo;
  ApiResponse<MovieRespo> _movieListRespo;

//    {START HOME PAGE API}
  ApiResponse<NowPlayingRespo> _nowPlayingRespo;
  ApiResponse<NowPlayingRespo> _popularMovieRespo;
  ApiResponse<MovieCatRespo> _movieCatRespo;
  ApiResponse<NowPlayingRespo> _trandingMovieRespo;
  ApiResponse<NowPlayingRespo> _discoverMovieRespo;
  ApiResponse<NowPlayingRespo> _upcommingMovieRespo;
  ApiResponse<NowPlayingRespo> _topRatedMovieRespo;

//    {END HOME PAGE API}
//    {START MOVIE DETAILS PAGE API}
  ApiResponse<MovieDetailsRespo> _movieDetailRespo;
  ApiResponse<CreditsCrewRespo> _movieCrewRespo;
  ApiResponse<KeywordRespo> _keywordListRespo;
  ApiResponse<MovieImgRespo> _movieImgRespo;
  ApiResponse<VideoRespo> _movieVideoRespo;
  ApiResponse<NowPlayingRespo> _recommendMovieRespo;
  ApiResponse<NowPlayingRespo> _similarMovieRespo;
  ApiResponse<NowPlayingRespo> _keywordMovieListRespo;

  //    {END MOVIE DETAILS PAGE API}
  ApiResponse<TrandingPersonRespo> _trandingPersonRespo;
  ApiResponse<PersonDetailRespo> _personDetailRespo;
  ApiResponse<PersonMovieRespo> _personMovieRespo;
  ApiResponse<MovieImgRespo> _personImageRespo;
  ApiResponse<NowPlayingRespo> _catMovieRespo;

  MovieModel() {
//    {START HOME PAGE API}
    _movieRepo = MovieRepository();
    _movieListRespo = ApiResponse();
    _nowPlayingRespo = ApiResponse();
    _popularMovieRespo = ApiResponse();
    _movieCatRespo = ApiResponse();
    _trandingMovieRespo = ApiResponse();
    _discoverMovieRespo = ApiResponse();
    _topRatedMovieRespo = ApiResponse();
    _catMovieRespo = ApiResponse();
    //    {END HOME PAGE API}
//    {START MOVIE DETAILS PAGE API}
    _movieDetailRespo = ApiResponse();
    _movieCrewRespo = ApiResponse();
    _keywordListRespo = ApiResponse();
    _movieVideoRespo = ApiResponse();
    _recommendMovieRespo = ApiResponse();
    _similarMovieRespo = ApiResponse();
    _keywordMovieListRespo = ApiResponse();
//    {END MOVIE DETAILS PAGE API}
    _trandingPersonRespo = ApiResponse();
    _personDetailRespo = ApiResponse();
    _personMovieRespo = ApiResponse();
    _personImageRespo = ApiResponse();

  }

  ApiResponse<MovieRespo> get getJsonResonse => _movieListRespo;

  fetchMovieList() async {
    _movieListRespo = ApiResponse.loading();
    _movieListRespo = await _movieRepo.fetchMovieList();
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get nowPlayingRespo => _nowPlayingRespo;

  fetchNowPlaying() async {
    _nowPlayingRespo = ApiResponse.loading();
    notifyListeners();
    _nowPlayingRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.NOW_PLAYING);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get popularMovieRespo => _popularMovieRespo;

  fetchPopularMovie() async {
    _popularMovieRespo = ApiResponse.loading();
    notifyListeners();
    _popularMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.POPULAR_MOVIES);
    notifyListeners();
  }

  ApiResponse<MovieCatRespo> get getMovieCat => _movieCatRespo;

  fetchMovieCat() async {
    _movieCatRespo = ApiResponse.loading();
    notifyListeners();
    _movieCatRespo = await _movieRepo.fetchMovieCat();
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getTrandingMovie => _trandingMovieRespo;

  trandingMovie() async {
    _trandingMovieRespo = ApiResponse.loading();
    notifyListeners();
    _trandingMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.TRENDING_MOVIE_LIST);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getDiscoverMovie => _discoverMovieRespo;

  discoverMovie() async {
    _discoverMovieRespo = ApiResponse.loading();
    notifyListeners();
    _discoverMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.DISCOVER_MOVIE);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getUpcommingMovie => _upcommingMovieRespo;

  upcommingMovie() async {
    _upcommingMovieRespo = ApiResponse.loading();
    notifyListeners();
    _upcommingMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.UPCOMING_MOVIE);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getTopRatedMovie => _topRatedMovieRespo;

  topRatedMovie() async {
    _topRatedMovieRespo = ApiResponse.loading();
    notifyListeners();
    _topRatedMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.TOP_RATED);
    notifyListeners();
  }

  ApiResponse<MovieDetailsRespo> get getMovieDetails => _movieDetailRespo;

  movieDetails(int movieId) async {
    _movieDetailRespo = ApiResponse.loading();
    notifyListeners();
    _movieDetailRespo = await _movieRepo.movieDetails(movieId);
    notifyListeners();
  }

  ApiResponse<CreditsCrewRespo> get getMovieCrew => _movieCrewRespo;

  movieCrewCast(int movieId) async {
    _movieCrewRespo = ApiResponse.loading();
    notifyListeners();
    _movieCrewRespo = await _movieRepo.movieCrewCast(movieId);
    notifyListeners();
  }

  ApiResponse<KeywordRespo> get getMovieKeyword => _keywordListRespo;

  keywordList(int movieId) async {
    _keywordListRespo = ApiResponse.loading();
    notifyListeners();
    _keywordListRespo = await _movieRepo.keywordList(movieId);
    notifyListeners();
  }

  ApiResponse<VideoRespo> get getMovieVideo => _movieVideoRespo;

  movieVideo(int movieId) async {
    _movieVideoRespo = ApiResponse.loading();
    notifyListeners();
    _movieVideoRespo = await _movieRepo.movieVideo(movieId);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get recommendMovieRespo => _recommendMovieRespo;

  fetchRecommendMovie(int movieId) async {
    _recommendMovieRespo = ApiResponse.loading();
    notifyListeners();
    _recommendMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.MOVIE_DETAILS +
            movieId.toString() +
            ApiConstant.RECOMMENDATIONS_MOVIE);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get similarMovieRespo => _similarMovieRespo;

  fetchSimilarMovie(int movieId) async {
    _similarMovieRespo = ApiResponse.loading();
    notifyListeners();
    _similarMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.MOVIE_DETAILS +
            movieId.toString() +
            ApiConstant.SIMILAR_MOVIES);
    notifyListeners();
  }

  ApiResponse<MovieImgRespo> get movieImgRespo => _movieImgRespo;

  movieImg(int movieId) async {
    _movieImgRespo = ApiResponse.loading();
    notifyListeners();
    _movieImgRespo = await _movieRepo.movieImg(movieId);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get keywordMovieListRespo =>
      _keywordMovieListRespo;

  fetchKeywordMovieList(int keywordId) async {
    _keywordMovieListRespo = ApiResponse.loading();
    notifyListeners();
    _keywordMovieListRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.KEYWORDS_MOVIE_LIST +
            keywordId.toString() +
            ApiConstant.KEYWORDS_API_MOVIES);
    notifyListeners();
  }

  ApiResponse<TrandingPersonRespo> get trandingPersonRespo =>
      _trandingPersonRespo;

  fetchTrandingPerson() async {
    _trandingPersonRespo = ApiResponse.loading();
    notifyListeners();
    _trandingPersonRespo = await _movieRepo.fetchTrandingPerson();
    notifyListeners();
  }

  ApiResponse<PersonDetailRespo> get personDetailRespo => _personDetailRespo;

  fetchPersonDetail(int id) async {
    _personDetailRespo = ApiResponse.loading();
    notifyListeners();
    _personDetailRespo = await _movieRepo.fetchPersonDetail(id);
    notifyListeners();
  }

  ApiResponse<PersonMovieRespo> get personMovieRespo => _personMovieRespo;

  fetchPersonMovie(int personId) async {
    _personMovieRespo = ApiResponse.loading();
    notifyListeners();
    _personMovieRespo = await _movieRepo.fetchPersonMovie(personId);
    notifyListeners();
  }

  ApiResponse<MovieImgRespo> get personImageRespo => _personImageRespo;

  fetchPersonImage(int personId) async {
    _personImageRespo = ApiResponse.loading();
    notifyListeners();
    _personImageRespo = await _movieRepo.fetchPersonImage(personId);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get catMovieRespo => _catMovieRespo;

  fetchCategoryMovie(int movieCatId) async {
    _catMovieRespo = ApiResponse.loading();
    notifyListeners();
    _catMovieRespo = await _movieRepo.fetchCategoryMovie(movieCatId);
    notifyListeners();
  }
}
