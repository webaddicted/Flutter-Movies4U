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
  late MovieRepository _movieRepo;
  // ApiResponse<MovieRespo> _movieListRespo;

//    {START HOME PAGE API}
  late ApiResponse<NowPlayingRespo> _nowPlayingRespo;
  late ApiResponse<NowPlayingRespo> _popularMovieRespo;
  late ApiResponse<MovieCatRespo> _movieCatRespo;
  late ApiResponse<NowPlayingRespo> _trandingMovieRespo;
  late ApiResponse<NowPlayingRespo> _discoverMovieRespo;
  late ApiResponse<NowPlayingRespo> _upcommingMovieRespo;
  late ApiResponse<NowPlayingRespo> _topRatedMovieRespo;

//     {END HOME PAGE API}
//     {START MOVIE DETAILS PAGE API}
  late ApiResponse<MovieDetailsRespo> _movieDetailRespo;
  late ApiResponse<CreditsCrewRespo> _movieCrewRespo;
  late ApiResponse<KeywordRespo> _keywordListRespo;
  late ApiResponse<MovieImgRespo> _movieImgRespo;
  late ApiResponse<VideoRespo> _movieVideoRespo;
  late ApiResponse<NowPlayingRespo> _recommendMovieRespo;
  late ApiResponse<NowPlayingRespo> _similarMovieRespo;
  late ApiResponse<NowPlayingRespo> _keywordMovieListRespo;

  //    {END MOVIE DETAILS PAGE API}
  late ApiResponse<TrandingPersonRespo> _trandingPersonRespo;
  late ApiResponse<PersonDetailRespo> _personDetailRespo;
  late ApiResponse<PersonMovieRespo> _personMovieRespo;
  late ApiResponse<MovieImgRespo> _personImageRespo;
  late ApiResponse<NowPlayingRespo> _catMovieRespo;
  late ApiResponse<NowPlayingRespo> _searchMovieRespo;

  MovieModel() {
//    {START HOME PAGE API}
    _movieRepo = MovieRepository();
    // _movieListRespo = ApiResponse();
    _nowPlayingRespo = ApiResponse();
    _popularMovieRespo = ApiResponse.loading();
    _movieCatRespo = ApiResponse();
    _trandingMovieRespo = ApiResponse.loading();
    _discoverMovieRespo = ApiResponse.loading();
    _topRatedMovieRespo = ApiResponse.loading();
    _catMovieRespo = ApiResponse.loading();
    _searchMovieRespo = ApiResponse();
    _upcommingMovieRespo= ApiResponse.loading();
    //    {END HOME PAGE API}
//    {START MOVIE DETAILS PAGE API}
    _movieDetailRespo = ApiResponse();
    _movieCrewRespo = ApiResponse();
    _keywordListRespo = ApiResponse();
    _movieVideoRespo = ApiResponse();
    _recommendMovieRespo = ApiResponse.loading();
    _similarMovieRespo = ApiResponse.loading();
    _keywordMovieListRespo =  ApiResponse.loading();
//    {END MOVIE DETAILS PAGE API}
    _trandingPersonRespo = ApiResponse();
    _personDetailRespo = ApiResponse();
    _personMovieRespo = ApiResponse();
    _personImageRespo = ApiResponse();
  }

  // ApiResponse<MovieRespo> get getJsonResonse => _movieListRespo;

  // fetchMovieList() async {
  //   _movieListRespo = ApiResponse.loading();
  //   _movieListRespo = await _movieRepo.fetchMovieList();
  //   notifyListeners();
  // }

  ApiResponse<NowPlayingRespo> get nowPlayingRespo => _nowPlayingRespo;

  fetchNowPlaying() async {
    _nowPlayingRespo = ApiResponse.loading();
    notifyListeners();
    _nowPlayingRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.NOW_PLAYING);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get popularMovieRespo => _popularMovieRespo;

  fetchPopularMovie(int page) async {
    // _popularMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _popularMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.POPULAR_MOVIES, page: page);
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

  trandingMovie(int page) async {
    // assadasd
    // _trandingMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _trandingMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.TRENDING_MOVIE_LIST, page: page);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getDiscoverMovie => _discoverMovieRespo;

  discoverMovie(int page) async {
    // _discoverMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _discoverMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.DISCOVER_MOVIE, page: page);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getUpcommingMovie => _upcommingMovieRespo;

  upcommingMovie(int page) async {
    // _upcommingMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _upcommingMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.UPCOMING_MOVIE, page: page);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get getTopRatedMovie => _topRatedMovieRespo;

  topRatedMovie(int page) async {
    // _topRatedMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _topRatedMovieRespo =
        await _movieRepo.fetchNowPlaying(endPoint: ApiConstant.TOP_RATED, page: page);
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
    // _movieCrewRespo = ApiResponse.loading();
    // notifyListeners();
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

  fetchRecommendMovie(int movieId,int page) async {
    // _recommendMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _recommendMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.MOVIE_DETAILS +
            movieId.toString() +
            ApiConstant.RECOMMENDATIONS_MOVIE, page: page);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get similarMovieRespo => _similarMovieRespo;

  fetchSimilarMovie(int movieId,int page) async {
    // _similarMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _similarMovieRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.MOVIE_DETAILS +
            movieId.toString() +
            ApiConstant.SIMILAR_MOVIES, page: page);
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

  fetchKeywordMovieList(int keywordId, int page) async {
    // _keywordMovieListRespo = ApiResponse.loading();
    // notifyListeners();
    _keywordMovieListRespo = await _movieRepo.fetchNowPlaying(
        endPoint: ApiConstant.KEYWORDS_MOVIE_LIST +
            keywordId.toString() +
            ApiConstant.KEYWORDS_API_MOVIES, page: page);
    notifyListeners();
  }

  ApiResponse<TrandingPersonRespo> get trandingPersonRespo =>
      _trandingPersonRespo;

  fetchTrandingPerson(page) async {
    // _trandingPersonRespo = ApiResponse.loading();
    // notifyListeners();
    _trandingPersonRespo = await _movieRepo.fetchTrandingPerson(page);
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
    // _personMovieRespo = ApiResponse.loading();
    // notifyListeners();
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

  fetchCategoryMovie(int movieCatId, int page) async {
    // _catMovieRespo = ApiResponse.loading();
    // notifyListeners();
    _catMovieRespo = await _movieRepo.fetchCategoryMovie(movieCatId, page);
    notifyListeners();
  }

  ApiResponse<NowPlayingRespo> get searchMovieRespo => _searchMovieRespo;

  serachMovies(String query, int page, bool clearlist) async {
    // _searchMovieRespo = ApiResponse.loading();
    // notifyListeners();
    if (clearlist)
      _searchMovieRespo = ApiResponse();
    _searchMovieRespo = await _movieRepo.searchMovies(query, page);
    // var dfs = _searchMovieRespo.data.results;
    // dfs.addAll(result);
    // _searchMovieRespo.data.results = dfs;
    notifyListeners();
  }
}
