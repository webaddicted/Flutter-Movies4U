import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/data/details/movie_img_respo.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullImage extends StatefulWidget {
  List<Backdrops> urls;
  final index;
  final tag;

//  FullImage({this.imageUrl, this.imageFile});
  FullImage(this.urls, this.index, this.tag);

  @override
  _FullImageState createState() => _FullImageState(urls, index, tag);
}

class _FullImageState extends State<FullImage> {
  List<Backdrops> urls;
  var index = 0;
  final tag;

  late PageController pageController;

  _FullImageState(this.urls, this.index, this.tag);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: InkWell(
//          onVerticalDragDown: (details) {
//            Navigator.pop(context);
//          },

          child: Stack(
            children: <Widget>[
              getImageView(),
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Image ${index + 1}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 17.0, decoration: null),
                ),
              ),
              Positioned(
                top: 40.0,
                right: 20.0,
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ));
  }

  void onPageChanged(int indexss) {
    setState(() {
      index = indexss;
    });
  }

  Widget getImageView() {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int indexss) {
        String imgurl =
            'https://image.tmdb.org/t/p/original' + urls[indexss].filePath!;
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(imgurl),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
          heroAttributes: PhotoViewHeroAttributes(tag: tag),
        );
      },
      itemCount: urls.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
      pageController: pageController,
//      onPageChanged: onPageChanged,
      enableRotation: true,
//      reverse: true,
    ));
  }
}
