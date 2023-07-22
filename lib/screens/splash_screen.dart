// import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_irrigation_app/const/custom_styles.dart';
import 'package:smart_irrigation_app/route/routing_constants.dart';
import 'package:flutter/material.dart';

// import '../auth_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      // future: AuthHelper.initializeFirebase(context: context),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.done) {
        // User? user = AuthHelper.currentUser();
        // if (user != null) {
        // Future.delayed(Duration.zero, () async {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, DashboardScreenRoute, (Route<dynamic> route) => false);
        // });
        // }
        //  else {
        return _getScreen(context);
        // }
        // }
        // return Center(
        //   child: Text("Hello"),
        // );
      },
    ));
  }

  _getScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          Flexible(
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Image(
                      image: AssetImage(
                        'assets/images/Second_Image.png',
                      ),
                      // color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Firebase\nCloud Firestore",
                  style: kHeadline,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "This is a project that connects to hardware devices via Firebase and gets the readings from sensors. For detail, you can check out my channel.",
                    style: kBodyText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.black12,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context,
                        SplashScreen2Route, (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Next',
                    style: kButtonText.copyWith(color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
