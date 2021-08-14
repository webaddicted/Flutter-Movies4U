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
import 'package:movies4u/view/widget/movie_cate.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieListScreen extends StatefulWidget {
  String? apiName, dynamicList, titleTag;
  int movieId;

  MovieListScreen(
      {this.apiName , this.dynamicList , this.movieId = 0, this.titleTag = ""});

  @override
  _MovieListScreenState createState() =>
      _MovieListScreenState(apiName, dynamicList, movieId, titleTag);
}

class _MovieListScreenState extends State<MovieListScreen> {
  late SizingInformation sizeInfo;

  late BuildContext ctx;

  late MovieModel model;

  late List<NowPlayResult> dataResult = [];
  late List<Results> dataPersonResult = [];
  late ScrollController _scrollController = new ScrollController();
  late int total_pages = 1;
  late int pageSize = 1;

  _MovieListScreenState(
      this.apiName, this.dynamicList, this.movieId, this.titleTag);
  late String? apiName, dynamicList;
  late int movieId;
  late String? castCrewTitle, titleTag;

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    callMovieApi(apiName!, model, movieId: movieId, page: pageSize);
    _scrollController.addListener(() {
      // debugPrint(
      //     "pixels : ${_scrollController.position
      //         .pixels}  \n maxScrollExtent : ${_scrollController.position
      //         .maxScrollExtent}");
      if (_scrollController.position.pixels > 0 &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        if (pageSize <= total_pages)
          callMovieApi(apiName!, model, movieId: movieId, page: pageSize);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () => Navigator.pop(context));
    // print("List title : $dynamicList -- $apiName  ${getTitle(dynamicList != null ? dynamicList! : apiName)}");
    return Scaffold(
        appBar: getAppBarWithBackBtn(
            title: getTitle(dynamicList != null ? dynamicList! : apiName!),
            bgColor: ColorConst.WHITE_BG_COLOR,
            titleTag: titleTag!,
            icon: homeIcon),
        body: ResponsiveBuilder(builder: (context, sizeInf) {
          sizeInfo = sizeInf;
          return OrientationBuilder(
              builder: (context, orientation) =>
                  ScopedModel(model: model, child: apiresponse(orientation)));
        }));
  }

  Widget apiresponse(Orientation orientation) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = getData(apiName!, model);
        if (jsonResult.status == ApiStatus.COMPLETED) {
          return getCount(jsonResult.data) > 0
              ?  Scrollbar(
            isAlwaysShown: sizeInfo.deviceScreenType == DeviceScreenType.desktop,
            radius: Radius.circular(5),
            thickness: 20,
                child: SingleChildScrollView(

                child: _createUi(jsonResult.data, orientation)),
              )
              : Container();
        } else
          return apiHandler(
              loading: ShimmerView(
                sizeInfo,
                apiName: apiName!,
                viewType: ShimmerView.VIEW_CATEGORY,
              ),
              response: jsonResult);
      },
    );
  }

  Widget _createUi(data, Orientation orientation) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    int columnCount = 0;
    if (data is NowPlayingRespo) {
      pageSize++;
      total_pages = data.totalPages!;
      dataResult.addAll(data.results!);
      columnCount = sizeInfo.deviceScreenType == DeviceScreenType.desktop
          ? 6
          : orientation == Orientation.portrait
              ? 2
              : 4;
    } else if (data is TrandingPersonRespo) {
      pageSize++;
      total_pages = data.totalPages!;
      dataPersonResult.addAll(data.results!);
      columnCount = sizeInfo.deviceScreenType == DeviceScreenType.desktop
          ? 5
          : orientation == Orientation.portrait
              ? 3
              : 4;
    } else {
      pageSize++;
      // total_pages = data.total_pages;
      // dataPersonResult.addAll(data.results);
      columnCount = sizeInfo.deviceScreenType == DeviceScreenType.desktop
          ? 5
          : orientation == Orientation.portrait
              ? 3
              : 4;
      if ((apiName == StringConst.PERSON_MOVIE_CAST &&
              data is PersonMovieRespo) ||
          (apiName == StringConst.PERSON_MOVIE_CREW &&
              data is PersonMovieRespo))
        columnCount = sizeInfo.deviceScreenType == DeviceScreenType.desktop
            ? 6
            : orientation == Orientation.portrait
                ? 2
                : 4;
    }
    double screenSize = data is NowPlayingRespo
        ? (sizeInfo.deviceScreenType == DeviceScreenType.desktop)
            ? 350
            : 290
        : sizeInfo.deviceScreenType == DeviceScreenType.desktop
            ? 280
            : 128;
    if ((apiName == StringConst.PERSON_MOVIE_CAST &&
            data is PersonMovieRespo) ||
        (apiName == StringConst.PERSON_MOVIE_CREW && data is PersonMovieRespo))
      screenSize =
          (sizeInfo.deviceScreenType == DeviceScreenType.desktop) ? 350 : 290;
    // print("screenSize   : $screenSize");
    // columnCount = sizeInfo.deviceScreenType == DeviceScreenType.desktop?5:(orientation == Orientation.portrait ? (data is NowPlayingRespo?2:3 ): (data is NowPlayingRespo?4:4));
    return Container(
//      width: double.infinity,
//      height: double.infinity,
        child: Container(
      alignment: Alignment.center,
      child: (data is MovieCatRespo &&
              sizeInfo.deviceScreenType != DeviceScreenType.desktop)
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: getCount(data),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(height: 180, child: getItemView(data, index, ));
                // return Container(margin:EdgeInsets.all(50),height: 50,color: Colors.amber,);
              })
          : StaggeredGridView.countBuilder(
              crossAxisCount: columnCount,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              shrinkWrap: true,
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.extent(1, screenSize),
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: data is NowPlayingRespo
                  ? dataResult.length
                  : (data is TrandingPersonRespo
                      ? dataPersonResult.length
                      : getCount(data)),
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: getItemView(data, index,
                    dataResult: dataResult, dataPersonResult: dataPersonResult),
              ),
            ),
    ));
  }

  int getCount(result) {
    if (apiName == StringConst.MOVIE_CAST && result is CreditsCrewRespo)
      return result.cast!.length;
    else if (apiName == StringConst.MOVIE_CREW && result is CreditsCrewRespo)
      return result.crew!.length;
    else if (result is TrandingPersonRespo)
      return result.results!.length;
    else if (result is NowPlayingRespo) return result.results!.length;
    if (apiName == StringConst.PERSON_MOVIE_CAST && result is PersonMovieRespo)
      return result.cast!.length;
    else if (apiName == StringConst.PERSON_MOVIE_CREW &&
        result is PersonMovieRespo)
      return result.crew!.length;
    else if (result is MovieCatRespo)
      return result.genres!.length;
    else
      return 1;
  }

  Widget getItemView(data, int index,
      { List<NowPlayResult>? dataResult,  List<Results>? dataPersonResult}) {
    try {
      if (data is CreditsCrewRespo) return getPersonDetails(data, index);
      if (data is TrandingPersonRespo) {
        var result = dataPersonResult![index];
        var tag = apiName! + 'tranding' + index.toString();
        return castCrewItem(
            id: result.id!,
            name: result.name!,
            tag: tag,
            image: result.profilePath!,
            sizeInfo: sizeInfo,
            job: result.knownForDepartment!,
            onTap: (int id) => navigationPush(
                context,
                PersonDetail(
                    id: id,
                    name: result.name,
                    imgPath: ApiConstant.IMAGE_POSTER + result.profilePath!,
                    tag: tag)));
      } else if (data is NowPlayingRespo) {
        // NowPlayResult item = data.results[index];
        NowPlayResult item = dataResult![index];

        return getMovieItemRow(
            context: context,
            apiName: apiName,
            index: index,
            height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                ? 310
                : 250,
            width: 135,
            id: item.id!,
            img: item.posterPath!,
            name: item.originalTitle!,
            vote: item.voteAverage!);
      } else if (apiName == StringConst.PERSON_MOVIE_CAST &&
          data is PersonMovieRespo) {
        PersonCast item = data.cast![index];
        return getMovieItemRow(
            context: context,
            apiName: apiName,
            index: index,
            height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                ? 310
                : 240,
            width: 135,
            id: item.id!,
            img: item.posterPath!,
            name: item.originalTitle!,
            vote: item.voteAverage);
      } else if (apiName == StringConst.PERSON_MOVIE_CREW &&
          data is PersonMovieRespo) {
        PersonCrew item = data.crew![index];
        return getMovieItemRow(
            context: context,
            apiName: apiName,
            index: index,
            height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                ? 310
                : 240,
            width: 135,
            id: item.id!,
            img: item.posterPath!,
            name: item.originalTitle!,
            vote: item.voteAverage);
      } else if (apiName == ApiConstant.GENRES_LIST && data is MovieCatRespo) {
        Genres item = data.genres![index];
        String tag = getTitle(apiName!) + item.name! + index.toString();
        final size = MediaQuery.of(ctx).size;
        if (sizeInfo.deviceScreenType == DeviceScreenType.desktop)
          return getCatRow(context, index, item, sizeInfo);
        else
          return fullListImage(
              name: item.name!,
              image: getCategoryMovie()[index],
              tag: tag,
              size: size,
              onTap: () {
                navigationPush(
                    context,
                    MovieListScreen(
                        apiName: StringConst.MOVIE_CATEGORY,
                        dynamicList: item.name!,
                        movieId: item.id!));
              });
      } else
        return Container(
          child: getTxt(msg: 'Data not found'),
        );
    } catch (ex) {
      return Card(clipBehavior: Clip.antiAlias, color: ColorConst.GREY_SHADE);
    }
    return  Card(clipBehavior: Clip.antiAlias, color: ColorConst.GREY_SHADE);
  }

  Widget getPersonDetails(CreditsCrewRespo results, int index) {
    String? image = apiName == StringConst.MOVIE_CAST
        ? results.cast![index].profilePath
        : results.crew![index].profilePath;
    String? name = apiName == StringConst.MOVIE_CAST
        ? results.cast![index].name
        : results.crew![index].name;
    String? chatactor = apiName == StringConst.MOVIE_CAST
        ? results.cast![index].character
        : results.crew![index].job;
    int? id = apiName == StringConst.MOVIE_CAST
        ? results.cast![index].id
        : results.crew![index].id;
    var tag = apiName! + 'cast_crew list' + index.toString();
    return castCrewItem(
        id: id!,
        name: name!,
        tag: tag,
        image: image!,
        job: chatactor!,
        sizeInfo: sizeInfo,
        onTap: (int id) => navigationPush(
            context,
            PersonDetail(
                id: id,
                name: name,
                imgPath: ApiConstant.IMAGE_POSTER + image,
                tag: tag)));
  }
}
