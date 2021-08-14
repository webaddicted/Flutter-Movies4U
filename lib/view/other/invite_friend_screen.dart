import 'package:flutter/material.dart';
import 'package:movies4u/constant/assets_const.dart';
import 'package:movies4u/constant/color_const.dart';
import 'package:movies4u/constant/string_const.dart';
import 'package:share/share.dart';

class InviteFriend extends StatefulWidget {
  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Container(
      // color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          // backgroundColor: AppTheme.nearlyWhite,
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30, left: 13),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ColorConst.BLACK_COLOR,
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
                child: Image.asset(AssetsConst.INVITE_IMG),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
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
                        color: ColorConst.APP_COLOR,
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
                            final RenderObject? box =
                                _context.findRenderObject();
                            Share.share(
                                '*${StringConst.APP_NAME}*\n${StringConst.SHARE_DETAILS}\n${StringConst.PLAYSTORE_URL}');

                            // Share.share(
                            //     '*${StringConst.APP_NAME}*\n${StringConst.SHARE_DETAILS}\n${StringConst.PLAYSTORE_URL}',
                            //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                          },
                          child: Center(
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
                                  padding: const EdgeInsets.all(4.0),
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
      ),
    );
  }
}
