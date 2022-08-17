import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static late String _verificationId;
  static int? _token;

  static void autheticateWithPhoneNumber(
      String countryCode, String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: '$countryCode $phoneNumber',
      forceResendingToken: _token,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        _token = resendToken!;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static void signInWithPhoneNumber(String code) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: code,
      );

      final User? user =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (user != null) {
        Fluttertoast.showToast(
          msg: "Authentication successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // duration
        );
      } else {
        Fluttertoast.showToast(
          msg: "Authentication failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // duration
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An error occured!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, // duration
      );
    }
  }
}
