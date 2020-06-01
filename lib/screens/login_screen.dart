import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skype_clone/resources/firebase_repository.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skype_clone/util/universal_variables.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Stack(
        children: [
          Center(
            child: loginButton(),
          ),
          isLoginPressed ?
          Center( child: CircularProgressIndicator(),)
          : Container()
        ],
      ),
    );
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: UniversalVariables.senderColor,
      child: FlatButton(
        padding: EdgeInsets.all(35),
        child: Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 55, fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        onPressed: () {performLogin();},
//        onPressed: (){
//          Navigator.pushReplacement(context,
//            MaterialPageRoute(builder: (context) {
//              return HomeScreen();
//            }));},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }


  void performLogin() {
    print("-------------------------------------tring to perform login");
    _repository.signOutofApp();

    setState(() {
      isLoginPressed = true;
    });

    _repository.signIn().then((FirebaseUser user) {
      print("----------------------------------------signIn process completed. Now authenticating");
      if (user != null) {
        authenticateUser(user);
      } else {
        print("----------------------------------------There was an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    print('----------------------------------------Inside authenticate User');
    _repository.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });

      if (isNewUser) {
        print('----------------------------------------You are new User');
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
        });
      } else {
        print('----------------------------------------old User detected ');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
      }
    });
  }
}