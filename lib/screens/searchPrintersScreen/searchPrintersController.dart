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

  String _getIPRange(String ip) {
    String ipRange = ip.substring(0, ip.lastIndexOf(".") + 1);
    return ipRange;
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

  void connectToIP() async {
    isConnectToIP.value = ButtonState.loading;
    isConnectToIP.refresh();
    String ip = await _getIP();
    int port = await _getPort();
    String message = "";
    print(ip);
    print(port);
    print("here");
    await Socket.connect(ip, port).then((Socket sock) {
      message = "connected";
      isConnectToIP.value = ButtonState.success;
    }).catchError((Object e) {
      message = "Failed";
      isConnectToIP.value = ButtonState.fail;
      // print("Unable to connect: $e");
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void searchIPs() async {
    isLoading.value = true;
    isLoading.refresh();
    await newMethod();
    Timer(Duration(seconds: 6), () {
      int numberOfFoundedDevice = connectedIPs.length;
      Fluttertoast.showToast(
          msg: "$numberOfFoundedDevice devices found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoading.value = false;
      isLoading.refresh();
    });
  }

  Future<void> newMethod() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    int port = await _getPort();
    connectedIPs.clear();
    final stream = NetworkAnalyzer.discover2(subnet, port);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
        runZoned(() async {
          await Socket.connect(addr.ip, port).then((Socket sock) {
            connectedIPs.add(sock);
          }).catchError((Object e) {
            // print("Unable to connect: $e");
          });
        });
      }
    });
    connectedIPs.refresh();
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

  @override
  void onInit() {
    print("Splash Init");
    super.onInit();
  }

  Future<void> initializeFlutterFire() async {}

  Future<void> initializeRoute() async {}

  Future<void> initializePreferencesSettings() async {}

  Future<void> initializeLocalNotification() async {}
}
