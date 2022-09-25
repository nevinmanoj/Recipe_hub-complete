import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class SearchBarScreen extends StatefulWidget {
  String Cuisine;
  SearchBarScreen({required this.Cuisine});

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("widget.title"),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(Cuisine: widget.Cuisine),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: searchBar(Cuisine: widget.Cuisine));
  }
}

class searchBar extends StatelessWidget {
  String Cuisine;
  searchBar({required this.Cuisine});
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wt = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(Cuisine: Cuisine),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffEAE8E8),
        ),
        margin: EdgeInsets.all(10),
        height: 48,
        width: wt,
        child: Padding(
          padding: EdgeInsets.fromLTRB(wt * 0.025, 0, wt * 0.025, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search for Recipes",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xff707070),
                ),
              ),
              Icon(Icons.search)
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  String Cuisine;
  CustomSearchDelegate({required this.Cuisine});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var DataStream;

    if (Cuisine == "") {
      DataStream = FirebaseFirestore.instance.collection('Recipes').snapshots();
    } else {
      DataStream = FirebaseFirestore.instance
          .collection('Recipes')
          .where('Cuisine', isEqualTo: Cuisine)
          .snapshots();
    }
    return StreamBuilder<QuerySnapshot>(
      stream: DataStream,
      builder: (context, snapshot) {
        var Recipes = snapshot.data?.docs;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<String> RList = [];
        List<String> RidList = [];
        int i = 0;
        for (i = 0; i < Recipes!.length; i++) {
          RList.add(Recipes[i]['Title']);
          RidList.add(Recipes[i].id);
        }

        List matchQuery = [];
        // List<String> matchQuery = [];
        for (i = 0; i < RList.length; i++) {
          if (RList[i].toLowerCase().contains(query.toLowerCase())) {
            matchQuery.add(i);
          }
        }

        return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            var result = RList[matchQuery[index]];
            return InkWell(
              onTap: () async {
                recipeModel R = await DatabaseService(uid: user!.uid).getRecipe(
                    RecipeId: Recipes[matchQuery[index]].id as String);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => cookPage(currentRecipe: R)));
              },
              child: ListTile(
                title: Text(result),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var DataStream;

    if (Cuisine == "") {
      DataStream = FirebaseFirestore.instance.collection('Recipes').snapshots();
    } else {
      DataStream = FirebaseFirestore.instance
          .collection('Recipes')
          .where('Cuisine', isEqualTo: Cuisine)
          .snapshots();
    }
    return StreamBuilder<QuerySnapshot>(
      stream: DataStream,
      builder: (context, snapshot) {
        var Recipes = snapshot.data?.docs;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<String> RList = [];
        List<String> RidList = [];
        int i = 0;
        for (i = 0; i < Recipes!.length; i++) {
          RList.add(Recipes[i]['Title']);
          RidList.add(Recipes[i].id);
        }

        List matchQuery = [];
        // List<String> matchQuery = [];
        for (i = 0; i < RList.length; i++) {
          if (RList[i].toLowerCase().contains(query.toLowerCase())) {
            matchQuery.add(i);
          }
        }

        return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            var result = RList[matchQuery[index]];
            return InkWell(
              onTap: () async {
                recipeModel R = await DatabaseService(uid: user!.uid).getRecipe(
                    RecipeId: Recipes[matchQuery[index]].id as String);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => cookPage(currentRecipe: R)));
              },
              child: ListTile(
                title: Text(result),
              ),
            );
          },
        );
      },
    );
  }
}
