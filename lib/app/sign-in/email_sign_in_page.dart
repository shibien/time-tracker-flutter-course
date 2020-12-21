import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign-in/email_sign_in_form_bloc_based.dart';
import 'package:time_tracker_flutter_course/app/sign-in/email_sign_in_form_stateful.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  // EmailSignInPage({@required this.auth});
  // final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Sign In'),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormBlocBased.create(context),
            //child: EmailSignInFormStateful(),
            //child: EmailSignInForm(auth: auth),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
