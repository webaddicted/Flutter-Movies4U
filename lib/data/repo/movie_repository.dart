import 'dart:convert';

import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/data/bean/category_movie_req.dart';
import 'package:movies4u/data/bean/comon_movie_req.dart';
import 'package:movies4u/data/bean/search_movie_req.dart';
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
import 'package:movies4u/utils/apiutils/api_base_helper.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/global_utility.dart';

class MovieRepository {
  // fetchMovieList() async {
  //   try {
  //     final response = await apiHelper.getWithParam(
  //         "${ApiConstant.POPULAR_MOVIES}",
  //         MovieReq(apiKey:ApiConstant.API_KEY).toJson());
  //     return ApiResponse.returnResponse(
  //         response, MovieRespo.fromJson(jsonDecode(response.toString())));
  //   } catch (error, stacktrace) {
  //     printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
  //     return ApiResponse.error(
  //         errCode: ApiResponseCode.UNKNOWN,
  //         errMsg: error.toString(),
  //         errBdy: stacktrace.toString(),
  //         data: null);
  //   }
  // }

  fetchNowPlaying({String endPoint = "", int page = 1}) async {
    try {
      Map<String, dynamic> commonReq;
      if (page == null) {
        commonReq = CommonMovieReq.empty().toJson();
      } else {
        commonReq = CommonMovieReq.page(page.toString()).toJson();
      }
      final response =
          await apiHelper.getWithParam(url: endPoint, params: commonReq);
      return ApiResponse.returnResponse(
          response, NowPlayingRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  fetchMovieCat() async {
    try {
      final response = await apiHelper.getWithParam(
          url: ApiConstant.genresList,
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(
          response, MovieCatRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  movieDetails(int movieId) async {
    try {
      final response = await apiHelper.getWithParam(
          url: ApiConstant.movieDetails + movieId.toString(),
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(response,
          MovieDetailsRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  movieCrewCast(int movieId) async {
    try {
      final response = await apiHelper.getWithParam(
          url: ApiConstant.movieDetails + movieId.toString() + ApiConstant.creditsCrew,
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(
          response, CreditsCrewRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(msg: "Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  keywordList(int movieId) async {
    try {
      final response = await apiHelper.getWithParam(
          url:
              ApiConstant.movieDetails + movieId.toString() + ApiConstant.movieKeywords,
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(
          response, KeywordRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  movieImg(int movieId) async {
    try {
      final response = await apiHelper.getWithParam(
          url:
              ApiConstant.movieDetails + movieId.toString() + ApiConstant.movieImages,
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(
          response, MovieImgRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  movieVideo(int movieId) async {
    try {
      final response = await apiHelper.getWithParam(
          url:
              ApiConstant.movieDetails + movieId.toString() + ApiConstant.movieVideos,
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(
          response, VideoRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  fetchTrandingPerson(int page) async {
    try {
      final response = await apiHelper.getWithParam(
          url: ApiConstant.trendingPersons,
          params: CommonMovieReq.page(page.toString()).toJson());
      return ApiResponse.returnResponse(response,
          TrandingPersonRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  fetchPersonDetail(int id) async {
    try {
      final response = await apiHelper.getWithParam(
          url: ApiConstant.personsDetails + id.toString(),
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(response,
          PersonDetailRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  fetchPersonMovie(int personId) async {
    try {
      final response = await apiHelper.getWithParam(
          url:
              ApiConstant.personsDetails + personId.toString() + ApiConstant.personsMovieCredits,
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(
          response, PersonMovieRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  fetchPersonImage(int personId) async {
    try {
      final response = await apiHelper.getWithParam(
          url:
              ApiConstant.personsDetails + personId.toString() + ApiConstant.personsImages,
          params: CommonMovieReq.empty().toJson());
      return ApiResponse.returnResponse(
          response, MovieImgRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  fetchCategoryMovie(int catMovieId, int page) async {
    try {
      // printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:'object : fetchCategoryMovie');
      final response = await apiHelper.getWithParam(
          url: ApiConstant.discoverMovie,
          params: CategoryMovieReq.empty(catMovieId.toString(), page).toJson());
      return ApiResponse.returnResponse(
          response, NowPlayingRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  searchMovies(String query, int page) async {
    try {
      final response = await apiHelper.getWithParam(
          url: ApiConstant.searchMovies,
          params: SearchMovieReq.empty(query, page.toString()).toJson());
      return ApiResponse.returnResponse(
          response, NowPlayingRespo.fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      printLog(tag: runtimeType.toString(),status: ApiStatus.error,msg:"Error $error $stacktrace");
      return ApiResponse.error(
          errCode: ApiResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }
}
