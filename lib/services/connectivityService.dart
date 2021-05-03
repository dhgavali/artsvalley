import 'dart:async';

import 'package:artsvalley/enum/connectivityStatus.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

class ConnectivityService {

  StreamController<ConnectivityStatus> connectivityStatusController = StreamController<ConnectivityStatus>();


  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //converted this result to enums 
      var connectionStatus = _getStatusFromResult(result);


      //emiting over the stream
      connectivityStatusController.add(connectionStatus);
      

    });
  }


  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Celluar_data;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;

      default:
        return ConnectivityStatus.Offline;
    }
  }
}
