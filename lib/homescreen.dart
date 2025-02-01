import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/signup.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOutAndDeleteAccount() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await user.delete();

        await _auth.signOut();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Signupscreen()),
        );
      }
    } catch (e) {
      print("Error deleting account: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'YES') {
                _signOutAndDeleteAccount();
              }
            },
            child: Center(
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'YES',
                child: Text('YES'),
              ),
              PopupMenuItem(
                value: 'NO',
                child: Text('NO'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
