import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkedinclone/screens/auth/login_screen.dart';
import 'package:linkedinclone/screens/jobs/upload_job.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          print("User is not logged in yet");
          return Login();
        } else if (snapshot.hasData) {
          print("User is already logged in");
          return UploadJobNow();
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("An Error has been occured"),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SomeThing Happend"),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
