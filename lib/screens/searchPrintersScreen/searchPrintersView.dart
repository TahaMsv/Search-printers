import 'dart:async';
import 'dart:io';
import '../../global/MainModel.dart';
import '../../screens/searchPrintersScreen/searchPrintersController.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_state_button/progress_button.dart';

class SearchPrintersView extends StatelessWidget {
  final SearchPrintersController mySearchPrintersController;

  SearchPrintersView(MainModel model)
      : mySearchPrintersController = Get.put(SearchPrintersController(model));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TCP Flutter Demo"),
      ),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InputTextField(
                            mySearchPrintersController: mySearchPrintersController,
                            hintText: "IP:",
                          ),
                        ),
                        Expanded(
                          child: InputTextField(
                            mySearchPrintersController: mySearchPrintersController,
                            hintText: "Port:",
                          ),
                        ),
                      ],
                    ),
                    MyProgressButton(
                      mySearchPrintersController: mySearchPrintersController,
                      text: "Connect",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: MyProgressButton(
                            mySearchPrintersController: mySearchPrintersController,
                            text: "Scan",
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 55,
                            margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.redAccent),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: mySearchPrintersController.showLogDialog,
                              child: Text('Failed connections'),
                            ),
                          ),
                        )
                      ],
                    ),
                    ConnectedIPsList(
                        mySearchPrintersController: mySearchPrintersController)
                  ],
                ),
              ),
            ),
            MessageBox(mySearchPrintersController: mySearchPrintersController),
          ],
        ),
      ),
    );
  }
}

class MyProgressButton extends StatelessWidget {
  const MyProgressButton({
    Key? key,
    required this.mySearchPrintersController,
    required this.text,
  }) : super(key: key);

  final SearchPrintersController mySearchPrintersController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 5),
      child: Obx(
            () => ProgressButton(
          stateWidgets: {
            ButtonState.idle: Text(
              text,
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            ButtonState.loading: Text(
              "Loading",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            ButtonState.fail: Text(
              "Fail",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            ButtonState.success: Text(
              "Success",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )
          },
          stateColors: {
            ButtonState.idle: Colors.grey.shade400,
            ButtonState.loading: Colors.blue.shade300,
            ButtonState.fail: Colors.red.shade300,
            ButtonState.success: Colors.green.shade400,
          },
          onPressed: text == "Connect"
              ? mySearchPrintersController.connectToIP
              : mySearchPrintersController.searchIPs,
          state: text == "Connect"
              ? (mySearchPrintersController.isConnectToIP.value)
              : (mySearchPrintersController.isLoading.value
              ? ButtonState.loading
              : ButtonState.idle),
        ),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.mySearchPrintersController,
    required this.hintText,
  }) : super(key: key);

  final SearchPrintersController mySearchPrintersController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 3),
        ],
      ),
      child: TextField(
        controller: hintText == "Port:"
            ? mySearchPrintersController.portTEController
            : mySearchPrintersController.ipTEController,
        keyboardType: TextInputType.number,
        maxLines: null,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none),
      ),
    );
  }
}

class ConnectedIPsList extends StatelessWidget {
  const ConnectedIPsList({
    Key? key,
    required this.mySearchPrintersController,
  }) : super(key: key);

  final SearchPrintersController mySearchPrintersController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () => mySearchPrintersController.isLoading.value
            ? CircularProgressIndicator()
            : Container(
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.blue, spreadRadius: 3),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 5),
                child: Text(
                  "Connected IPs:",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                  mySearchPrintersController.connectedIPs.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green, spreadRadius: 3),
                          ],
                        ),
                        child: Text(mySearchPrintersController
                            .connectedIPs[index].address
                            .toString()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  const MessageBox({
    Key? key,
    required this.mySearchPrintersController,
  }) : super(key: key);

  final SearchPrintersController mySearchPrintersController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, bottom: 10),
        height: 60,
        width: double.infinity,
        // color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, spreadRadius: 3),
                  ],
                ),
                child: TextField(
                  controller: mySearchPrintersController.textController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: mySearchPrintersController.sendMessage,
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}