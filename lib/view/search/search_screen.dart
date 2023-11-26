import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/home/now_playing_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/global_utility.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/ads/banner_widget.dart';
import 'package:movies4u/view/details/detail_movie.dart';
import 'package:movies4u/view/widget/rating_result.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late MovieModel model;
  String query = ' ';

  late BuildContext ctx;
  List<NowPlayResult> dataResult = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  int totalPages = 1;
  int pageSize = 1;

  late SizingInformation sizeInfo;

  @override
  void initState() {
    model = MovieModel();
    model.searchMovies(searchController.text.toString(), pageSize, true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0 &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        if (pageSize <= totalPages) {
          model.searchMovies(searchController.text.toString(), pageSize, false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConst.blackColor,
        ),
        onPressed: () => Navigator.pop(context));
    return Scaffold(
        // appBar: getAppBarWithBackBtn(
        //     ctx: context,
        //     title: getTitle('SearchMovie'),
        //     bgColor: ColorConst.WHITE_BG_COLOR,
        //     titleTag: 'Search mOivie',
        //     icon: homeIcon),
        body: ResponsiveBuilder(builder: (context, sizeInf) {
      sizeInfo = sizeInf;
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? 0
                    : 30),
            PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: Card(
                child: TextField(
                  onChanged: (String query) {
                    pageSize = 1;
                    query = query;
                    dataResult.clear();
                    model.searchMovies(query, pageSize, true);
                  },
                  autofocus: true,
                  controller: searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: StringConst.searchMovie,
                      icon: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios)),
                      suffixIcon: IconButton(
                          onPressed: () => searchController.clear(),
                          icon: const Icon(Icons.close_rounded))),
                ),
              ),
            ),
            ScopedModel(model: model, child: apiResponse()),
          ],
        ),
      );
    }));
    // _createUi(null));
    //
  }

  Widget apiResponse() {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.searchMovieRespo;
        if (jsonResult.status == ApiStatus.success) {
          return jsonResult.data!.totalResults! > 0 || dataResult.isNotEmpty
              ? Scrollbar(
                  thumbVisibility:
                      sizeInfo.deviceScreenType == DeviceScreenType.desktop,
                  radius: const Radius.circular(5),
                  thickness:
                      sizeInfo.deviceScreenType == DeviceScreenType.desktop
                          ? 20
                          : 0,
                  child: _createUi(jsonResult.data!))
              : Column(children: [
                  const SizedBox(height: 50),
                  Container(
                      height: 200,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          left: 16,
                          right: 16),
                      child: Image.asset(AssetsConst.helpImg)),
                  getTxtBlackColor(
                      msg: StringConst.noDataFound,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ]);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _createUi(NowPlayingRespo data) {
    pageSize++;
    totalPages = data.totalPages!;
    dataResult.addAll(data.results!);
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: dataResult.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.only(left: 18, right: 5),
              child: getDivider());
        },
        itemBuilder: (BuildContext context, int index) {
          NowPlayResult data = dataResult[index];
          if(index%7==0){
            return BannerAdsWidget();
          } else {
            return getMovieItemRow(
              context: ctx,
              index: index,
              id: data.id!,
              img: data.posterPath.toString(),
              //"/yGSxMiF0cYuAiyuve5DA6bnWEOI.jpg",
              name: data.originalTitle!,
              desc: data.overview!,
              vote: data.voteAverage);
          }
        });
  }

  Widget getMovieItemRow(
      {required BuildContext context,
      int index = 0,
      int id = 0,
      String img = "",
      String name = "",
      String desc = "",
      var vote}) {
    String tag = StringConst.searchMovie + img + index.toString();
    return InkWell(
        onTap: () {
          navigationPush(
              context,
              DetailsMovieScreen(name, ApiConstant.imagePoster + img,
                  StringConst.searchMovie, index, id, tag));
        },
        child: Container(
            margin: const EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
            child: Hero(
                tag: tag,
                child: Row(children: <Widget>[
                  Stack(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: getCacheImage(
                              url: ApiConstant.imagePoster + img.toString(),
                              height: 120),
                        ),
                      ),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  splashColor: ColorConst.splashColor,
                                  onTap: () {
                                    navigationPush(
                                        context,
                                        DetailsMovieScreen(
                                            name,
                                            ApiConstant.imagePoster + img,
                                            StringConst.searchMovie,
                                            index,
                                            id,
                                            tag));
                                  }))),
                    ],
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        getTxtBlackColor(
                            msg: name,
                            maxLines: 1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.start),
                        getTxtGreyColor(
                            msg: desc,
                            maxLines: 5,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.start),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RatingResult(vote, 12.0),
                              const SizedBox(width: 5),
                              RatingBar.builder(
                                itemSize: 12.0,
                                initialRating:
                                    double.parse((vote / 2).toString()),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: getBackgroundRate(
                                      double.parse(vote.toString())),
                                ),
                                onRatingUpdate: (rating) {
                                  printLog(
                                      tag: runtimeType.toString(),
                                      msg: "Rating : $rating");
                                },
                              )
                            ])
                      ]))
                ]))));
  }
}
