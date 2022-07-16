import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/screens/home/side_menu.dart';
import 'package:untitled/services/auth.dart';
import 'package:untitled/shared/recipe.dart';



class home extends StatelessWidget {
  String RecipeId="u3bKB7glVBnYSaX5KDSC";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:sideMenu(),
      appBar: AppBar(
        // title: Text('Recipe Hub'),
        

        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.black,
              ))
        ],

        backgroundColor: Color(0xffF8DA19),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffEAE8E8),
                ),
                margin: EdgeInsets.all(10),
                height: 48,
                width: 390,
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xffEAE8E8)),
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xff707070),
                      ),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      children: [
                        InkWell(
                          onTap: ()async{
                            final Recipe =await FirebaseFirestore.instance.collection('Recipes').doc(RecipeId).get();

    
                             int Calories= Recipe.data()!['Calories'];
                             String Cuisine= Recipe.data()!['Cuisine'];
                             String Time= Recipe.data()!['Time'];
                             String Title= Recipe.data()!['Title'];
                             String img= Recipe.data()!['img'];
                             bool isVeg=Recipe.data()!['isVeg'];
                             List preparation =Recipe.data()!['Preparation'];
                             Map <String,dynamic> ingredients=Recipe.data()!['ingre'];
                             print(ingredients);
                             

                            //  recipes curRecipe=recipes(Calories: Calories,Cuisine: Cuisine,Time: Time,Title: Title,)

                            Navigator.push(context,MaterialPageRoute(builder: (context) =>  cookPage(Cuisine: Cuisine,Calories: Calories,
                            Time: Time,Title: Title,img: img,isveg: isVeg,
                            preparation: preparation,ingredients: ingredients,
                            )));
                            },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: new DecorationImage(
                                    image: AssetImage('assets/indian.jpg'),
                                    // Text('indian'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Text("Indian",
                                // style: GoogleFonts.dosis(fontSize: 20),
                                // style: TextStyle(fontFamily: ''),
                                style: TextStyle(
                                  // fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ))),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: new DecorationImage(
                                  image: AssetImage('assets/american.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(height: 5),
                        Center(
                            child: Text("American",
                                style: TextStyle(
                                  // fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ))),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: new DecorationImage(
                                  image: AssetImage('assets/chinese.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(height: 5),
                        Center(
                            child: Text("Chinese",
                                style: TextStyle(
                                  // fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ))),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: new DecorationImage(
                                  image: AssetImage('assets/italian.jpeg'),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(height: 5),
                        Center(
                            child: Text("Italian",
                                style: TextStyle(
                                  // fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )
                                // style: TextStyle(fontFamily: 'Dosis', fontSize: 20),
                                )),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: new DecorationImage(
                                  image: AssetImage('assets/japanese.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text("Japanese",
                              style: TextStyle(
                                // fontSize: 13,
                                fontWeight: FontWeight.w500,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView(children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 375.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: [
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/chef.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/recipes.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/buddhabowl.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/dalgona.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage('assets/brown.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 15,
                ),
                width: double.infinity,
                height: 300,
                // margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xffF8DA19),
                ),
                child: Column(
                  children: [
                    Text(
                      "Recently Cooked!",
                      // textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                // margin: EdgeInsets.only(
                                //   top: 40,
                                //   right: 50,
                                // ),
                                width: 135,
                                height: 135,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: new DecorationImage(
                                        image: AssetImage('assets/indian.jpg'),
                                        // Text('indian'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Recent 1",
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                // margin: EdgeInsets.only(
                                //   top: 40,
                                //   right: 70,
                                // ),
                                width: 135,
                                height: 135,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    image: new DecorationImage(
                                        image: AssetImage('assets/indian.jpg'),
                                        // Text('indian'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Recent 2"),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
