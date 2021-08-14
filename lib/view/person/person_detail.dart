import 'package:flutter/material.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/data/person/person_detail_respo.dart';
import 'package:movies4u/model/movie_model.dart';
import 'package:movies4u/utils/apiutils/api_response.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';
import 'package:movies4u/view/widget/shimmer_view.dart';
import 'package:movies4u/view/widget/sifi_movie_row.dart';
import 'package:movies4u/view/widget/tranding_movie_row.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scoped_model/scoped_model.dart';
// import 'package:shimmer/shimmer.dart';

class PersonDetail extends StatefulWidget {
  final id;
  final imgPath;
  final tag;
  final name;

  PersonDetail({@required this.id, this.name, this.imgPath, this.tag});

  @override
  _PersonDetailState createState() =>
      _PersonDetailState(id, name, imgPath, tag);
}

class _PersonDetailState extends State<PersonDetail> {
  final personId;
  final imgPath;
  final tag;
  final name;
  late MovieModel model;

  late SizingInformation sizeInfo;

  _PersonDetailState(this.personId, this.name, this.imgPath, this.tag);

  @override
  void initState() {
    super.initState();
    model = MovieModel();
    model.fetchPersonDetail(personId);
    model.fetchPersonImage(personId);
    model.fetchPersonMovie(personId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModel(model: model, child: apiresponse(context)));
  }

  Widget apiresponse(BuildContext context) {
    return ScopedModelDescendant<MovieModel>(
      builder: (context, _, model) {
        var jsonResult = model.personDetailRespo;
        if (jsonResult.status == ApiStatus.COMPLETED) {
          return _createUi(data: jsonResult.data);
        } else
          return apiHandler(loading: _createUi(), response: jsonResult);
      },
    );
  }

  Widget _createUi({PersonDetailRespo? data}) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: ColorConst.BLACK_COLOR,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
    return Container(child: ResponsiveBuilder(builder: (context, sizeInf) {
      sizeInfo = sizeInf;
      return  Scrollbar(
        isAlwaysShown: sizeInfo.deviceScreenType == DeviceScreenType.desktop,
        radius: Radius.circular(5),
        thickness: 20,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                backgroundColor: ColorConst.WHITE_BG_COLOR,
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
                          msg: name, fontWeight: FontWeight.bold, fontSize: 16)),
                  background: Hero(
                      tag: tag,
                      child: getCacheImage(
                        url: imgPath.toString(),
                      )),
                )),
            SliverList(
              delegate: SliverChildListDelegate([getContent(data)]),
            )
          ],
        ),
      );
    }));
  }

  Widget getContent(PersonDetailRespo? data) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          personalInfo(data),
          SizedBox(height: 10),
          SifiMovieRow(StringConst.IMAGES, sizeInfo),
          TrandingMovieRow(
              apiName: StringConst.PERSON_MOVIE_CREW,
              sizeInfo: sizeInfo,
              movieId: personId),
          TrandingMovieRow(
              apiName: StringConst.PERSON_MOVIE_CAST,
              sizeInfo: sizeInfo,
              movieId: personId)
        ],
      ),
    );
  }

  Widget personalInfo(PersonDetailRespo? data) {
    final size = MediaQuery.of(context).size;
    int yearold = 0;
    if (data != null && (data.deathday != null || data.birthday != null)) {
      final _now = data.deathday != null
          ? DateTime.parse(data.deathday).year
          : DateTime.now().year;
      yearold = _now - DateTime.parse(data.birthday!).year;
    }
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          getTxtBlackColor(
              msg: StringConst.BIOGRAPHY,
              fontSize: 23,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.start),
          SizedBox(height: 15),
          if (data != null)
            getTxtGreyColor(
                msg: data.biography != null ? data.biography! : '',
                fontSize: 15,
                fontWeight: FontWeight.w400)
          else
            sizeInfo.deviceScreenType == DeviceScreenType.desktop
                ? Container()
                : ShimmerView.getOverView(context),
          SizedBox(height: 15),
          getTxtBlackColor(
              msg: StringConst.PERSONAL_INFO,
              fontSize: 23,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.start),
          SizedBox(height: 5),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              padding: EdgeInsets.all(10),
              width: size.width - 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getPIDetail('Gender',
                      data != null && data.gender == 2 ? 'Male' : 'Female'),
                  getPIDetail('Age', '$yearold years old'),
                  getPIDetail('Known For',
                      data != null ? data.knownForDepartment : null),
                  getPIDetail(
                      'Date of Birth', data != null ? data.birthday : null),
                  getPIDetail(
                      'Birth Place', data != null ? data.placeOfBirth : null),
                  getPIDetail(
                      'Official Site', data != null ? data.homepage : null),
                  getPIDetail('Also Known As',
                      data != null ? data.alsoKnownAs?.join(' , ') : null),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getPIDetail(String hint, String? detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTxtGreyColor(
            msg: hint != null ? hint : '',
            fontSize: 13,
            textAlign: TextAlign.start),
        SizedBox(height: 3),
        if (detail == null)
          Container(
            width: 150,
            height: 10,
            color: Colors.grey[300],
          )
        else
          getTxtBlackColor(
              msg: detail != null ? detail : '-',
              fontSize: 16,
              textAlign: TextAlign.start),
        SizedBox(height: 8),
        Divider(height: 2),
        SizedBox(height: 8),
      ],
    );
  }
}
