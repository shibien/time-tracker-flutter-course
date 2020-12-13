
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home_page.dart';
import 'package:time_tracker_flutter_course/app/sign-in/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class LandingPage extends StatefulWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Update Firebase Auth which doesn't return a Future anymore
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    User user = widget.auth.currentUser();
    _updateUser(user);
  }

  void _updateUser(User user) {
    //print('User id: ${user.uid}');
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        auth: widget.auth,
        // same because onSignIn and _updateUser have the same signature
        //onSignIn: (user) => _updateUser(user),
        onSignIn: _updateUser,
      );
    }
    return HomePage(
      auth: widget.auth,
      onSignOut: () => _updateUser(null),
    ); // temporarily placeholder for HomePage
  }
}
