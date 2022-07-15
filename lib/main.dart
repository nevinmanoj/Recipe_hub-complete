

// ignore_for_file: camel_case_types, sort_child_properties_last, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/authenticate/signUp.dart';
import 'package:untitled/services/auth.dart';
import 'package:untitled/wrapper.dart';
import 'package:provider/provider.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  runApp(StreamProvider<User?>.value(
    value:AuthSerivice().user,
    initialData: null,
    child: MaterialApp(
      home:wrapper(),
  
    ),
  )
  );
}



