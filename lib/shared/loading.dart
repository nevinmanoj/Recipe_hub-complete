import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100]?.withOpacity(0.5),
      child: Center(
        child: SpinKitFadingCircle(
          color: Color(0xFF7C7C7C),
          size: 70.0,
        ),
      ),
    );
  }
}

class LoadCusines extends StatelessWidget {
  const LoadCusines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Lottie.network(
          'https://assets8.lottiefiles.com/private_files/lf30_cIOAbL.json',
          animate: true,
          repeat: true),
    ));
  }
}

class LoadHistory extends StatelessWidget {
  const LoadHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Lottie.network(
          'https://assets4.lottiefiles.com/packages/lf20_h3b950fy.json',
          animate: true,
          repeat: true),
    ));
  }
}
