import 'package:firebase_database/firebase_database.dart';
import 'package:smart_irrigation_app/const/custom_styles.dart';
import 'package:smart_irrigation_app/widgets/my_password_field.dart';
import 'package:smart_irrigation_app/widgets/my_text_button.dart';
import 'package:smart_irrigation_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

// import '../auth_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final dbR = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select The Time")),
      body: StreamBuilder(
          stream: dbR.child("schedule/Time").onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data?.snapshot.value;
            print(data);

            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: Image(
                      image: AssetImage(
                        'assets/images/Time_image.png',
                      ),
                      height: 200,
                      width: 800,
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  "Set Time",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  // _timeOfDay.hour.toString().padLeft(2, '0') +
                  //     ':' +
                  //     _timeOfDay.minute.toString().padLeft(2, '0'),
                  snapshot.data.snapshot.value,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
                const SizedBox(height: 50),
                MaterialButton(
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: const Text(
                      'Select Time',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      selectTime();
                    })
              ],
            ));
          }),
    );
  }

  Future<void> selectTime() async {
    TimeOfDay? _picked =
        await showTimePicker(context: context, initialTime: _timeOfDay);
    if (_picked != null) {
      setState(() {
        _timeOfDay = _picked;
      });
      String hh = _timeOfDay.hour.toString();
      String mm = _timeOfDay.minute.toString();
      if (hh == "0") {
        hh = "12";
      }

      String selectedTime = hh + ':' + mm;
      // print(selectedTime);

      dbR.child("schedule").set({"Time": selectedTime});
    }
  }
}
