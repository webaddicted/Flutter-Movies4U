import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/details/credits_crew_respo.dart';
import 'package:movies4u/data/home/movie_cat_respo.dart';
import 'package:movies4u/data/home/now_playing_respo.dart';
import 'package:movies4u/data/person/person_movie_respo.dart';
import 'package:movies4u/data/person/tranding_person_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/home/home_screen.dart';
import 'package:movies4u/view/person/person_detail.dart';
import 'package:movies4u/view/widget/carousel_view.dart';
import 'package:movies4u/view/widget/movie_cast_crew.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieListScreen extends StatefulWidget {
  String apiName, dynamicList, titleTag;
  int movieId;

  MovieListScreen(
      {this.apiName, this.dynamicList, this.movieId, this.titleTag});

  @override
  _MovieListScreenState createState() =>
      _MovieListScreenState(apiName, dynamicList, movieId, titleTag);
}

class _MovieListScreenState extends State<MovieListScreen> {
  _MovieListScreenState(
      this.apiName, this.dynamicList, this.movieId, this.titleTag);

  int movieId;
  String castCrewTitle, titleTag;
  MovieModel model;
  String apiName, dynamicList;

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    callMovieApi(apiName, model, movieId: movieId);
  }

  @override
  Widget build(BuildContext context) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color:ColorConst.BLACK_COLOR,
        ),
        onPressed: () => Navigator.pop(context));
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            ctx: context,
            title: getTitle(dynamicList != null ? dynamicList : apiName),
            bgColor: ColorConst.WHITE_BG_COLOR,
            titleTag: titleTag,
            icon: homeIcon),
        body: ScopedModel(model: model, child: apiresponse()));
  }

  Widget apiresponse() {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = getData(apiName, model);
        if (jsonResult.status == ApiStatus.COMPLETED) {
          return getCount(jsonResult.data) > 0
              ? _createUi(jsonResult.data)
              : Container();
        } else
          return apiHandler(
              loading: ShimmerView(
                apiName: apiName,
                viewType: ShimmerView.VIEW_CATEGORY,
              ),
              response: jsonResult);
      },
    );
  }

  Widget _createUi(data) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Container(
//      width: double.infinity,
//      height: double.infinity,
        child: Container(
      alignment: Alignment.center,
      child: data is MovieCatRespo
          ? ListView.builder(
              itemCount: getCount(data),
              itemBuilder: (BuildContext context, int index) {
                return getItemView(data, index);
              })
          : StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: getCount(data),
              //results.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.all(6.0),
                child: getItemView(data, index),
              ),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
    ));
  }

  int getCount(result) {
    if (apiName == StringConst.MOVIE_CAST && result is CreditsCrewRespo)
      return result.cast.length;
    else if (apiName == StringConst.MOVIE_CREW && result is CreditsCrewRespo)
      return result.crew.length;
    else if (result is TrandingPersonRespo)
      return result.results.length;
    else if (result is NowPlayingRespo) return result.results.length;
    if (apiName == StringConst.PERSON_MOVIE_CAST && result is PersonMovieRespo)
      return result.cast.length;
    else if (apiName == StringConst.PERSON_MOVIE_CREW &&
        result is PersonMovieRespo)
      return result.crew.length;
    else if (result is MovieCatRespo)
      return result.genres.length;
    else
      return 1;
  }

  Widget getItemView(data, int index) {
    if (data is CreditsCrewRespo) return getPersonDetails(data, index);
    if (data is TrandingPersonRespo) {
      var result = data.results[index];
      var tag = apiName + 'tranding' + index.toString();
      return castCrewItem(
          id: result.id,
          name: result.name,
          tag: tag,
          image: result.profilePath,
          job: result.knownForDepartment,
          onTap: (int id) => navigationPush(
              context,
              PersonDetail(
                  id: id,
                  name: result.name,
                  imgPath: ApiConstant.IMAGE_POSTER + result.profilePath,
                  tag: tag)));
    } else if (data is NowPlayingRespo) {
      NowPlayResult item = data.results[index];
      return getMovieItemRow(
          context: context,
          apiName: apiName,
          index: index,
          height: 240,
          width: 135,
          id: item.id,
          img: item.poster_path,
          name: item.original_title,
          vote: item.vote_average);
    } else if (apiName == StringConst.PERSON_MOVIE_CAST &&
        data is PersonMovieRespo) {
      PersonCast item = data.cast[index];
      return getMovieItemRow(
          context: context,
          apiName: apiName,
          index: index,
          height: 240,
          width: 135,
          id: item.id,
          img: item.posterPath,
          name: item.originalTitle,
          vote: item.voteAverage);
    } else if (apiName == StringConst.PERSON_MOVIE_CREW &&
        data is PersonMovieRespo) {
      PersonCrew item = data.crew[index];
      return getMovieItemRow(
          context: context,
          apiName: apiName,
          index: index,
          height: 240,
          width: 135,
          id: item.id,
          img: item.posterPath,
          name: item.originalTitle,
          vote: item.voteAverage);
    } else if (apiName == ApiConstant.GENRES_LIST && data is MovieCatRespo) {
      Genres item = data.genres[index];
      String tag = getTitle(apiName) + item.name + index.toString();
      return fullListImage(
          name: item.name,
          image: getCategoryMovie()[index],
          tag: tag,
          onTap: () {
            navigationPush(
                context,
                MovieListScreen(
                    apiName: StringConst.MOVIE_CATEGORY,
                    dynamicList: item.name,
                    movieId: item.id));
          });
    } else
      Container(
        child: getTxt(msg: 'Data not found'),
      );
  }

  Widget getPersonDetails(CreditsCrewRespo results, int index) {
    String image = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].profilePath
        : results.crew[index].profilePath;
    String name = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].name
        : results.crew[index].name;
    String chatactor = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].character
        : results.crew[index].job;
    int id = apiName == StringConst.MOVIE_CAST
        ? results.cast[index].id
        : results.crew[index].id;
    var tag = apiName + 'cast_crew list' + index.toString();
    return castCrewItem(
        id: id,
        name: name,
        tag: tag,
        image: image,
        job: chatactor,
        onTap: (int id) => navigationPush(
            context,
            PersonDetail(
                id: id,
                name: name,
                imgPath: ApiConstant.IMAGE_POSTER + image,
                tag: tag)));
  }
}
