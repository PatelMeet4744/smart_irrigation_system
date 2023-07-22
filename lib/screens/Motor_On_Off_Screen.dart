import 'package:firebase_database/firebase_database.dart';
import 'package:smart_irrigation_app/const/custom_styles.dart';
import 'package:flutter/material.dart';

// import '../auth_helper.dart';

class MotorScreen extends StatefulWidget {
  const MotorScreen({Key? key}) : super(key: key);

  @override
  _MotorScreenState createState() => _MotorScreenState();
}

class _MotorScreenState extends State<MotorScreen> {
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
          stream: dbR.child("Light").onValue,
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
                        "Motor ON OFF",
                        style: kHeadline,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    On
                        ? Image(
                            image: AssetImage(
                              'assets/images/motor_on.png',
                            ),
                          )
                        //  Icon(
                        //     Icons.lightbulb,
                        //     size: 100,
                        //     color: Colors.amber.shade700,
                        //   )
                        : Image(
                            image: AssetImage(
                              'assets/images/motor_off.png',
                            ),
                          ),
                    // Icon(
                    //     Icons.lightbulb_outline,
                    //     size: 100,
                    //     color: Colors.white,
                    //   ),
                    SizedBox(
                      height: 100,
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
                              dbR.child("Light").set({"Switch": !On});
                              setState(() {
                                On = !On;
                              });
                            },
                            child: On
                                ? Text(
                                    "Motor ON",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                    // style: kButtonText.copyWith(color: Colors.white),
                                  )
                                : Text(
                                    "Motor OFF",
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
