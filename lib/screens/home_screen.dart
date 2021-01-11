import 'package:edu_connect/models/shared_preferences.dart';
import 'package:edu_connect/models/user.dart';
import 'package:edu_connect/screens/home_screens/home_chat.dart';
import 'package:edu_connect/screens/home_screens/home_home.dart';
import 'package:edu_connect/screens/home_screens/home_profile.dart';
import 'package:edu_connect/screens/home_screens/home_groups.dart';
import 'package:edu_connect/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> navbarWidgets = <Widget>[
      HomeChat(),
      HomeHome(),
      HomeGroups(),
      HomeProfile(),
    ];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference locations_firestore =
    // FirebaseFirestore.instance.collection('locations');

    SharedPref sharedpref = SharedPref();
    User user = FirebaseAuth.instance.currentUser;

    hello() async {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ));
      //print(await sharedpref.read('user'));
      Provider.of<UserCurrent>(context, listen: false).fromJson(
        await sharedpref.read('user'),
      );
      // SystemChrome.setEnabledSystemUIOverlays([]);

      print(Provider.of<UserCurrent>(context, listen: false).uid);
      print(user.uid);
      Provider.of<UserCurrent>(context, listen: false).uid = user.uid;
      // Provider.of<UserCurrent>(context, listen: false).name = user.;
      Provider.of<UserCurrent>(context, listen: false).phoneNo =
          user.phoneNumber;
      print('ssoosset');
      print(Provider.of<UserCurrent>(context, listen: false).profileSet);

      DocumentSnapshot temp_isTutor = await FirebaseFirestore.instance
          .collection('parents')
          .doc((Provider.of<UserCurrent>(context, listen: false).uid))
          .get();
      Provider.of<UserCurrent>(context, listen: false).isTutor =
          temp_isTutor.data()['tutor'];

      // print(snapshot.docs.first);

      // get the location using geolocator plugin and submit it to the the user's cloudbase or just store it in currentuser to find tutor's distance from the user.

      // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

      // Provider.of<UserCurrent>(context, listen: false).uid =
    }

    hello();

    void initState() {}

    void dispose() {
      // TODO: implement dispose
      super.dispose();
      // animationController.dispose() instead of your controller.dispose
    }

    return Scaffold(
      //https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html

      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        color: Theme.of(context).accentColor,
        backgroundColor: Color(0xfffffff),
        height: 45,

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        //type: BottomNavigationBarType.fixed,

        items: [
          Container(
            child: Icon(Icons.chat),
          ),
          Container(
            child: Icon(Icons.home),
          ),
          Container(
            child: Icon(Icons.group_add_sharp),
          ),
          Container(
            child: Icon(Icons.face),
          ),
        ],
      ),
      body: navbarWidgets.elementAt(_selectedIndex),
      extendBody: true,

      // backgroundColor: Colors.transparent,
    );
  }
}
