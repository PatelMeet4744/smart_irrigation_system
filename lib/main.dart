import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_irrigation_app/route/router.dart' as router;
import 'package:smart_irrigation_app/route/routing_constants.dart';
import 'const/custom_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
  // runApp(const MyApp());
  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   theme: ThemeData.dark(),
  //   home: MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IoT Firestore App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: SplashScreenRoute,
    );
  }
  // State<MyApp> createState() => _MyAppState();
}

// class _MyAppState extends State<MyApp> {
//   // const MyApp({Key? key}) : super(key: key);
//   bool On = false;
//   final dbR = FirebaseDatabase.instance.reference();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Smart bulb System"),
//       ),
//       body: Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           On
//               ? Icon(
//                   Icons.lightbulb,
//                   size: 100,
//                   color: Colors.amber.shade700,
//                 )
//               : Icon(
//                   Icons.lightbulb_outline,
//                   size: 100,
//                 ),
//           ElevatedButton(
//               style: TextButton.styleFrom(
//                   backgroundColor: On ? Colors.green : Colors.white10),
//               onPressed: () {
//                 dbR.child("Light").set({"Switch": !On});
//                 setState(() {
//                   On = !On;
//                 });
//               },
//               child: On ? Text("LED ON") : Text("LED OFF"))
//         ]),
//       ),
//     );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );
//   }
// }
