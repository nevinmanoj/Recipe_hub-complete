import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:lottie/lottie.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: appYellow,
      ),
      body: Container(
        child: Center(
          child: 
          Lottie.network('https://assets8.lottiefiles.com/packages/lf20_gspk84ad.json',
          animate: true,
          repeat: true,
          ),
        ),
      ),

    );
    
  }
}