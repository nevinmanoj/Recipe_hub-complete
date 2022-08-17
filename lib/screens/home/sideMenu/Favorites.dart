import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore_for_file: await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/screens/home/side_menu.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class Favorites extends StatefulWidget {
  List<recipeModel> R;
  Favorites({required this.R});
  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // List<recipes> recipeList=;
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favorites",
          style: TextStyle(
            fontSize: 23.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appYellow,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: wt * 0.95,
                child: ListView.builder(
                  itemCount: widget.R.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) {
                    return OpenContainer(
                      transitionDuration: Duration(milliseconds: 600),
                      transitionType: ContainerTransitionType.fade,
                      openBuilder: (context, _) =>
                          cookPage(currentRecipe: widget.R[i]),
                      closedBuilder: ((context, VoidCallback openContainer) =>
                          InkWell(
                            onTap: openContainer,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.15),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),

                              // padding: const EdgeInsets.only(left: 5),
                              height: 0.17 * ht,
                              width: wt * 0.8,
                              margin: EdgeInsets.only(bottom: wt * 0.025),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Container(
                                      height: 0.15 * ht,
                                      width: wt * 0.30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(widget.R[i].img),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: ht * 0.015,
                                      ),
                                      Text(
                                        widget.R[i].title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 21,
                                        ),
                                      ),
                                      SizedBox(
                                        height: ht * 0.03,
                                      ),
                                      Text(
                                        'Preparation time: ${widget.R[i].time}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 138, 137, 137),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Calories: ${widget.R[i].calories}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      Row(children: [
                                        Text(
                                          widget.R[i].isveg ? "VEG " : "!VEG ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: widget.R[i].isveg
                                                  ? Color(0xFF00923F)
                                                  : Color(0xFFda251e)),
                                        ),
                                        Image(
                                          image: AssetImage(widget.R[i].isveg
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
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 
