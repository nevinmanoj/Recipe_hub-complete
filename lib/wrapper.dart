// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/authenticate/authenticate.dart';
import 'package:untitled/screens/authenticate/login.dart';
import 'package:untitled/screens/home/home.dart';

class wrapper extends StatefulWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
     final user = Provider.of<User?>(context);
     
     if(user==null)
      {
       return Authenticate();
      }
      else
      { 
        return home();
        }

  
  }
}