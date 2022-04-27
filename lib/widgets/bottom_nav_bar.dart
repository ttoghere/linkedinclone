import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../consts/user_state.dart';
import '../screens/jobs/jobs_screen.dart';
import '../screens/jobs/upload_job.dart';
import '../screens/profile/company_profile.dart';
import '../screens/search/search_company.dart';


class BottomNav extends StatelessWidget {
  int indexNum = 0;
  BottomNav({
    Key? key,
    required this.indexNum,
  }) : super(key: key);

  void _logOut(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              title: Row(children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white70,
                    size: 36,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ]),
              content: Text(
                "Do you want to log out from app?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).canPop()
                        ? Navigator.of(context).pop()
                        : null;
                  },
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.of(context).canPop()
                        ? Navigator.of(context).pop()
                        : null;
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => UserState()));
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.white,
      backgroundColor: Colors.black,
      buttonBackgroundColor: Colors.white,
      height: 52,
      index: indexNum,
      items: [
        Icon(
          Icons.list,
          size: 10,
          color: Colors.blue,
        ),
        Icon(
          Icons.search,
          size: 10,
          color: Colors.blue,
        ),
        Icon(
          Icons.add,
          size: 10,
          color: Colors.blue,
        ),
        Icon(
          Icons.person_pin,
          size: 10,
          color: Colors.blue,
        ),
        Icon(
          Icons.exit_to_app,
          size: 10,
          color: Colors.blue,
        ),
      ],
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.bounceInOut,
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => JobsScreen()));
        } else if (index == 1) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AllWorkersPage()));
        } else if (index == 2) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => UploadJobNow()));
        } else if (index == 3) {
          final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          final User? user = firebaseAuth.currentUser;
          final String uid = user!.uid;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProfileScreen(
                    userId: uid,
                  )));
        } else if (index == 4) {
          _logOut(context);
        }
      },
    );
  }
}
