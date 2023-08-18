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
  const MovieLikeScreen({super.key});

  @override
  State<MovieLikeScreen> createState() => _MovieLikeScreenState();
}

class _MovieLikeScreenState extends State<MovieLikeScreen> {
  static final Map<int, bool> _movieGenres = <int, bool>{};
  static final Map<int, bool> _tvGenres = <int, bool>{};
  static PageController pageController = PageController();

  static late BuildContext ctx;


  @override
  void initState() {
    super.initState();
    for (var e in movieList.keys) {_movieGenres[e] = false;}
    for (var e in tvList.keys) {_tvGenres[e] = false;}
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);
    ctx = context;
    return Scaffold(
        body: PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
          duration: const Duration(milliseconds: 400), curve: Curves.ease),
    ),
    _SubscribeTopicPage(
        title: StringConst.movieDoYouLike,
        buttonTitle: 'Next',
        tag: 'movie_',
        isMovie: true,
        genres: _movieGenres,
        backTapped: () => pageController.previousPage(
            duration: const Duration(milliseconds: 400), curve: Curves.ease),
        nextTapped: () {
          pageController.nextPage(
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        }),
    _SubscribeTopicPage(
        title: StringConst.tvDoYouLike,
        buttonTitle: 'Start',
        tag: 'tvshow_',
        isMovie: false,
        genres: _tvGenres,

        backTapped: () => pageController.previousPage(
            duration: const Duration(milliseconds: 400), curve: Curves.ease),
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
        color: ColorConst.whiteBgColor,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                const SizedBox(height: 20),
                SizedBox(
                    width: 280,
                    height: 250, //Adapt.px(500),
                    child: Image.asset(AssetsConst.movieIcon)),
                getTxtBlackColor(
                    msg: 'welcome',
                    fontSize: 30,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700),
                const SizedBox(height: 5),
                getTxtBlackColor(
                    msg: 'let start with few steps',
                    fontSize: 20,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: getTxtBlackColor(
                      msg: StringConst.dummyTextShort,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 100),
                InkWell(
                    onTap: (){continueTapped();},
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        decoration: BoxDecoration(
                            color: ColorConst.appColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: getTxtColor(
                              msg: 'continue',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              txtColor: ColorConst.whiteOrigColor),
                        ))),
                const SizedBox(height: 40)
              ]),
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

  const _SubscribeTopicPage(
      {this.backTapped,
      this.nextTapped,
      this.genres,
      this.isMovie,
      @required this.title,
      @required this.buttonTitle,
      this.tag});

  @override
  State<_SubscribeTopicPage> createState() => _SubscribeTopicPageState();
}

class _SubscribeTopicPageState extends State<_SubscribeTopicPage> {
  final List<ItemLike> _genres = <ItemLike>[];

  late SizingInformation sizeInfo;

  @override
  void initState() {
    final genresMap = (widget.isMovie!) ? movieList : tvList;
    genresMap.forEach((key, value) {
      _genres.add(ItemLike.fromParams(name: value, value: key));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeInf) {
      sizeInfo =sizeInf;
      return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const SizedBox(height: 30),
    Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: getTxtBlackColor(
            msg: widget.title!,
            fontSize: 28,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700)),
    SizedBox(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?30:30),
    Expanded(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Wrap(
              direction: Axis.vertical,
              runSpacing: sizeInfo.deviceScreenType == DeviceScreenType.desktop?30:20,
              spacing: sizeInfo.deviceScreenType == DeviceScreenType.desktop?20:20,
              children: _genres.map<Widget>((d) {
                final index = _genres.indexOf(d);
                bool selected = widget.genres![d.value]!;
                return InkWell(
                    key: ValueKey(d.name),
                    onTap: () {
                      selected = !selected;
                      widget.genres![d.value] = selected;
                      setState(() {});
                    },
                    child: Container(
                      width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?150:120,
                      height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?150:120,
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          top: (index + 4) % 8 == 0 ?(sizeInfo.deviceScreenType == DeviceScreenType.desktop?100:80) : 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? ColorConst.appColor
                            : const Color(0xFFF0F0F0),
                      ),
                      child: Center(
                          child: getTxtColor(
                              msg: d.name!,
                              fontSize: sizeInfo.deviceScreenType == DeviceScreenType.desktop?28:16,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              txtColor: selected ? const Color(0xFFFFFFFF) : const Color(0xff0000000))),
                    ));
              }).toList()
                ..add(SizedBox(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?900:900, width:sizeInfo.deviceScreenType == DeviceScreenType.desktop?40:40))
                ..insert(0,
                    SizedBox(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?900:900, width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?40:40)),
            ))),
    Row(children: [
      const SizedBox(width: 50),
      InkWell(
          onTap: (){widget.backTapped!();},
          child: SizedBox(
              width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?200:80,
              height:sizeInfo.deviceScreenType == DeviceScreenType.desktop?50:80,
              child: Center(
                  child: getTxtBlackColor(
                      msg: 'Back',
                      fontSize: 18,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w600)))),
      const Expanded(child: SizedBox()),
      InkWell(
          onTap: () async {
            widget.nextTapped!();
          },
          child: Container(
            width: sizeInfo.deviceScreenType == DeviceScreenType.desktop?250:100,
            margin: const EdgeInsets.symmetric(horizontal:40),
            height: 50,
            decoration: BoxDecoration(
                color: const Color(0xFF202F39),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: getTxtColor(
                    msg: widget.buttonTitle!,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    txtColor: ColorConst.whiteOrigColor)),
          )),
    ]),
    SizedBox(height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?30:20)
      ]),
    );});
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
