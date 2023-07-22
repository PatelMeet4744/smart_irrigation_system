// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:smart_irrigation_app/auth_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_irrigation_app/const/custom_styles.dart';
import 'package:smart_irrigation_app/model/sensor.dart';
import 'package:smart_irrigation_app/route/routing_constants.dart';
import 'package:smart_irrigation_app/widgets/my_sensor_card.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<double>? tempList;
  List<double>? rhList;

  final dbref = FirebaseDatabase.instance.reference();
  static String collectionName = 'Dashbord';
  // final sensorRef = FirebaseFirestore.instance
  //     .collection(collectionName)
  //     .withConverter<Sensor>(
  //       fromFirestore: (snapshots, _) => Sensor.fromJson(snapshots.data()!),
  //       toFirestore: (movie, _) => movie.toJson(),
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      // stream: sensorRef.snapshots(),
      stream: dbref.child("DHT").onValue,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        // final data = snapshot.requireData;

        final data = snapshot.data.snapshot.value['temperature'];
        // print(data.do);

        if (tempList == null) {
          tempList = List.filled(5, snapshot.data.snapshot.value['temperature'],
              growable: true);
        } else {
          tempList!.add(20.0);
          tempList!.removeAt(0);
        }

        if (rhList == null) {
          rhList = List.filled(5, snapshot.data.snapshot.value['humidity'],
              growable: true);
        } else {
          rhList!.add(50.5);
          rhList!.removeAt(0);
        }

        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 30),
          child: CustomScrollView(slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            collectionName,
                            style: kHeadline,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MySensorCard(
                                value: snapshot.data.snapshot.value['humidity'],
                                unit: '%',
                                name: 'Humidity',
                                assetImage: AssetImage(
                                  'assets/images/humidity_icon.png',
                                ),
                                trendData: rhList!,
                                linePoint: Colors.blueAccent,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MySensorCard(
                                value:
                                    snapshot.data.snapshot.value['temperature'],
                                unit: '\'C',
                                name: 'Temperature',
                                assetImage: AssetImage(
                                  'assets/images/temperature_icon.png',
                                ),
                                trendData: tempList!,
                                linePoint: Colors.redAccent,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MySensorCard(
                                value: snapshot.data.snapshot.value['Moisture'],
                                unit: '%',
                                name: 'Moisture',
                                assetImage: AssetImage(
                                  'assets/images/humidity_icon.png',
                                ),
                                trendData: tempList!,
                                linePoint: Colors.redAccent,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ]),
        );
      },
    ));
  }

  // _signOut() async {
  //   await AuthHelper.signOut();
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, SplashScreenRoute, (Route<dynamic> route) => false);
  // }
}
