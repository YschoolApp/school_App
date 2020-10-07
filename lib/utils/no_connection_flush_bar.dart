import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/locator.dart';
import 'package:school_app/services/navigation_service.dart';




class NoConnectionFlushBar {
  Flushbar _flushBar;

  Flushbar get flushBar {

    if (_flushBar == null) {
      return _flushBar = Flushbar(
        messageText: Text(
          'kfWNoInternet',
//      style: kAppBarTextStyle.copyWith(
//        color: Colors.white,
//      ),
        ),
        icon: Icon(
          Icons.signal_wifi_off,
          size: 28.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        padding: EdgeInsets.all(20),
//    duration: Duration(seconds: 3),
        isDismissible: true,
        leftBarIndicatorColor: Colors.grey.shade300,
        flushbarStyle: FlushbarStyle.FLOATING,
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        flushbarPosition: FlushbarPosition.TOP,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      );
    } else {
      return _flushBar;
    }
  }

  showNoConnectionFlushBar() {
    if (flushBar.isShowing()) {
      print('FlushBar is already There');
      return;
    } else {
      flushBar.show(locator<NavigationService>().navigationKey.currentContext);
    }
  }

  hideNoConnectionFlushBar() {
    flushBar.dismiss();
  }
}