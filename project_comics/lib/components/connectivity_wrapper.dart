import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  ConnectivityWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkInternetConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is running, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == false) {
          // If there's an error or no internet connection, show an error message
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade800,
              title: const Padding(
                padding: EdgeInsets.only(left: 50.0),
                child: Text(
                  'No Internet Connection',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              elevation: 0,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Please check your internet connection',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else {
          // If there's an internet connection, show the child widget
          return child;
        }
      },
    );
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
}
