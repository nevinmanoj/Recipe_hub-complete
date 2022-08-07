// ignore_for_file: await_only_futures, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/screens/home/side_menu.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';
import 'package:untitled/shared/filter.dart';
import 'package:untitled/shared/loading.dart';
import 'package:untitled/shared/search.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
bool showFilter = false;
bool? isVeg;
var _value;

var curStream;

class CuisinesPage extends StatefulWidget {
  String Cuisine;
  CuisinesPage({required this.Cuisine});
  @override
  State<CuisinesPage> createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
  @override
  Widget build(BuildContext context) {
    var temp = FirebaseFirestore.instance
        .collection('Recipes')
        .where('Cuisine', isEqualTo: widget.Cuisine);
    var defaultS = temp.snapshots();

    // var defaultS = FirebaseFirestore.instance
    //     .collection('Recipes')
    //     .where('Cuisine', isEqualTo: widget.Cuisine)
    //     .snapshots();

    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: SizedBox(
          width: wt * 0.2,
          child: FloatingActionButton(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            // RoundedRectangleBorder(),
            child: Text(
              'Filters',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              // setState(() {
              //   showFilter = !showFilter;
              // });
              //   showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return Center(
              //             child: SizedBox(
              //           height: ht * 0.5,
              //           child: AlertDialog(
              //               insetPadding: EdgeInsets.fromLTRB(
              //                 0,
              //                 0,
              //                 0,
              //                 ht * 0.1,
              //               ),
              //               title: Center(
              //                   child: Text(
              //                 "Select your Filters",
              //                 style: TextStyle(fontWeight: FontWeight.bold),
              //               )),
              //               content: StatefulBuilder(builder:
              //                   (BuildContext context, StateSetter setState) {
              //                 return Column(children: [
              //                   Form(
              //                       child: Column(
              //                     children: <Widget>[
              //                       for (int i = 1; i <= 3; i++)
              //                         ListTile(
              //                           title: Text(
              //                             'Radio $i',
              //                           ),
              //                           leading: Radio(
              //                             activeColor: appYellow,
              //                             value: i,
              //                             groupValue: _value,
              //                             onChanged: i == 5
              //                                 ? null
              //                                 : (value) {
              //                                     print(value);
              //                                     setState(
              //                                       () {
              //                                         _value = value;
              //                                       },
              //                                     );
              //                                   },
              //                           ),
              //                         ),
              //                     ],
              //                   ))
              //                 ]);
              //               })),
              //         ));
              //       });
            },
          ),
        ),
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.fromLTRB(wt * 0.2, 0, 0, 0),
            child: Text(
              "${widget.Cuisine} Cuisine",
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 79, 79, 79)),
            ),
          ),
          backgroundColor: appYellow,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: defaultS,
            builder: (context, RecipeSnapshot) {
              var Recipes = RecipeSnapshot.data?.docs;

              if (RecipeSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return FutureBuilder(
                  future:
                      DatabaseService(uid: user!.uid).canCook(Recipes: Recipes),
                  builder: (context, canCookSnapshot) {
                    List<bool>? canCook12 = canCookSnapshot.data as List<bool>?;

                    if (canCookSnapshot.data == null)
                      // ignore: curly_braces_in_flow_control_structures
                      return LoadCusines();
                    // print(canCook12);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchBar(),

                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     color: Color(0xffEAE8E8),
                        //   ),
                        //   margin: EdgeInsets.all(10),
                        //   height: 48,
                        //   width: wt,
                        //   child: TextField(
                        //     decoration: InputDecoration(
                        //         suffixIcon: Icon(Icons.search),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           borderSide:
                        //               BorderSide(color: Color(0xffEAE8E8)),
                        //         ),
                        //         hintText: 'Search for recipes',
                        //         hintStyle: TextStyle(
                        //           fontSize: 15.0,
                        //           color: Color(0xff707070),
                        //         ),
                        //         border: InputBorder.none),
                        //   ),
                        // ),
                        // Padding(
                        //   padding:  EdgeInsets.fromLTRB(wt*0.095, 0, 0, 10),
                        //   child: Text("${widget.Cuisine} Cuisine",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                        // ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: wt * 0.95,
                              child: ListView.builder(
                                itemCount: Recipes?.length,
                                // itemCount: canCook.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int i) {
                                  return InkWell(
                                    onTap: () async {
                                      recipeModel R =
                                          await DatabaseService(uid: user!.uid)
                                              .getRecipe(
                                                  RecipeId:
                                                      Recipes?[i].id as String);
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
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      //helo

                                      // padding: const EdgeInsets.only(left: 5),
                                      height: 0.17 * ht,
                                      width: wt * 0.8,
                                      margin:
                                          EdgeInsets.only(bottom: wt * 0.025),

                                      child: Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 0.15 * ht,
                                                      width: wt * 0.30,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                Recipes?[i]
                                                                    ['img']),
                                                            fit: BoxFit.fill,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                wt * 0.015,
                                                                0,
                                                                0,
                                                                ht * 0.002),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child:
                                                                !canCook12![i]
                                                                    ? Text(
                                                                        "No\nIngredients",
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255),
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      )
                                                                    : Text("")),
                                                      ),
                                                    ),

                                                    // if(!canCook12![i])
                                                    // Text("No \n Ingredients" )
                                                  ],
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
                                                    Recipes?[i]['Title'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: ht * 0.03,
                                                  ),
                                                  Text(
                                                    'Preparation time: ${Recipes?[i]['Time']}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 138, 137, 137),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Calories: ${Recipes?[i]['Calories']}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  Row(children: [
                                                    Text(
                                                      Recipes?[i]['isVeg']
                                                          ? "VEG "
                                                          : "NON VEG ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Recipes?[i]
                                                                  ['isVeg']
                                                              ? Color(
                                                                  0xFF00923F)
                                                              : Color(
                                                                  0xFFda251e)),
                                                    ),
                                                    Image(
                                                      image: AssetImage(Recipes?[
                                                              i]['isVeg']
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
                                          if (!canCook12[i])
                                            Container(
                                              foregroundDecoration:
                                                  BoxDecoration(
                                                      color: canCook12[i]
                                                          ? null
                                                          : Color.fromARGB(255,
                                                              255, 255, 255),
                                                      backgroundBlendMode:
                                                          canCook12[i]
                                                              ? null
                                                              : BlendMode
                                                                  .saturation),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        // if (showFilter)
                        //   SlidingUpPanel(
                        //     panel: StatefulBuilder(builder:
                        //         (BuildContext context, StateSetter setState) {
                        //       return Form(
                        //           child: Column(
                        //         children: <Widget>[
                        //           for (int i = 1; i <= 3; i++)
                        //             ListTile(
                        //               title: Text(
                        //                 'Radio $i',
                        //               ),
                        //               leading: Radio(
                        //                 activeColor: appYellow,
                        //                 value: i,
                        //                 groupValue: _value,
                        //                 onChanged: i == 5
                        //                     ? null
                        //                     : (value) {
                        //                         print(value);
                        //                         setState(
                        //                           () {
                        //                             _value = value;
                        //                           },
                        //                         );
                        //                       },
                        //               ),
                        //             ),
                        //         ],
                        //       ));
                        //     }),
                        //   )
                      ],
                    );
                  });
            }));
  }
}
