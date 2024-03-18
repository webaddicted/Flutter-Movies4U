import 'package:flutter/material.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/data/details/video_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/home/home_screen.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:movies4u/view/widget/video_player.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoView extends StatelessWidget {
  final apiName;
  SizingInformation sizeInfo;
  VideoView(this.apiName, this.sizeInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: apiResponse(context)); //getTradingList(context);
  }

  Widget apiResponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.getMovieVideo;
        if (jsonResult.status == ApiStatus.success) {
          return jsonResult.data!.results!.isNotEmpty
              ? getVideoTrailor(context, jsonResult.data!.results!)
              : Container();
        } else {
          return apiHandler(loading: ShimmerView(
              sizeInfo,viewType: ShimmerView.viewCasosal),response: jsonResult);
        }
      },
    );
  }

  Widget getVideoTrailor(BuildContext context, List<Results> results) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        getHeading(context: context, apiName: apiName, isShowViewAll: false),
        const SizedBox(height: 10),
        SizedBox(
          height: sizeInfo.deviceScreenType == DeviceScreenType.desktop ? 380:190,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              var item = results[index];
              return SizedBox(
                width: size.width - 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: getTitle(apiName) + index.toString(),
                        child: Stack(
                            children: [
                              SizedBox(
                                height: sizeInfo.deviceScreenType == DeviceScreenType.desktop?300:150,
                                width: size.width - 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://i.ytimg.com/vi/${item.key}/hqdefault.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: ColorConst.whiteOrigColor,
                                  size: 50.0,
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
                                                VideoPlayerScreen(
                                                  controller:
                                                  YoutubePlayerController(
                                                    initialVideoId: item.key!,
                                                    flags: const YoutubePlayerFlags(
                                                      autoPlay: true,
//                  mute: true,
                                                    ),
                                                  ),
                                                ));
                                          }))),
                            ],
                          ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: getTxtBlackColor(
                              msg: item.name!,
                              fontSize: 15,
                              maxLines: 1,
                              fontWeight: FontWeight.w700)),
                    ],
                  )),

              );
            },
          ),
        ),
      ],
    );
  }
}
