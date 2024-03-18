import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies4u/data/details/movie_img_respo.dart';
import 'package:movies4u/view/ads/banner_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullImage extends StatefulWidget {
  List<Backdrops> urls;
  late final index;
  final tag;

//  FullImage({this.imageUrl, this.imageFile});
  FullImage(this.urls, this.index, this.tag, {super.key});

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  // List<Backdrops> urls;
  // var index = 0;
  // final tag;

  late PageController pageController;

  // _FullImageState(this.urls, this.index, this.tag);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.index);
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
              Center(child: BannerAdsWidget()),
              getImageView(),
              // Container(
              //   alignment: Alignment.bottomRight,
              //   padding: const EdgeInsets.all(20.0),
              //   child: Text(
              //     "Image ${widget.index + 1}",
              //     style: const TextStyle(
              //         color: Colors.white, fontSize: 17.0, decoration: null),
              //   ),
              // ),
              Positioned(
                top: 40.0,
                right: 20.0,
                child: IconButton(
                    icon: const Icon(
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

  void onPageChanged(int index) {
    setState(() {
      widget.index = index;
    });
  }

  Widget getImageView() {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
    String imgUrl = 'https://image.tmdb.org/t/p/original${widget.urls[index].filePath!}';
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(imgUrl),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2,
      heroAttributes: PhotoViewHeroAttributes(tag: widget.tag),
    );
      },
      itemCount: widget.urls.length,
      loadingBuilder: (context, event) => Center(
    child: SizedBox(
      width: 20.0,
      height: 20.0,
      child: CircularProgressIndicator(
        value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
      ),
    ),
      ),
      pageController: pageController,
//      onPageChanged: onPageChanged,
      enableRotation: true,
//      reverse: true,
    );
  }
}
