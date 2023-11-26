import 'package:flutter/material.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/person/person_detail_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/ads/banner_widget.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/sifi_movie_row.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:shimmer/shimmer.dart';

class PersonDetail extends StatefulWidget {
  final personId;
  final imgPath;
  final tag;
  final name;

  const PersonDetail(
      {super.key, @required this.personId, this.name, this.imgPath, this.tag});

  @override
  State<PersonDetail> createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  // final personId;
  // final imgPath;
  // final tag;
  // final name;
  late MovieModel model;

  late SizingInformation sizeInfo;
  late final ScrollController scrollController = ScrollController();

  // _PersonDetailState(this.personId, this.name, this.imgPath, this.tag);

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.fetchPersonDetail(widget.personId);
    model.fetchPersonImage(widget.personId);
    model.fetchPersonMovie(widget.personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModel(model: model, child: apiResponse(context)));
  }

  Widget apiResponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.personDetailRespo;
        if (jsonResult.status == ApiStatus.success) {
          return _createUi(data: jsonResult.data);
        } else {
          return apiHandler(loading: _createUi(), response: jsonResult);
        }
      },
    );
  }

  Widget _createUi({PersonDetailRespo? data}) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConst.blackColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
    return ResponsiveBuilder(builder: (context, sizeInf) {
      sizeInfo = sizeInf;
      return Scrollbar(
        controller: scrollController,
        thumbVisibility: sizeInfo.deviceScreenType == DeviceScreenType.desktop,
        radius: const Radius.circular(5),
        thickness:
            sizeInfo.deviceScreenType == DeviceScreenType.desktop ? 20 : 0,
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
                backgroundColor: ColorConst.whiteBgColor,
                expandedHeight: 330.0,
                leading: homeIcon,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: InkWell(
                      onTap: () {
                        // model.fetchPersonMovie(personId);
                      },
                      child: getTxtBlackColor(
                          msg: widget.name,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  background: Hero(
                      tag: widget.tag,
                      child: getCacheImage(
                        url: widget.imgPath.toString(),
                      )),
                )),
            SliverList(
              delegate: SliverChildListDelegate([getContent(data)]),
            )
          ],
        ),
      );
    });
  }

  Widget getContent(PersonDetailRespo? data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        personalInfo(data),
        const SizedBox(height: 10),
        SifiMovieRow(StringConst.images, sizeInfo),
        TrandingMovieRow(
            apiName: StringConst.personMovieCrew,
            sizeInfo: sizeInfo,
            movieId: widget.personId),
        TrandingMovieRow(
            apiName: StringConst.personMovieCast,
            sizeInfo: sizeInfo,
            movieId: widget.personId),
        BannerAdsWidget()
      ],
    );
  }

  Widget personalInfo(PersonDetailRespo? data) {
    final size = MediaQuery.of(context).size;
    int yearOld = 0;
    if (data != null && (data.deathday != null || data.birthday != null)) {
      final now = data.deathday != null
          ? DateTime.parse(data.deathday).year
          : DateTime.now().year;
      yearOld = now - DateTime.parse(data.birthday!).year;
    }
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              getTxtBlackColor(
                  msg: StringConst.biography,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start),
              const SizedBox(height: 15),
              if (data != null)
                getTxtGreyColor(
                    msg: data.biography != null ? data.biography! : '',
                    fontSize: 15,
                    fontWeight: FontWeight.w400)
              else
                sizeInfo.deviceScreenType == DeviceScreenType.desktop
                    ? Container()
                    : ShimmerView.getOverView(context),
              const SizedBox(height: 15),
              BannerAdsWidget(),
              getTxtBlackColor(
                  msg: StringConst.personalInfo,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start),
              const SizedBox(height: 5),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width - 20,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            getPIDetail(
                                'Gender',
                                data != null && data.gender == 2
                                    ? 'Male'
                                    : 'Female'),
                            getPIDetail('Age', '$yearOld years old'),
                            getPIDetail(
                                'Known For', data?.knownForDepartment ?? "NA"),
                            getPIDetail(
                                'Date of Birth', data?.birthday ?? "NA"),
                            getPIDetail(
                                'Birth Place', data?.placeOfBirth ?? "NA"),
                            getPIDetail(
                                'Official Site', data?.homepage ?? "NA"),
                            getPIDetail(
                                'Also Known As',
                                data != null ? data.alsoKnownAs?.join(' , ') : null)
                          ])))
            ]));
  }

  Widget getPIDetail(String hint, String? detail) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      getTxtGreyColor(
          msg: hint ?? 'NA', fontSize: 13, textAlign: TextAlign.start),
      const SizedBox(height: 3),
      if (detail == null)
        Container(width: 150, height: 10, color: Colors.grey[300])
      else
        getTxtBlackColor(
            msg: detail ?? '-', fontSize: 16, textAlign: TextAlign.start),
      const SizedBox(height: 8),
      const Divider(height: 2),
      const SizedBox(height: 8)
    ]);
  }
}
