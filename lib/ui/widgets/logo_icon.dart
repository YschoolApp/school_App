import 'package:school_app/all_constants/field_name_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_app/utils/config_size.dart';


class LogoIcon extends StatelessWidget{
  final String screenName;
  final String tag;
  final String assetPath;

  const LogoIcon({this.screenName, this.tag, this.assetPath});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 25,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              //height: MediaQuery.of(context).size.height / 6,
             // height: SizeConfig.safeBlockVertical * 15,
              child: Hero(
                tag: tag,
                child:  SvgPicture.asset(
                  assetPath,
                  width: SizeConfig.safeBlockHorizontal*15,
                  height: SizeConfig.safeBlockVertical*15,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              screenName == kfSignUp
                  ? kfSignUp:kfLogIn,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
