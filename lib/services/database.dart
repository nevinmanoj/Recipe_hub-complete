import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference Usercollection =
      FirebaseFirestore.instance.collection('userInfo');

  Future updateUserName(String Name) async {
    return await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(uid)
        .set({
      'Name': Name,
    }, SetOptions(merge: true));
  }

  Future updateUserPhone(String PhoneNumber) async {
    return await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(uid)
        .set({
      'PhoneNumber': PhoneNumber,
    }, SetOptions(merge: true));
  }

  Future createInventory() async {
    // await FirebaseFirestore.instance.collection('userInfo/inventory').doc(uid).set({categories[i]:{},},SetOptions(merge: true));
    for (int i = 0; i < categories.length; i++) {
      await FirebaseFirestore.instance
          .collection('userInfo/${uid}/inventory')
          .doc(categories[i])
          .set({}, SetOptions(merge: true));
    }
  }

  Future addInventory(Item item) async {
    //  return await FirebaseFirestore.instance.collection('inventory').doc(uid).update();
    await FirebaseFirestore.instance
        .collection('userInfo/${uid}/inventory')
        .doc(item.category)
        .set({
      '${item.name}': [item.qty, item.unit]
    }, SetOptions(merge: true));
  }

  Future createFavorites() async {
    return await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(uid)
        .update({
      'Favorites': [],
    });
  }

  Future updateFavorites(
      {required String RecipeId, required bool isLike}) async {
    // List fav=[RecipeId];
    // return await Usercollection.doc(uid).update({"Favorites": ,},SetOptions(merge:true));
    if (isLike) {
      return await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(uid)
          .update({
        "Favorites": FieldValue.arrayUnion([RecipeId]),
      });
    } else {
      return await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(uid)
          .update({
        "Favorites": FieldValue.arrayRemove([RecipeId])
      });
    }
  }

  // Future isFavorite({required String RecipeId})async{
  //   final user =
  //       await FirebaseFirestore.instance.collection('userInfo').doc(uid).get();
  //       List favorites = user.data()!['Favorites'];
        
  //       bool isLike = favorites.contains(RecipeId);
  //       return isLike;
  // }

  Future getRecipe({required String RecipeId}) async {
    // print(RecipeId);
    final Recipe = await FirebaseFirestore.instance
        .collection('Recipes')
        .doc(RecipeId)
        .get();
    final user =
        await FirebaseFirestore.instance.collection('userInfo').doc(uid).get();

    List favorites = user.data()!['Favorites'];

    bool isLike = favorites.contains(RecipeId);
    // bool isLike=false;
    int Calories = Recipe.data()!['Calories'];
    String Cuisine = Recipe.data()!['Cuisine'];
    String Time = Recipe.data()!['Time'];
    String Title = Recipe.data()!['Title'];
    String img = Recipe.data()!['img'];
    bool isVeg = Recipe.data()!['isVeg'];
    List preparation = Recipe.data()!['Preparation'];
    Map<String, dynamic> ingredients = Recipe.data()!['ingre'];
    return recipeModel(
        calories: Calories,
        cuisine: Cuisine,
        time: Time,
        title: Title,
        img: img,
        preparation: preparation,
        ingredients: ingredients,
        isveg: isVeg,
        RecipeId: RecipeId,
        isLike: isLike);
  }

  Future getFavoriteList() async {
    final user =
        await FirebaseFirestore.instance.collection('userInfo').doc(uid).get();

    List favorites = user.data()!['Favorites'];
    List<recipeModel> fav = [];
    for (int j = 0; j < favorites.length; j++) {
      fav.add(await getRecipe(RecipeId: favorites[j]));
        // fav[j].isLike=true;
    }

    return fav;
  }

  Future deleteItem(
      {required String itemname, required String category}) async {
    await FirebaseFirestore.instance
        .collection('userInfo/${uid}/inventory')
        .doc(category)
        .update({itemname: FieldValue.delete()});
  }

 

  Future<List<bool>> canCook({required var Recipes}) async {

       List<bool> cC=[];
        // QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("userInfo/${uid}/inventory").getDocuments();
        // var list = querySnapshot.docs;
      for(int j=0;j<Recipes.length;j++)
     {
      Map<String, dynamic> ingredients = Recipes[j]['ingre'];
      var keys=ingredients.keys.toList();
      
      for(int i=0;i<keys.length;i++)
        {
        
             var inventory= await FirebaseFirestore.instance
              .collection('userInfo/${uid}/inventory')
              .doc(ingredients[keys[i]][2])
              .get();

              

        }
          if(j%2==0)
          cC.add(true);
          else
          cC.add(false);
      }





      return cC;
    }

}
