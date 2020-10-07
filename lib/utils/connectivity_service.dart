import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import '../locator.dart';
import 'no_connection_flush_bar.dart';

enum ConnectivityStatus { WiFi, MobileData, Offline }

class ConnectivityServiceController extends ChangeNotifier {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityStatus currentConnectivityStatus;

  ConnectivityServiceController() {
    // Subscribe to the connectivity Changed Stream
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t
      connectionStatusController.sink.add(_getStatusFromResult(result));
    });
  }


  @override
  void dispose() {
    connectionStatusController.close();
    return super.dispose();
  }


  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        locator<NoConnectionFlushBar>().hideNoConnectionFlushBar();
        return currentConnectivityStatus = ConnectivityStatus.MobileData;
      case ConnectivityResult.wifi:
        locator<NoConnectionFlushBar>().hideNoConnectionFlushBar();
        return currentConnectivityStatus = ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        locator<NoConnectionFlushBar>().showNoConnectionFlushBar();
        return currentConnectivityStatus = ConnectivityStatus.Offline;
        break;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
