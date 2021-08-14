import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/sp/sp_manager.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/home/home_screen.dart';
import 'package:movies4u/view/likemovie/adapt.dart';
import 'package:movies4u/view/likemovie/item_like.dart';
import 'package:movies4u/view/likemovie/keepalive_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MovieLikeScreen extends StatefulWidget {
  @override
  _MovieLikeScreenState createState() => _MovieLikeScreenState();
}

class _MovieLikeScreenState extends State<MovieLikeScreen> {
  static Map<int, bool> _movieGenres = Map<int, bool>();
  static Map<int, bool> _tvGenres = Map<int, bool>();
  static PageController pageController = new PageController();

  static late BuildContext ctx;


  @override
  void initState() {
    super.initState();
    movieList.keys.forEach((e) => _movieGenres[e] = false);
    tvList.keys.forEach((e) => _tvGenres[e] = false);
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);
    ctx = context;
    return Scaffold(
        body: PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      allowImplicitScrolling: false,
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return _buildPage(pages[index]);
      },
    ));
  }

  Widget _buildPage(Widget page) {
      return KeepAliveWidget(page);
  }

  final pages = [
    _FirstPage(
      continueTapped: () => pageController.nextPage(
          duration: Duration(milliseconds: 400), curve: Curves.ease),
    ),
    _SubscribeTopicPage(
        title: StringConst.MOVIE_DO_YOU_LIKE,
        buttonTitle: 'next',
        tag: 'movie_',
        isMovie: true,
        genres: _movieGenres,
        backTapped: () => pageController.previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.ease),
        nextTapped: () {
          pageController.nextPage(
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        }),
    _SubscribeTopicPage(
        title: StringConst.TV_DO_YOU_LIKE,
        buttonTitle: 'start',
        tag: 'tvshow_',
        isMovie: false,
        genres: _tvGenres,

        backTapped: () => pageController.previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.ease),
        nextTapped: () {
          SPManager.setOnboarding(true);
          navigationPushReplacement(ctx, HomeScreen());
        },
      ),
  ];
}

class _FirstPage extends StatelessWidget {
  final Function continueTapped;

  const _FirstPage({required this.continueTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConst.WHITE_BG_COLOR,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(children: [
                  SizedBox(height: 20),
                  SizedBox(
                      width: 280,
                      height: 250, //Adapt.px(500),
                      child: Image.asset(AssetsConst.MOVIE_ICON)),
                  getTxtBlackColor(
                      msg: 'welcome',
                      fontSize: 30,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700),
                  SizedBox(height: 5),
                  getTxtBlackColor(
                      msg: 'let start with few steps',
                      fontSize: 20,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: getTxtBlackColor(
                        msg: StringConst.DUMMY_TEXT_SHORT,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 100),
                  InkWell(
                      onTap: (){continueTapped();},
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          height: 50,
                          decoration: BoxDecoration(
                              color: ColorConst.APP_COLOR,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: getTxtColor(
                                msg: 'continue',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                txtColor: ColorConst.WHITE_ORIG_COLOR),
                          ))),
                  SizedBox(height: 40)
                ]),
              ),
            ),
          ),
        ));
  }
}

class _SubscribeTopicPage extends StatefulWidget {
  final String? title;
  final String? buttonTitle;
  final bool? isMovie;
  final String? tag;
  final Function? backTapped;
  final Function? nextTapped;
  final Map<int, bool>? genres;

  _SubscribeTopicPage(
      {this.backTapped,
      this.nextTapped,
      this.genres,
      this.isMovie,
      @required this.title,
      @required this.buttonTitle,
      this.tag});

  @override
  _SubscribeTopicPageState createState() => _SubscribeTopicPageState();
}

class _SubscribeTopicPageState extends State<_SubscribeTopicPage> {
  final List<ItemLike> _genres = <ItemLike>[];

  late SizingInformation sizeInfo;

  @override
  void initState() {
    final _genresMap = (widget.isMovie!) ? movieList : tvList;
    _genresMap.forEach((key, value) {
      _genres.add(ItemLike.fromParams(name: value, value: key));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ResponsiveBuilder(builder: (context, sizeInf) {
      sizeInfo =sizeInf;
      return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 30),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: getTxtBlackColor(
                msg: widget.title!,
                fontSize: 28,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700)),
        SizedBox(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?30:30),
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Wrap(
                  direction: Axis.vertical,
                  runSpacing: sizeInfo.deviceScreenType == DeviceScreenType.desktop?30:20,
                  spacing: sizeInfo.deviceScreenType == DeviceScreenType.desktop?20:20,
                  children: _genres.map<Widget>((d) {
                    final _index = _genres.indexOf(d);
                    bool _selected = widget.genres![d.value]!;
                    return InkWell(
                        key: ValueKey(d.name),
                        onTap: () {
                          _selected = !_selected;
                          widget.genres![d.value] = _selected;
                          setState(() {});
                        },
                        child: Container(
                          width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?150:120,
                          height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?150:120,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                              top: (_index + 4) % 8 == 0 ?(sizeInfo.deviceScreenType == DeviceScreenType.desktop?100:80) : 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selected
                                ? ColorConst.APP_COLOR
                                : const Color(0xFFF0F0F0),
                          ),
                          child: Center(
                              child: getTxtColor(
                                  msg: d.name!,
                                  fontSize: sizeInfo.deviceScreenType == DeviceScreenType.desktop?28:16,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w700,
                                  txtColor: _selected
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFF0000000))),
                        ));
                  }).toList()
                    ..add(Container(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?900:900, width:sizeInfo.deviceScreenType == DeviceScreenType.desktop?40:40))
                    ..insert(0,
                        Container(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?900:900, width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?40:40)),
                ))),
        Row(children: [
          SizedBox(width: 50),
          InkWell(
              onTap: (){widget.backTapped!();},
              child: SizedBox(
                  width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?200:80,
                  height:sizeInfo.deviceScreenType == DeviceScreenType.desktop?50:80,
                  child: Center(
                      child: getTxtBlackColor(
                          msg: 'back',
                          fontSize: 20,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700)))),
          Expanded(child: SizedBox()),
          InkWell(
              onTap: () async {
                widget.nextTapped!();
              },
              child: Container(
                width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?250:100,
                margin: EdgeInsets.symmetric(horizontal:40),
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFF202F39),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: getTxtColor(
                        msg: widget.buttonTitle!,
                        fontSize: 20,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w700,
                        txtColor: ColorConst.WHITE_ORIG_COLOR)),
              )),
        ]),
        SizedBox(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?30:20)
      ]),
    );}));
  }
}

final Map<int, String> tvList = {
  14: "Fantasy",
  16: "Animation",
  18: "Drama",
  27: "Horror",
  28: "Action",
  35: "Comedy",
  36: "History",
  37: "Western",
  53: "Thriller",
  80: "Crime",
  99: "Documentary",
  878: "Science_Fiction",
  9648: "Mystery",
  10402: "Music",
  10751: "Family",
  10759: "Action_Adventure",
  10762: "Kids",
  10763: "News",
  10764: "Reality",
  10765: "Sci-Fi_Fantasy",
  10766: "Soap",
  10767: "Talk",
  10768: "War_Politics",
};

final Map<int, String> movieList = {
  12: "Adventure",
  14: "Fantasy",
  16: "Animation",
  18: "Drama",
  27: "Horror",
  28: "Action",
  35: "Comedy",
  36: "History",
  37: "Western",
  53: "Thriller",
  80: "Crime",
  99: "Documentary",
  878: "Science_Fiction",
  9648: "Mystery",
  10402: "Music",
  10749: "Romance",
  10751: "Family",
  10752: "War",
  10762: "Kids",
  10763: "News",
  10764: "Reality",
  10766: "Soap",
  10767: "Talk",
  10770: "TV_Movie",
};
