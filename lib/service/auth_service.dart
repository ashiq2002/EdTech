import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //user sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //user signup with email password
  Future<UserCredential> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //sign out user
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  //reset/recover user password
  Future resetPassword({required String email}) async {
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    }on FirebaseAuthException catch(e){
      return e.message.toString();
    }
  }
}