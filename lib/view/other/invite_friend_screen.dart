import 'package:flutter/material.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});
  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: AppTheme.nearlyWhite,
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 30, left: 13),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ColorConst.blackColor,
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 16,
                  right: 16),
              child: Image.asset(AssetsConst.inviteImg),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: const Text(
                'Invite Your Friends',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: const Text(
                'Are you one of those who makes everything\n at the last moment?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorConst.appColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Share.share(
                              '*${StringConst.appName}*\n${StringConst.shareDetails}\n${StringConst.playstoreUrl}');
                          // Share.share(
                          //     '*${StringConst.APP_NAME}*\n${StringConst.SHARE_DETAILS}\n${StringConst.PLAYSTORE_URL}',
                          //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                        },
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 22,
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Share',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
