import 'package:Moviesfree4U/constant/api_constant.dart';
import 'package:Moviesfree4U/constant/color_const.dart';
import 'package:Moviesfree4U/constant/string_const.dart';
import 'package:Moviesfree4U/constant/utils/widgethelper/widget_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(ApiConstant.DEMO_IMG),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getTxtWhiteColor(
                          msg: StringConst.DEEPAK_SHARMA,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      getTxtColor(
                          msg: StringConst.WEBADDICTED, txtColor: ColorConst.GREY_SHADE)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ListTile(

              title:getTxtWhiteColor(
                  msg: "Language",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              subtitle:getTxtColor(
                  msg: "English US",
                  fontSize: 15, txtColor: ColorConst.GREY_SHADE),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey.shade400,
              ),
              onTap: () {},
            ),
            ListTile(
              title:getTxtWhiteColor(
                  msg: "Profile Settings",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              subtitle:getTxtColor(
                  msg: StringConst.DEEPAK_SHARMA,
                  fontSize: 15, txtColor: ColorConst.GREY_SHADE),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey.shade400,
              ),
              onTap: () {},
            ),
            SwitchListTile(
              title: getTxtWhiteColor(
                  msg: "Email Notifications",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              subtitle: getTxtColor(
                  msg: 'On',
                  fontSize: 15, txtColor: ColorConst.GREY_SHADE),
              value: true,
              onChanged: (val) {},
            ),
            SwitchListTile(
              title: Text(
                "Push Notifications",
                // style: whiteBoldText,
              ),
              subtitle: getTxtColor(
                  msg: 'Off',
                  fontSize: 15, txtColor: ColorConst.GREY_SHADE),
              value: false,
              onChanged: (val) {},
            ),
            ListTile(
              title:getTxtWhiteColor(
                  msg: "Logout",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
