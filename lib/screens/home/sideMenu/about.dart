// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/shared/filter.dart';
import 'package:vector_math/vector_math.dart' show radians;

bool showFilter = false;
var _value;
double maxh = 0;
String? veg;
var backdropColor = Colors.white.withOpacity(1);

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

// class _AboutScreenState extends State<AboutScreen> {
//   @override
//   Widget build(BuildContext context) {
//     showFilter ? maxh = 400 : 0;
//     return Scaffold(
//         floatingActionButton: !showFilter
//             ? FloatingActionButton(
//                 onPressed: () {
//                   setState(() {
//                     showFilter = !showFilter;

//                     maxh = 400;
//                   });
//                 },
//               )
//             : Container(),
//         appBar: AppBar(
//           backgroundColor: appYellow,
//         ),
//         body: Container(
//             child: SlidingUpPanel(
//           body: Center(
//             child: Lottie.network(
//               'https://assets8.lottiefiles.com/packages/lf20_gspk84ad.json',
//               animate: true,
//               repeat: true,
//             ),
//           ),
//           panelSnapping: false,
//           onPanelOpened: () {
//             setState(() {
//               showFilter = true;
//               maxh = 400;
//             });
//           },
//           onPanelClosed: () {
//             setState(() {
//               showFilter = false;
//               maxh = 0;
//             });
//           },
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40), topRight: Radius.circular(40)),
//           defaultPanelState: PanelState.OPEN,
//           backdropTapClosesPanel: true,
//           backdropEnabled: true,
//           backdropColor: Colors.grey.withOpacity(0.2),
//           minHeight:
//               // maxh > 0 ? maxh - 100 :
//               maxh,
//           maxHeight: maxh,
//           panel: Column(children: [
//             ElevatedButton(
//                 onPressed: (() {
//                   setState(() {
//                     showFilter = false;
//                     maxh = 0;
//                   });
//                 }),
//                 child: Text("cancel")),
//             for (int i = 1; i <= 3; i++)
//               ListTile(
//                 title: Text(
//                   'Radio $i',
//                 ),
//                 leading: Radio(
//                   activeColor: appYellow,
//                   value: i,
//                   groupValue: _value,
//                   onChanged: (value) {
//                     setState(
//                       () {
//                         _value = value;
//                       },
//                     );
//                   },
//                 ),
//               ),
//           ]),
//         )));
//   }
// }

class _AboutScreenState extends State<AboutScreen> {
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: !showFilter
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  showFilter = true;
                  backdropColor = Colors.grey.withOpacity(0.2);
                  _height = ht;
                });
              },
            )
          : Container(),
      appBar: AppBar(
        backgroundColor: appYellow,
      ),
      body: Container(
        child: Stack(children: [
          Center(
            child: Lottie.network(
              'https://assets8.lottiefiles.com/packages/lf20_gspk84ad.json',
              animate: true,
              repeat: true,
            ),
          ),
          if (showFilter)
            InkWell(
              onTap: () {
                setState(() {
                  showFilter = false;
                  backdropColor = Colors.white;
                  _height = 0;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                color: backdropColor,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: appYellow,
                borderRadius: BorderRadius.only(
                    topRight: showFilter ? Radius.circular(40) : Radius.zero,
                    topLeft: showFilter ? Radius.circular(40) : Radius.zero),
              ),
              height: _height,
              width: wt,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: ListView(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, ht * 0.04, wt * 0.06, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: (() {
                          setState(() {
                            showFilter = false;
                            backdropColor = Colors.white;
                            _height = 0;
                          });
                        }),
                        child: Text(
                          "Close",
                          style: TextStyle(
                              color: Color(0xFF355764),
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(wt * 0.02, 0, wt * 0.02, 0),
                  child: Divider(
                    color: Color(0xFF355764),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(wt * 0.05, 0, 0, 0),
                  child: Text(
                    "Veg/Non Veg",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                ),
                // SizedBox(
                //   width: wt,
                //   child: Row(
                //     children: [
                ListTile(
                  title: Text(
                    "VEG",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  leading: Radio(
                    activeColor: Colors.white,
                    value: 'veg',
                    toggleable: true,
                    groupValue: veg,
                    onChanged: (value) {
                      setState(
                        () {
                          veg = value as String?;
                        },
                      );
                    },
                  ),
                ),
                //     ],
                //   ),
                // ),
                for (int i = 1; i <= 3; i++)
                  ListTile(
                    title: Text(
                      'Radio $i',
                    ),
                    leading: Radio(
                      activeColor: Colors.white,
                      value: i,
                      toggleable: true,
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
            ),
          )
        ]),
      ),
    );
  }
}
