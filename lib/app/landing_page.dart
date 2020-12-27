import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign-in/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

import 'home/jobs/jobs_page.dart';

//class LandingPage extends StatefulWidget {
class LandingPage extends StatelessWidget {
  // LandingPage({@required this.auth});
  // final AuthBase auth;

//   @override
//   _LandingPageState createState() => _LandingPageState();
// }
//
// class _LandingPageState extends State<LandingPage> {
  // User _user;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //Update Firebase Auth which doesn't return a Future anymore
  //   _checkCurrentUser();
  //   widget.auth.onAuthStateChanged.listen((user) {
  //     print('user: ${user?.uid}');
  //   });
  // }
  //
  // void _checkCurrentUser() {
  //   User user = widget.auth.currentUser();
  //   _updateUser(user);
  // }
  //
  // void _updateUser(User user) {
  //   //print('User id: ${user.uid}');
  //   setState(() {
  //     _user = user;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: user.uid),
            child: JobsPage(),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
