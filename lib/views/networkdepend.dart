import 'package:artsvalley/enum/connectivityStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NetworkDepend extends StatefulWidget {
  final Widget child;


  const NetworkDepend({ this.child});

  @override
  _NetworkDependState createState() => _NetworkDependState();
}

class _NetworkDependState extends State<NetworkDepend> {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi ||
        connectionStatus == ConnectivityStatus.Celluar_data) {
      return widget.child;
    }
    /* if (connectionStatus == ConnectivityStatus.Offline) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Network Lost !!"),
          centerTitle: true,
        ),
        body: 
      );
    } */
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              title: Text(
                "Network Connection Lost !!  ",
                textAlign: TextAlign.center,
              ),
              content: Text('Please check your network connection !!'),
            ),
            
          ],
        );
  }
}
