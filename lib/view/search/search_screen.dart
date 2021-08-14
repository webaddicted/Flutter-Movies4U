import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/home/now_playing_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/details/detail_movie.dart';
import 'package:movies4u/view/widget/rating_result.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late MovieModel model;
  String query = ' ';

  late BuildContext ctx;
  List<NowPlayResult> dataResult = [];
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  int total_pages = 1;
  int pageSize = 1;

 late SizingInformation sizeInfo;
  @override
  void initState() {
    model = MovieModel();
    model.serachMovies(searchController.text.toString(), pageSize, true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0 &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        if (pageSize <= total_pages) model.serachMovies(searchController.text.toString(), pageSize, false);
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
    return Scaffold(
        // appBar: getAppBarWithBackBtn(
        //     ctx: context,
        //     title: getTitle('SearchMovie'),
        //     bgColor: ColorConst.WHITE_BG_COLOR,
        //     titleTag: 'Search mOivie',
        //     icon: homeIcon),
        body: Container(
      child: ResponsiveBuilder(builder: (context, sizeInf) {
        sizeInfo =sizeInf;
        return Column(
        children: [
          SizedBox(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?0:30),
          PreferredSize(
            child: Container(
              child: Card(
                child: TextField(
                  onChanged: (String query) {
                    pageSize = 1;
                    query = query;
                    dataResult.clear();
                    model.serachMovies(query, pageSize, true);
                  },
                  autofocus: true,
                  controller: searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: StringConst.SEARCH_MOVIE,
                      icon: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.arrow_back_ios)),
                      suffixIcon: IconButton(
                          onPressed: () => searchController.clear(),
                          icon: Icon(Icons.close_rounded))),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(80.0),
          ),
          Container(child: ScopedModel(model: model, child: apiresponse())),
        ],
      );})
    ));
    // _createUi(null));
    //
  }

  Widget apiresponse() {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.searchMovieRespo;
        if (jsonResult.status == ApiStatus.COMPLETED) {
          return jsonResult.data!.totalResults! > 0 || dataResult.length > 0
              ?  Scrollbar(
              isAlwaysShown: sizeInfo.deviceScreenType == DeviceScreenType.desktop,
              radius: Radius.circular(5),
              thickness: 20,child: SingleChildScrollView(child: _createUi(jsonResult.data!)))
              : Column(children: [
                  SizedBox(height: 50),
                  Container(
                      height: 200,
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                          left: 16,
                          right: 16),
                      child: Image.asset(AssetsConst.HELP_IMG)),
                  getTxtBlackColor(
                      msg: StringConst.NO_DATA_FOUND,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ]);
        } else
          return Container();
      },
    );
  }

  Widget _createUi(NowPlayingRespo data) {
    pageSize++;
    total_pages = data.totalPages!;
    dataResult.addAll(data.results!);
    return  ListView.separated(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: dataResult.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(left: 18, right: 5),
                child: getDivider());
          },
          itemBuilder: (BuildContext context, int index) {
            NowPlayResult data = dataResult[index];
            return getMovieItemRow(
                context: ctx,
                index: index,
                id: data.id!,
                img: data.posterPath.toString(),
                //"/yGSxMiF0cYuAiyuve5DA6bnWEOI.jpg",
                name: data.originalTitle!,
                desc: data.overview!,
                vote: data.voteAverage);
          });
  }

  Widget getMovieItemRow(
      {required BuildContext context,
      int index = 0,
      int id = 0,
      String img = "",
      String name ="",
      String desc ="",
      var vote}) {
    String tag = StringConst.SEARCH_MOVIE + img + index.toString();
    return InkWell(
      onTap: () {
        navigationPush(
            context,
            DetailsMovieScreen(name, ApiConstant.IMAGE_POSTER + img,
                StringConst.SEARCH_MOVIE, index, id, tag));
      },
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
        child: Hero(
          tag: tag,
          child: Row(
            children: <Widget>[
              Stack(
                children: [
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: ClipRRect(
                      child: getCacheImage(
                          url: ApiConstant.IMAGE_POSTER + img.toString(),
                          height: 120),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Positioned.fill(
                      child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: ColorConst.SPLASH_COLOR,
                              onTap: () {
                                navigationPush(
                                    context,
                                    DetailsMovieScreen(
                                        name,
                                        ApiConstant.IMAGE_POSTER + img,
                                        StringConst.SEARCH_MOVIE,
                                        index,
                                        id,
                                        tag));
                              }))),
                ],
              ),
              SizedBox(width: 5),
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
                        SizedBox(width: 5),
                        RatingBar.builder(
                          itemSize: 12.0,
                          initialRating: double.parse((vote / 2).toString()),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: getBackgrountRate(double.parse(vote.toString())),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
