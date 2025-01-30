import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "Email already in use") {
        log('The email is already use');
      } else {
        log('An error occured:${e.code}');
      }
    }
    return null;
  }

  Future<User?>signinWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    on FirebaseAuthException catch(e){
      if(e.code=='User not found'){
        log('Invaild email and passwoed');
      }
      else{
        log('An error occured:${e.code}');
      }
    }
    return null;
  }
}
