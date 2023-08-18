import 'package:flutter/material.dart';
import 'package:movies4u/constant/api_constant.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:movies4u/utils/widgethelper/widget_helper.dart';

class ProfileScreen extends StatelessWidget {
  late BuildContext _context;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeIcon = IconButton(
        icon: Icon(
          Icons.arrow_back_ios, //menu,//dehaze,
          color: ColorConst.whiteOrigColor,
        ),
        onPressed: () => Navigator.of(_context).pop());
    return Scaffold(
        backgroundColor: ColorConst.whiteBgColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: homeIcon,
        ),
        body: Builder(
          builder: (context) => _createUi(context),
        ));
  }

  Widget _createUi(BuildContext context) {
    _context = context;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          ProfileHeader(
            avatar: NetworkImage(ApiConstant.demoImg),
            coverImage: NetworkImage(ApiConstant.demoImg),
            title: StringConst.deepakSharma,
            subtitle: StringConst.webaddicted,
            actions: <Widget>[
              MaterialButton(
                color: ColorConst.blackColor,
                shape: const CircleBorder(),
                elevation: 0,
                child: Icon(Icons.edit, color: ColorConst.whiteColor,),
                onPressed: () => showSnackBar(_context, 'Comming Soon'),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          const UserInfo(),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: ColorConst.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: getTxt(msg: "Email"),
                            subtitle:
                                getTxt(msg: "deepaksharma040695@gmail.com"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.phone),
                            title: getTxt(msg: "Phone"),
                            subtitle: getTxt(msg: "+91-9024****07"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.my_location),
                            title: getTxt(msg: "Location"),
                            subtitle: getTxt(msg: "Noida, India"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.web),
                            title: getTxt(msg: "Website"),
                            subtitle: getTxt(
                                msg: "https://www.github.com/webaddicted"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.calendar_view_day),
                            title: getTxt(msg: "Joined Date"),
                            subtitle: getTxt(msg: "21 January 2016"),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: getTxt(msg: "About Me"),
                            subtitle: getTxt(
                                msg:
                                    "This is a about me link and you can khow about me in this section."),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final  coverImage;
  final  avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {super.key,
      required this.coverImage ,
      required this.avatar,
      required this.title,
      this.subtitle = "",
      required this.actions});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 250,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(

          width: double.infinity,
          margin: const EdgeInsets.only(top: 210),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: Colors.grey.shade300,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              getTxtBlackColor(
                msg: title,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                getTxtColor(
                    msg: subtitle, fontSize: 17, txtColor: ColorConst.grey800),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

   const Avatar(
      {super.key,
      this.image,
      this.borderColor = Colors.grey,
      required this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
