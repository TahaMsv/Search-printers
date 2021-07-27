import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String IP_RANGE = "192.168.45.";
  List<String> connectedIPs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _connectToIPS() {
    var webSocket ;
    String ip = "";
    connectedIPs = [];
    for (int i = 1; i <= 255; i++) {
      ip = IP_RANGE + i.toString();
      //try to connect
      if (true) {
        // if connected
        connectedIPs.add(ip);
      }
    }
  }

  void _sendMessage() {
    for (int i = 0; i < connectedIPs.length; i++) {
      //sendMessage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TCP Flutter Demo"),),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 5),
                child: ProgressButton(

                  stateWidgets: {
                    ButtonState.idle: Text(
                      "Scan",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    ButtonState.loading: Text(
                      "Loading",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    ButtonState.fail: Text(
                      "Fail",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    ButtonState.success: Text(
                      "Success",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  },
                  stateColors: {
                    ButtonState.idle: Colors.grey.shade400,
                    ButtonState.loading: Colors.blue.shade300,
                    ButtonState.fail: Colors.red.shade300,
                    ButtonState.success: Colors.green.shade400,
                  },
                  onPressed: _connectToIPS,
                  state: ButtonState.idle,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  "Connected IPs",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  itemCount: connectedIPs.length,
                  itemBuilder: (context, index) {
                    final item = connectedIPs[index];
                    return ListTile(
                      title: Text(item),
                    );
                  },
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: _sendMessage,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
