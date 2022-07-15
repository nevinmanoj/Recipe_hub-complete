import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.grey[100]?.withOpacity(0.4),
      child: Center(
        child: SpinKitSpinningLines(
          color: Color.fromARGB(255, 0, 0, 0),
          size: 100.0,),
      ),
    );
  }
}