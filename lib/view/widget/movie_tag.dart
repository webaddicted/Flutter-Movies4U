import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/details/movie_details_respo.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/listing/movie_list_screen.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MovieTag extends StatelessWidget {
  const MovieTag( {super.key,
    required List<Genres>? items,
    required SizingInformation sizes,
    Color textColor =ColorConst.appColor,
     Color borderColor=ColorConst.appColor,
  })  :
  _items = items,
        sizeInfo=sizes,
        _textColor = textColor,
        _borderColor = borderColor;

  final List<Genres>? _items;
  final Color _textColor;
  final Color _borderColor;
  final SizingInformation sizeInfo;
  @override
  Widget build(BuildContext context) {
    if (_items == null) {
      // return  ShimmerView.movieDetailsTag();
      return  sizeInfo.deviceScreenType == DeviceScreenType.desktop?Container():ShimmerView.movieDetailsTag();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Tags(
          itemCount: _items!.length, // required
          itemBuilder: (int index) {
            final item = _items![index];
            return buildTag(text: item.name!,onclick: (){
              navigationPush(
                  context,
                  MovieListScreen(
                      apiName: StringConst.movieCategory,
                      dynamicList: item.name!,
                      movieId: item.id!));
            });
            ItemTags(
                // key: Key(index.toString()),
                index: index,
                // required
                title: item.name!,
                color: ColorConst.whiteColor,
                active: false,
                textStyle: const TextStyle(fontSize: 12),
                elevation: 0,
                textColor: ColorConst.appColor,
                border: Border.all(
                  color: ColorConst.appColor,
                ),
                onLongPressed: null,
                onPressed: (datte) => navigationPush(
                    context,
                    MovieListScreen(
                        apiName: StringConst.movieCategory,
                        dynamicList: item.name!,
                        movieId: item.id!)));
          },
        ),
      );
    }
  }

  Widget buildTag({String text = "", Color shade200 = ColorConst.appColor, required Function onclick}) {
    return InkWell(
      onTap: (){onclick();},
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15.0,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: shade200),
        child: Text(text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
