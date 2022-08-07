// ignore_for_file: prefer_const_constructors, sort_child_properties_last, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/shared/Constants.dart';

class UpdateInvent extends StatelessWidget {
  bool canCook;
  Map<String, dynamic> ingredients;

  UpdateInvent({required this.canCook, required this.ingredients});
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;

    if (canCook) {
      return CanUpdate(
        ingredients: ingredients,
      );
    }

    return CantUpdate();
  }
}

class CanUpdate extends StatelessWidget {
  Map<String, dynamic> ingredients;
  CanUpdate({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(
          0,
          0,
          0,
          ht * 0.1,
        ),
        title: Center(
            child: Text(
          "Inventory updated successfully!",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        content: Column(children: [
          SizedBox(
              height: ht * 0.15,
              child: Lottie.network(
                  "https://assets9.lottiefiles.com/packages/lf20_bxd6jjcn.json")),
          SizedBox(
            height: ht * 0.05,
          ),
          SizedBox(
            height: ht * 0.05,
            width: wt * 0.28,
            child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 19),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(appYellow))),
          ),
        ]));
  }
}

class CantUpdate extends StatelessWidget {
  const CantUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return AlertDialog(
        insetPadding: EdgeInsets.fromLTRB(
          0,
          0,
          0,
          ht * 0.1,
        ),
        title: Center(
            child: Text(
          "Can't update inventory!",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        content: Column(children: [
          Text("Insufficient items in inventory."),
          SizedBox(
            height: ht * 0.08,
          ),
          SizedBox(
            height: ht * 0.06,
            width: wt * 0.4,
            child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(appYellow))),
          ),
        ]));
  }
}
