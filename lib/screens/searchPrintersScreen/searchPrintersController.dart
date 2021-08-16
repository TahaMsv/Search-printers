import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:get/get.dart';
import '../../global/MainController.dart';
import '../../global/MainModel.dart';
import '../../widgets/ping_discover_network/ping_discover_network.dart';
import 'package:wifi/wifi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';

class SearchPrintersController extends MainController {
  SearchPrintersController._();

  static final SearchPrintersController _instance =
      SearchPrintersController._();

  factory SearchPrintersController(MainModel model) {
    _instance.model = model;
    return _instance;
  }

  TextEditingController textController = new TextEditingController();
  TextEditingController portTEController = new TextEditingController();
  TextEditingController ipTEController = new TextEditingController();
  RxBool isLoading = false.obs;
  Rx<ButtonState> isConnectToIP = ButtonState.idle.obs;
  RxList<Socket> connectedIPs = <Socket>[].obs;

  Future<String> _getSubnet(String ip) {
    String subnet = ip.substring(0, ip.lastIndexOf("."));
    return Future<String>.value(subnet);
  }

  Future<int> _getPort() {
    String port = portTEController.text;
    if (port != "") return Future<int>.value(int.parse(port));
    return Future<int>.value(9100);
  }

  Future<String> _getIP() {
    String ip = ipTEController.text;
    return Future<String>.value(ip);
  }

  Future<bool> checkWifiConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return Future<bool>.value(connectivityResult == ConnectivityResult.wifi);
  }

  void connectToIP() async {
    if (isConnectToIP.value != ButtonState.loading) {
      bool isWifiConnected = await checkWifiConnection();
      isConnectToIP.value = ButtonState.loading;
      if (isWifiConnected) {
        String ip = await _getIP();
        int port = await _getPort();
        String message = "";
        Duration timeout = const Duration(seconds: 5);
        await Socket.connect(ip, port, timeout: timeout).then((Socket sock) {
          message = "connected";
        }).catchError((Object e) {
          message = "Failed";
          // print("Unable to connect: $e");
        });

        isConnectToIP.value =
            message == "connected" ? ButtonState.success : ButtonState.fail;
        showToast(message, Colors.blue, Colors.white);
      } else {
        Timer(Duration(seconds: 6), () {
          showToast("Wifi connection failed", Colors.redAccent, Colors.white);
          isConnectToIP.value = ButtonState.idle;
        });
      }
    }
  }

  void searchIPs() async {
    if (!isLoading.value) {
      isLoading.value = true;
      connectedIPs.clear();
      bool isWifiConnected = await checkWifiConnection();
      if (isWifiConnected) {
        final String ip = await Wifi.ip;
        final String subnet = await _getSubnet(ip);
        int port = await _getPort();
        final stream = NetworkAnalyzer.discover2(subnet, port);
        stream.listen((NetworkAddress addr) {
          if (addr.exists) {
            // print('Found device: ${addr.ip}');
            runZoned(() async {
              await Socket.connect(addr.ip, port).then((Socket sock) {
                connectedIPs.add(sock);
              }).catchError((Object e) {
                // print("Unable to connect: $e");
              });
            });
          }
        });
        Timer(Duration(seconds: 6), () {
          int numberOfFoundedDevice = connectedIPs.length;
          showToast("$numberOfFoundedDevice devices found", Colors.blue,
              Colors.white);
          isLoading.value = false;
        });
      } else {
        showToast("Wifi connection failed", Colors.redAccent, Colors.white);
        isLoading.value = false;
      }

    }
  }

  void sendMessage() {
    String? message = textController.text;
    if (message != "") {
      for (int i = 0; i < connectedIPs.length; i++) {
        connectedIPs[i].writeln(message);
      }
    }
    textController.text = "";
  }

  void showToast(String message, Color bgColor, textColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
  }

  void showLogDialog() {
    String message = NetworkAnalyzer.getSortedLogMessage();
    double screenHeight = Get.height;
    double screenWidth = Get.width;
    BuildContext? context = Get.context;
    showDialog(
        context: context!,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 15, right: 15),
            title: Center(child: Text("Information")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: screenHeight * 0.8,
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      message,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.20,
                    child: RaisedButton(
                      child: new Text(
                        'Ok',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xFF121A21),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        //saveIssue();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  void onInit() {
    print("Search printer Init");
    super.onInit();
  }

  Future<void> initializeFlutterFire() async {}

  Future<void> initializeRoute() async {}

  Future<void> initializePreferencesSettings() async {}

  Future<void> initializeLocalNotification() async {}
}
