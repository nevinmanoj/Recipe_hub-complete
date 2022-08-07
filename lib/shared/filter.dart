import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/screens/home/sideMenu/about.dart';
import 'package:untitled/shared/Constants.dart';

var _value;

class FilterPop extends StatefulWidget {
  @override
  _FilterPopState createState() => _FilterPopState();
}

class _FilterPopState extends State<FilterPop> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      onPanelClosed: () {
        setState(() {
          showFilter = false;
        });
      },
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      defaultPanelState: PanelState.OPEN,
      backdropTapClosesPanel: true,
      backdropEnabled: true,
      minHeight: 0,
      maxHeight: 400,
      panel: Column(children: [
        for (int i = 1; i <= 3; i++)
          ListTile(
            title: Text(
              'Radio $i',
            ),
            leading: Radio(
              activeColor: appYellow,
              value: i,
              groupValue: _value,
              onChanged: (value) {
                setState(
                  () {
                    _value = value;
                  },
                );
              },
            ),
          ),
      ]),
    );
  }
}
