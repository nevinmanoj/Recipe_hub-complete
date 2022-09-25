import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/screens/home/inventory/updateInvent.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/expFloatingButton.dart';
import 'package:untitled/shared/classes.dart';

import '../../services/database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class cookPage extends StatefulWidget {
  recipeModel currentRecipe;

  cookPage({required this.currentRecipe});

  @override
  State<cookPage> createState() => _cookPageState();
}

void _showToast({required BuildContext context, required String msg}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: appYellow,
      content: Text(msg),
    ),
  );
}

class _cookPageState extends State<cookPage> {
  @override
  Widget build(BuildContext context) {
    var keys = widget.currentRecipe.ingredients.keys.toList();

    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: ExpandableFabClass(
          distanceBetween: 80.0,
          subChildren: [
            ElevatedButton(
              onPressed: () async {
                _showToast(
                    context: context, msg: "Checking inventory..pls wait");
                bool canCook = await DatabaseService(uid: user!.uid)
                    .canCookSingle(
                        ingredients: widget.currentRecipe.ingredients);

                if (canCook) {
                  await DatabaseService(uid: user!.uid).UpdateInventory(
                      ingredients: widget.currentRecipe.ingredients);
                  await DatabaseService(uid: user!.uid)
                      .addHistory(RecipeId: widget.currentRecipe.RecipeId);
                }

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                          child: SizedBox(
                              height: ht * 0.5,
                              child: UpdateInvent(
                                  canCook: canCook,
                                  ingredients:
                                      widget.currentRecipe.ingredients)));
                    });

                print(canCook);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(appYellow)),
              child: Center(child: Text(" Confirm to Update Inventory ")),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: appYellow,
        ),
        body: Container(
            child: Column(
          children: [
            Stack(
              children: [
                InkWell(
                  onDoubleTap: () {
                    setState(() => widget.currentRecipe.isLike =
                        !widget.currentRecipe.isLike);
                    DatabaseService(uid: user!.uid).updateFavorites(
                        RecipeId: widget.currentRecipe.RecipeId,
                        isLike: widget.currentRecipe.isLike);
                  },
                  child: Container(
                    height: 250,
                    width: wt,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        image: DecorationImage(
                            image: NetworkImage(widget.currentRecipe.img),
                            fit: BoxFit.fill)),
                  ),
                ),
                if (widget.currentRecipe.isLike)
                  InkWell(
                    onDoubleTap: (() {
                      setState(() => widget.currentRecipe.isLike =
                          !widget.currentRecipe.isLike);
                      DatabaseService(uid: user!.uid).updateFavorites(
                          RecipeId: widget.currentRecipe.RecipeId,
                          isLike: widget.currentRecipe.isLike);
                    }),
                    child: Center(
                        child: Lottie.network(
                      'https://assets8.lottiefiles.com/packages/lf20_eoism1be.json',
                      repeat: false,
                    )),
                  ),
                Container(
                  width: wt,
                  height: 240,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => widget.currentRecipe.isLike =
                            !widget.currentRecipe.isLike);
                        DatabaseService(uid: user!.uid).updateFavorites(
                            RecipeId: widget.currentRecipe.RecipeId,
                            isLike: widget.currentRecipe.isLike);
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 35,
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(
                              CircleBorder(

                                  // side: BorderSide(color: Colors.red)
                                  )),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              widget.currentRecipe.isLike
                                  ? Colors.red
                                  : Colors.grey),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white.withOpacity(0.1))),
                      //  icon:Icon (Icons.favorite),color:isLike? Colors.red:Colors.grey,iconSize: 30,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Divider(height: ht * 0.05, color: Colors.grey[900]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.currentRecipe.title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        )),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: widget.currentRecipe.isveg
                                  ? AssetImage("assets/veg.png")
                                  : AssetImage("assets/nonVeg.png"))),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
              child: Divider(height: ht * 0.05, color: Colors.grey[900]),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: wt,
                // height: double.infinity,
                child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Color(0xffF8DA19).withOpacity(0.1),
                    child: ListView(scrollDirection: Axis.vertical, children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Time to Cook: ${widget.currentRecipe.time}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                )),
                            Text("Calories: ${widget.currentRecipe.calories}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                      ),
                      Center(
                          child: Text("INGREDIENTS",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ))),
                      //ingredients tiles

                      Container(
                        width: wt,
                        child: ListView.builder(
                          itemCount: widget.currentRecipe.ingredients.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int ind) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${ind + 1}.${keys[ind]}: ${widget.currentRecipe.ingredients[keys[ind]][0]}  ${widget.currentRecipe.ingredients[keys[ind]][1]} ",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w300),
                              ),
                            );
                          },
                        ),
                      ),
                      Center(
                          child: Text("PREPARATION",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ))),

                      Container(
                        width: wt,
                        child: ListView.builder(
                          itemCount: widget.currentRecipe.preparation.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${index + 1}. ${widget.currentRecipe.preparation[index]}",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w300),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            )
          ],
        )));
  }
}
