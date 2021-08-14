import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ShimmerView extends StatelessWidget {
  //VIEW TYPE
  static String VIEW_CASOSAL = 'VIEW_CASOSAL';
  static String VIEW_HORIZONTAL_MOVIE_LIST = 'VIEW_HORIZONTAL_MOVIE_LIST';
  static String VIEW_HORI_PERSON = 'VIEW_HORI_PERSON';
  static String VIEW_GRID_PERSON = 'VIEW_GRID_PERSON';
  static String VIEW_CATEGORY = 'VIEW_CATEGORY';

  static String VIEW_GRID_MOVIE = 'VIEW_GRID_MOVIE';
  String apiName, viewType;
  double parentHeight, height, width;
  SizingInformation sizeInfo;
  ShimmerView(this.sizeInfo,
      {this.apiName: "",
      this.viewType = "",
      this.parentHeight: 180,
      this.height: 180,
      this.width = 0});

  @override
  Widget build(BuildContext context) {
    getApiNameData(context);
    return getShimmerList();
  }

  void getApiNameData(BuildContext context) {
    // switch (apiName) {
    //   case ApiConstant.GENRES_LIST:
    //     viewType = VIEW_CATEGORY;
    //     break;
    //   case StringConst.MOVIE_CAST:
    //     viewType = VIEW_CATEGORY;
    //     break;
    // }
    if (apiName == ApiConstant.GENRES_LIST) {
      parentHeight = MediaQuery.of(context).size.height;
      viewType = VIEW_CATEGORY;
      // height = 150;
    } else if (apiName == StringConst.MOVIE_CAST ||
        apiName == StringConst.MOVIE_CREW ||
        apiName == StringConst.TRANDING_PERSON_OF_WEEK) {
      parentHeight = MediaQuery.of(context).size.height;
      viewType = VIEW_GRID_PERSON;
    } else if (apiName.length > 0) {
      parentHeight = MediaQuery.of(context).size.height;
      viewType = VIEW_GRID_MOVIE;
    }
  }

  Widget getShimmerList() {
    // viewType = VIEW_PERSON;
    return SizedBox(
      height: parentHeight,
      child:
      // Shimmer.fromColors(
      //     baseColor: Colors.grey[300],
      //     highlightColor: Colors.grey[100],
      //     enabled: true,
      //     child:
          getShimmerView()
      // ),
    );
  }

  Widget getShimmerView() {
    // print("VIEW TYPE  :============================================= " +
    //     viewType);
    if (viewType == VIEW_CASOSAL) {
      return getCarosalShimmer(false);
    } else if (viewType == VIEW_HORIZONTAL_MOVIE_LIST) {
      return getHorizMovieShimmer();
    } else if (viewType == VIEW_HORI_PERSON) {
      return getPersonHori();
    } else if (viewType == VIEW_GRID_PERSON) {
      return getPersonGrid();
    } else if (viewType == VIEW_CATEGORY) {
      return getCategoryView();
    } else if (viewType == VIEW_GRID_MOVIE) {
      return getMovieGrid();
    }else return Container();
  }

  Widget getCarosalShimmer(bool isShowTitle) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Container(
                  width: double.infinity,
                  height: height-30,
                  color: ColorConst.GREY_SHADE,
                ),
              ),
              // if (isShowTitle)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
              // if (isShowTitle)
                Container(
                  width: 150,
                  height: 10,
                  color: ColorConst.GREY_SHADE,
                ),
            ],
          ),
        ));
  }

  Widget getHorizMovieShimmer() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          movieRow(height, width),
          movieRow(height, width),
        ],
      ),
    );
  }

  Widget movieRow(double height, double width) {
    return Container(
      margin: EdgeInsets.all(5),
      width: width,
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: height,
              color: ColorConst.GREY_SHADE,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 8,
                color: ColorConst.GREY_SHADE,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 70,
                height: 8,
                color: ColorConst.GREY_SHADE,
              )),
        ],
      ),
    );
  }

  Widget getPersonHori() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          getPersonRow(),
          getPersonRow(),
          // getPersonRow(),
        ],
      ),
    );
  }

  Widget getPersonRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: width,
                  width: width,
                  color: ColorConst.GREY_SHADE,
                )),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Container(
              width: 70,
              height: 8,
              color: ColorConst.GREY_SHADE,
            )
          ],
        ),
      ),
    );
  }

  Widget getPersonGrid() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getPersonRow(),
                getPersonRow(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getPersonRow(),
                getPersonRow(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getPersonRow(),
                getPersonRow(),
              ],
            ),
          ],
        ));
  }

  Widget getCategoryView() {
    // print(
    //     "height : " + height.toString() + "  0  : " + parentHeight.toString());
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: double.infinity,
              height: height,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
          ),
          Container(
            width: 280,
            height: 8,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: double.infinity,
              height: height,
              color: Colors.white,
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 2.0),
          // ),
          // Container(
          //   width: 280,
          //   height: 8,
          //   color: Colors.white,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10.0),
          // ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(5),
          //   child: Container(
          //     width: double.infinity,
          //     height: height,
          //     color: Colors.white,
          //   ),
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 2.0),
          // ),
          // Container(
          //   width: 280,
          //   height: 8,
          //   color: Colors.white,
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10.0),
          // ),
        ],
      ),
    );
  }

  Widget getMovieGrid() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              movieRow(240, 155),
              movieRow(240, 155),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              movieRow(240, 155),
              movieRow(240, 155),
            ],
          ),
        ],
      ),
    );
  }

  static Widget movieDetailsTag() {
    return
      // Shimmer.fromColors(
      //   baseColor: Colors.grey[300],
      //   highlightColor: Colors.grey[100],
      //   enabled: true,
      //   child:
        Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    tagRow(),
                    SizedBox(width: 5),
                    tagRow(),
                    SizedBox(width: 5),
                    tagRow(),
                    // SizedBox(width: 5),
                    // tagRow()
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [tagRow(), tagRow(), tagRow()],
                ),
              ],
            ))
      // )
    ;
  }

  static Widget tagRow() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 65,
        height: 25,
        color: Colors.white,
      ),
    );
  }

  static Widget getOverView(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      // Shimmer.fromColors(
      //   baseColor: Colors.grey[300],
      //   highlightColor: Colors.grey[100],
      //   enabled: true,
      //   child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: 10,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Container(
              width: (size.width - 50),
              height: 10,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Container(
              width: (size.width - 80),
              height: 10,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
            ),
            Container(
              width: (size.width - 120),
              height: 10,
              color: Colors.white,
            ),
          ],
        )
    // )
    ;
  }
}
