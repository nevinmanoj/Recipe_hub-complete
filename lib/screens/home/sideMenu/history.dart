import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';
import 'package:untitled/shared/loading.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Previosly Cooked",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: appYellow,
        ),
        body: Container(
          child: FutureBuilder(
              future: DatabaseService(uid: user!.uid).getHistory(),
              builder: (context, historySnap) {
                if (historySnap.data == null)
                  // ignore: curly_braces_in_flow_control_structures
                  return LoadHistory();

                var result = historySnap.data as List?;
                // print(result);
                List<recipeModel>? historyList =
                    result![0] as List<recipeModel>?;

                List<String> dateList = result[1] as List<String>;
                List<String> timeList = result[2] as List<String>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ht * 0.01,
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          width: wt * 0.95,
                          child: ListView.builder(
                              itemCount: historyList!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int i) {
                                return InkWell(
                                  onTap: () async {
                                    recipeModel R = await DatabaseService(
                                            uid: user!.uid)
                                        .getRecipe(
                                            RecipeId: historyList[i].RecipeId);
                                    // R.isLike=await DatabaseService(uid:user!.uid).isFavorite(RecipeId:Recipes?[i].id as String);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                cookPage(currentRecipe: R)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.15),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    //helo

                                    // padding: const EdgeInsets.only(left: 5),
                                    height: 0.17 * ht,
                                    width: wt * 0.8,
                                    margin: EdgeInsets.only(bottom: wt * 0.025),

                                    child: Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Container(
                                                height: 0.15 * ht,
                                                width: wt * 0.30,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          historyList[i].img),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: ht * 0.015,
                                                ),
                                                Text(
                                                  historyList[i].title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: ht * 0.008,
                                                ),
                                                Text(
                                                  dateList[i],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 138, 137, 137),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  timeList[i],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: ht * 0.03,
                                                ),
                                                Row(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        historyList[i].isveg
                                                            ? "VEG "
                                                            : "NON VEG ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: historyList[i]
                                                                    .isveg
                                                                ? Color(
                                                                    0xFF00923F)
                                                                : Color(
                                                                    0xFFda251e)),
                                                      ),
                                                      Image(
                                                        image: AssetImage(
                                                            historyList[i].isveg
                                                                ? "assets/veg.png"
                                                                : "assets/nonVeg.png"),
                                                        height: 0.04 * ht,
                                                        width: 0.04 * wt,
                                                      )
                                                    ])
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ))
                  ],
                );
              }),
        ));
  }
}




// class HistoryPage extends StatefulWidget {
//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {
//   String? searchString = "";

//   @override
//   Widget build(BuildContext context) {
//     double ht = MediaQuery.of(context).size.height;
//     double wt = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: EdgeInsets.fromLTRB(wt * 0.15, 0, 0, 0),
//           child: Text(
//             "Previosly Cooked",
//             style: TextStyle(
//               fontSize: 23.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         backgroundColor: appYellow,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: OpenContainer<String>(
//             openBuilder: (_, closeContainer) => SearchPage(closeContainer),
//             onClosed: (res) => setState(() {
//               searchString = res;
//             }),
//             tappable: false,
//             closedBuilder: (_, openContainer) => SearchBar(
//               searchString: searchString,
//               openContainer: openContainer,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SearchBar extends StatelessWidget {
//   const SearchBar({this.searchString, required this.openContainer});

//   final String? searchString;
//   final VoidCallback openContainer;
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 3,
//       borderRadius: BorderRadius.circular(5),
//       child: InkWell(
//         onTap: openContainer,
//         child: Container(
//           padding: EdgeInsets.all(10),
//           color: Colors.white,
//           child: Row(
//             children: [
//               Icon(Icons.search),
//               SizedBox(width: 10),
//               searchString != null
//                   ? Expanded(child: Text(searchString!))
//                   : Spacer(),
//               Icon(Icons.mic),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SearchPage extends StatelessWidget {
//   const SearchPage(
//     this.onClose,
//   );

//   final void Function({String returnValue}) onClose;
//   @override
//   Widget build(BuildContext context) {
//     double ht = MediaQuery.of(context).size.height;
//     double wt = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 2),
//                     spreadRadius: 0,
//                     blurRadius: 1,
//                     color: Colors.black26,
//                   )
//                 ],
//                 color: Colors.white,
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: onClose,
//                   ),
//                   Spacer(),
//                   Icon(Icons.mic),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => onClose(returnValue: 'Flutter'),
//                     child: Text('Search: "Flutter"'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => onClose(returnValue: 'Rabbit'),
//                     child: Text('Search: "Rabbit"'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () => onClose(returnValue: 'What is the Matrix'),
//                     child: Text('Search: "What is the Matrix"'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
