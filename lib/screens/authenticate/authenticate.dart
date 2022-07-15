import 'package:untitled/screens/authenticate/login.dart';
import 'package:untitled/screens/authenticate/signUp.dart';
import 'package:flutter/material.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  toggleView() {    setState(() => showSignIn = !showSignIn);   }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return login(toggleView:  toggleView);
    } else {
      return signUp(toggleView:  toggleView);
    }
  }
}