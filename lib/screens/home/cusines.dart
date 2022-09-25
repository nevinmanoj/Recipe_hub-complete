// ignore_for_file: await_only_futures, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:untitled/screens/home/cook.dart';

import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';

import 'package:untitled/shared/loading.dart';
import 'package:untitled/shared/search.dart';

var defaultS;
bool? veg;
String? sortBy;
var backdropColor = Colors.white.withOpacity(1);

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
bool showFilter = false;
bool ifFiltered = false;

class CuisinesPage extends StatefulWidget {
  String Cuisine;
  CuisinesPage({required this.Cuisine});
  @override
  State<CuisinesPage> createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
  double _height = 0;
  @override
  Widget build(BuildContext context) {
    var temp = FirebaseFirestore.instance
        .collection('Recipes')
        .where('Cuisine', isEqualTo: widget.Cuisine);
    if (!ifFiltered) defaultS = temp.snapshots();

    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: SizedBox(
          width: wt * 0.2,
          child: !showFilter
              ? FloatingActionButton(
                  backgroundColor: appYellow,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  // RoundedRectangleBorder(),
                  child: Text(
                    'Filters',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    setState(() {
                      showFilter = true;

                      backdropColor = Colors.grey.withOpacity(0.4);
                      _height = ht * 0.5;
                    });
                  },
                )
              : Container(),
        ),
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              setState(() {
                veg = null;
                sortBy = null;
                ifFiltered = false;
                // defaultS = FirebaseFirestore.instance
                //     .collection('Recipes')
                //     .where('Cuisine', isEqualTo: widget.Cuisine)
                //     .snapshots();
              });

              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "${widget.Cuisine} Cuisine",
            style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 79, 79, 79)),
          ),
          backgroundColor: appYellow,
        ),
        body: Stack(
          children: [
            CusineStream(
              Cuisine: widget.Cuisine,
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
                    padding: EdgeInsets.fromLTRB(0, ht * 0.02, wt * 0.06, 0),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Row(
                      children: [
                        SizedBox(
                          width: wt * 0.4,
                          // height: ht * 0.3,
                          child: ListTile(
                            title: Text(
                              "Veg",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            leading: Radio(
                              activeColor: Colors.green,
                              value: true,
                              toggleable: true,
                              groupValue: veg,
                              onChanged: (value) {
                                setState(
                                  () {
                                    veg = value as bool?;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wt * 0.5,
                          // height: ht * 0.3,
                          child: ListTile(
                            title: Text(
                              "Non Veg",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            leading: Radio(
                              activeColor: Colors.red[700],
                              value: false,
                              toggleable: true,
                              groupValue: veg,
                              onChanged: (value) {
                                setState(
                                  () {
                                    veg = value as bool?;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.fromLTRB(wt * 0.05, ht * 0.02, 0, 0),
                    child: Text(
                      "Sort By",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return ListTile(
                      title: Text(
                        "Calories: Low to High",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      leading: Radio(
                        activeColor: Colors.black,
                        value: "Calories",
                        toggleable: true,
                        groupValue: sortBy,
                        onChanged: (value) {
                          setState(
                            () {
                              sortBy = value as String?;
                            },
                          );
                        },
                      ),
                    );
                  }),
                  SizedBox(height: ht * 0.19),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 45,
                        width: wt * 0.45,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                veg = null;
                                sortBy = null;
                                temp = FirebaseFirestore.instance
                                    .collection('Recipes')
                                    .where('Cuisine',
                                        isEqualTo: widget.Cuisine);
                                defaultS = temp.snapshots();
                                ifFiltered = false;
                              });
                            },
                            child: Text(
                              'Clear Filters',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(
                                  color: Color(0xFF355764).withOpacity(0.4)),
                              primary: appYellow,
                              // MaterialStateProperty.all<Color>(appYellow)
                            )),
                      ),
                      SizedBox(
                        height: 45,
                        width: wt * 0.45,
                        child: ElevatedButton(
                            onPressed: () {
                              int flag = 0;
                              setState(() {
                                if (veg != null) {
                                  // print('in herer');
                                  temp = temp.where('isVeg', isEqualTo: veg);
                                  // defaultS = temp.snapshots();
                                  flag = 1;
                                }
                                if (sortBy != null) {
                                  temp = temp.orderBy('Calories').limit(3);
                                  // defaultS = temp.snapshots();
                                  flag = 1;
                                }

                                if (flag == 0) {
                                  temp = FirebaseFirestore.instance
                                      .collection('Recipes')
                                      .where('Cuisine',
                                          isEqualTo: widget.Cuisine);
                                  // defaultS = FirebaseFirestore.instance
                                  //     .collection('Recipes')
                                  //     .where('Cuisine',
                                  //         isEqualTo: widget.Cuisine)
                                  //     .snapshots();
                                }
                                defaultS = temp.snapshots();
                                ifFiltered = true;
                                showFilter = false;
                                backdropColor = Colors.white;
                                _height = 0;
                              });
                            },
                            child: Text(
                              'Apply Filters',
                              style: TextStyle(
                                  color: appYellow,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(236, 255, 255, 255)))),
                      ),
                    ],
                  ),
                ]),
              ),
            )
          ],
        ));
  }
}

class CusineStream extends StatefulWidget {
  String Cuisine;
  CusineStream({required this.Cuisine});
  @override
  State<CusineStream> createState() => _CusineStreamState();
}

class _CusineStreamState extends State<CusineStream> {
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: defaultS,
        builder: (context, RecipeSnapshot) {
          var Recipes = RecipeSnapshot.data?.docs;

          if (RecipeSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // if (Recipes == null) {
          //   return LoadHistory();
          // }

          return FutureBuilder(
              future: DatabaseService(uid: user!.uid).canCook(Recipes: Recipes),
              builder: (context, canCookSnapshot) {
                List<bool>? canCook12 = canCookSnapshot.data as List<bool>?;

                if (canCookSnapshot.data == null) {
                  return LoadCusines();
                }
                // if (canCook12 == null) print(canCook12);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBar(Cuisine: widget.Cuisine),
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
                                  recipeModel R = await DatabaseService(
                                          uid: user!.uid)
                                      .getRecipe(
                                          RecipeId: Recipes?[i].id as String);
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
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 0.15 * ht,
                                                  width: wt * 0.30,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            Recipes?[i]['img']),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                        child: !canCook12![i]
                                                            ? Text(
                                                                "No\nIngredients",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255),
                                                                    fontSize:
                                                                        22,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
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
                                                  fontWeight: FontWeight.w600,
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
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'Calories: ${Recipes?[i]['Calories']}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
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
                                                          ? Color(0xFF00923F)
                                                          : Color(0xFFda251e)),
                                                ),
                                                Image(
                                                  image: AssetImage(Recipes?[i]
                                                          ['isVeg']
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
                                          foregroundDecoration: BoxDecoration(
                                              color: canCook12[i]
                                                  ? null
                                                  : Color.fromARGB(
                                                      255, 255, 255, 255),
                                              backgroundBlendMode: canCook12[i]
                                                  ? null
                                                  : BlendMode.saturation),
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
                  ],
                );
              });
        });
  }
}
