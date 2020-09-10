import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constant/api_constant.dart';
import 'package:flutter_movie_app/constant/string_const.dart';
import 'package:flutter_movie_app/data/home/movie_cat_respo.dart';
import 'package:flutter_movie_app/model/movie_model.dart';
import 'package:flutter_movie_app/utils/apiutils/api_response.dart';
import 'package:flutter_movie_app/utils/global_utility.dart';
import 'package:flutter_movie_app/utils/widgethelper/widget_helper.dart';
import 'package:flutter_movie_app/view/details/movie_list_screen.dart';
import 'package:flutter_movie_app/view/widget/shimmer_view.dart';
import 'package:flutter_movie_app/view/widget/tranding_movie_row.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieCate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: apiresponse(context));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieCat;
        if (jsonResult.status == ApiStatus.COMPLETED)
          return getCate(context, jsonResult.data.genres);
        else
          return apiHandler(loading: ShimmerView(viewType: ShimmerView.VIEW_CATEGORY, parentHeight:150,height: 100,width: 110 ,),response: jsonResult);
      },
    );
  }

  Widget getCate(BuildContext context, List<Genres> genres) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        getHeading(context: context, apiName: ApiConstant.GENRES_LIST),
        SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                itemBuilder: (BuildContext context, int index) {
                  return getCatRow(context,index, genres[index]);
                }),
          ),
        ),
      ],
    );
  }

  Widget getCatRow(BuildContext context,int index, Genres item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                loadCircleCacheImg(getCategoryMovie()[index], 100),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                //   child: Container(
                //     height: 100,
                //     width: 100,
                //     color: ColorConst.BLACK_FADE,
                //   ),
                // ),
                Positioned.fill(
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Colors.redAccent,
                            onTap: () {
                              navigationPush(
                                  context,
                                  MovieListScreen(
                                      apiName: StringConst.MOVIE_CATEGORY,
                                      dynamicList: item.name,
                                      movieId: item.id));
                            }))),
              ],
            ),
            getTxtBlackColor(msg: item.name, fontWeight: FontWeight.w700)
          ],
        ),
      ),
    );
  }
}
