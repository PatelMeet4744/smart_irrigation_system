import 'package:firebase_database/firebase_database.dart';
import 'package:smart_irrigation_app/const/custom_styles.dart';
import 'package:flutter/material.dart';

class AutoScreen extends StatefulWidget {
  const AutoScreen({Key? key}) : super(key: key);

  @override
  _AutoScreenState createState() => _AutoScreenState();
}

class _AutoScreenState extends State<AutoScreen> {
  bool On = false;
  final dbR = FirebaseDatabase.instance.reference();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Smart bulb System"),
      // ),
      body: StreamBuilder(
          stream: dbR.child("Auto").onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data.snapshot.value['Switch'];
            print(data);
            On = data;

            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Auto or Manual",
                        style: kHeadline,
                      ),
                    ),
                    SizedBox(
                      height: 450,
                    ),
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Container(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    On ? Colors.green : Colors.white),
                            // style: ButtonStyle(
                            //   overlayColor: MaterialStateProperty.resolveWith(
                            //     (states) => Colors.black12,
                            //   ),
                            // ),
                            onPressed: () {
                              dbR.child("Auto").set({"Switch": !On});
                              setState(() {
                                On = !On;
                              });
                            },
                            child: On
                                ? Text(
                                    "ON",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    // style: kButtonText.copyWith(color: Colors.white),
                                  )
                                : Text(
                                    "OFF",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    // style: kButtonText.copyWith(color: Colors.black),
                                  ),
                          ),
                        ))
                  ]),
            );
          }),
    );
  }
}
