import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:meta/meta.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    //@required PlatformException exception,
    @required FirebaseAuthException exception,
  }) : super(
    title: title,
    content: _message(exception),
    defaultActionText: 'OK',
  );

  //static String _message(PlatformException exception) {
  static String _message(FirebaseAuthException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    /// User Creation Errors
    /// - **email-already-in-use**:
    ///  - Thrown if there already exists an account with the given email address.
    /// - **invalid-email**:
    ///  - Thrown if the email address is not valid.
    /// - **operation-not-allowed**:
    ///  - Thrown if email/password accounts are not enabled. Enable
    ///    email/password accounts in the Firebase Console, under the Auth tab.
    /// - **weak-password**:
    ///  - Thrown if the password is not strong enough.

    /// User Sign-In Errors
    /// - **invalid-email**:
    ///  - Thrown if the email address is not valid.
    /// - **user-disabled**:
    ///  - Thrown if the user corresponding to the given email has been disabled.
    /// - **user-not-found**:
    ///  - Thrown if there is no user corresponding to the given email.
    /// - **wrong-password**:
    ///  - Thrown if the password is invalid for the given email, or the account
    ///    corresponding to the email does not have a password set.

    'email-already-in-use': 'This email is already in use.',
    'invalid-email': 'Email or Password is invalid.',
    'weak-password': 'Your chosen password is too weak.',
    'user-disabled': 'Email or Password is invalid.',
    'user-not-found': 'Email or Password is invalid.',
    'wrong-password': 'Email or Password is invalid.',

  };
}
