import 'dart:convert';
import 'dart:ffi';
import 'package:smart_irrigation_app/model/sensor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  bool value = false;
  final dbref = FirebaseDatabase.instance.reference();
  List<String>? tempList;
  String? data;

  @override
  void initState() {
    dbref.onValue.listen((event) {
      setState(() {
        print(event.snapshot.value);
        data = jsonEncode(event.snapshot.value.DHT);
        tempList = event.snapshot.value;
        Sensor.fromJson(jsonDecode(event.snapshot.value));

        // data = json.decoder(data);
        // convertedData=jsonDecode(data!);
      });
    });
    super.initState();
  }

  onUpdate() {
    setState(() {
      value = !value;
    });
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        body: StreamBuilder(
            stream: dbref.child("DHT").onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("The data is");
                // print(snapshot.data.snapshot.value);
                final datavalue = snapshot.requireData;
                // print(tempList);
                // print(datavalue);
                // return const Center(child: CircularProgressIndicator());
              }
              // snapshot.data
              if (snapshot.hasData && !snapshot.hasError
                  // && snapshot.data?.snapshot.value != null
                  ) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.clear_all,
                            color: Colors.white,
                          ),
                          Text(
                            "My Room",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Temperature",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "40",
                                // snapshot.data.snapshot.value["temperature:"].toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Humidity",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "80",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                    FloatingActionButton.extended(
                      onPressed: () {
                        onUpdate();
                        writeData();
                      },
                      label: value ? Text("ON") : Text("Off"),
                      elevation: 20,
                      backgroundColor: value ? Colors.green : Colors.red,
                      icon: value
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    )
                  ],
                );
              } else {
                return Container();
              }
            }));
  }

  Future<void> writeData() async {
    dbref.child("Light").set({"Switch": !value});
  }
}
