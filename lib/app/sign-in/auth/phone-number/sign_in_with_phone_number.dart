import 'package:firebase_auth/firebase_auth.dart';

Future<String> signInWithPhoneNumber(String phoneNumber) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = '';

  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Auto-retrieval or instant verification
      await auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      // Handle error
      print('Verification failed: ${e.message}');
    },
    codeSent: (String vId, int? resendToken) {
      verificationId = vId; // Save the verification ID
    },
    codeAutoRetrievalTimeout: (String vId) {
      verificationId = vId; // Timeout case
    },
  );

  return verificationId; // Return verification ID
}

Future<bool> verifyOtp(String verificationId, String smsCode) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: smsCode,
  );

  try {
    await auth.signInWithCredential(credential);
    return true; // Verification successful
  } catch (e) {
    print('Verification failed: $e');
    return false; // Verification failed
  }
}
