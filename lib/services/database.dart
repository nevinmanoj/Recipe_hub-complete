import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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

  Future createFavoritesAndHistory() async {
    await FirebaseFirestore.instance.collection('userInfo').doc(uid).update({
      'Favorites': [],
    });

    await FirebaseFirestore.instance.collection('userInfo').doc(uid).update({
      'history': {},
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

  //main algorithm of inventory compare

  Future<List<bool>> canCook({required var Recipes}) async {
    List<bool> cC = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("userInfo/${uid}/inventory")
        .get();
    var inventList = querySnapshot.docs;
    Map<String, int> inventMap = {};
    for (int k = 0; k < inventList.length; k++) inventMap[inventList[k].id] = k;

    //  print(inventMap);
    Map<String, dynamic> inventSub = {};

    for (int j = 0; j < Recipes.length; j++) {
      Map<String, dynamic> ingredients = Recipes[j]['ingre'];
      var keys = ingredients.keys.toList();
      // print('**********${Recipes[j]['Title']}->${keys.length}**********');
      cC.add(true);
      for (int i = 0; i < keys.length; i++) {
        //compare invent.id and ingredients[keys[i]][2]
        var ind = inventList[inventMap[ingredients[keys[i]][2]] as int].data()
            as Map<String, dynamic>;
        // var indKeys=ind.keys;
        // var indItem=keys[i];
        var item = keys[i].toLowerCase();
        var itemQty = ingredients[keys[i]][0];

        // print('${item}=> ${itemQty}<${ind[item]} ');

        if (ind[item] == null) {
          cC[j] = false;
          break;
        }

        var newitemQty;
        //convert tbsppon,etc ->kg,L ingredients[keys[i]][1]
        if (ind[item][1] == 'Kg' || ind[item][1] == 'L') {
          //convert ingre to kg or L
          if (itemQty != null) {
            // print(item);
            newitemQty =
                convertUnits(unit: ingredients[keys[i]][1], qty: itemQty);
          }
        } else {
          newitemQty = itemQty;
        }
        //compare values of invent.id and ingredients[keys[i]][0]
        if (!(newitemQty <= ind[item][0])) {
          //  print(item);
          cC[j] = false;
          break;
        }
      }
    }

    return cC;
  }

  Future canCookSingle({required Map<String, dynamic> ingredients}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("userInfo/${uid}/inventory")
        .get();
    var inventList = querySnapshot.docs;
    Map<String, int> inventMap = {};
    for (int k = 0; k < inventList.length; k++) inventMap[inventList[k].id] = k;

    //  print(inventMap);
    Map<String, dynamic> inventSub = {};

    var keys = ingredients.keys.toList();

    for (int i = 0; i < keys.length; i++) {
      //compare invent.id and ingredients[keys[i]][2]
      var ind = inventList[inventMap[ingredients[keys[i]][2]] as int].data()
          as Map<String, dynamic>;
      // var indKeys=ind.keys;
      // var indItem=keys[i];
      var item = keys[i].toLowerCase();
      var itemQty = ingredients[keys[i]][0];

      // print('${item}=> ${itemQty}<${ind[item]} ');

      if (ind[item] == null) {
        return false;
      }

      var newitemQty;
      //convert tbsppon,etc ->kg,L ingredients[keys[i]][1]
      if (ind[item][1] == 'Kg' || ind[item][1] == 'L') {
        //convert ingre to kg or L
        if (itemQty != null) {
          // print(item);
          newitemQty =
              convertUnits(unit: ingredients[keys[i]][1], qty: itemQty);
        }
      } else {
        newitemQty = itemQty;
      }
      //compare values of invent.id and ingredients[keys[i]][0]
      if (!(newitemQty <= ind[item][0])) {
        return false;
      }
    }

    return true;
  }

  Future UpdateInventory({required Map<String, dynamic> ingredients}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("userInfo/${uid}/inventory")
        .get();
    var inventList = querySnapshot.docs;
    Map<String, int> inventMap = {};
    for (int k = 0; k < inventList.length; k++) inventMap[inventList[k].id] = k;
    Map<String, dynamic> inventSub = {};

    var keys = ingredients.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      var ind = inventList[inventMap[ingredients[keys[i]][2]] as int].data()
          as Map<String, dynamic>;
      // var indKeys=ind.keys;
      // var indItem=keys[i];
      var item = keys[i].toLowerCase();
      var itemQty = ingredients[keys[i]][0];
      var newitemQty;

      if (ind[item][1] == 'Kg' || ind[item][1] == 'L') {
        //convert ingre to kg or L
        if (itemQty != null) {
          // print(item);
          newitemQty =
              convertUnits(unit: ingredients[keys[i]][1], qty: itemQty);
        }
      } else {
        newitemQty = itemQty;
      }

      newitemQty = ind[item][0] - newitemQty;
      newitemQty = double.parse(newitemQty.toStringAsFixed(4));
      if (newitemQty > 0) {
        await FirebaseFirestore.instance
            .collection('userInfo/${uid}/inventory')
            .doc(ingredients[keys[i]][2])
            .set({
          '${item}': [newitemQty, ind[item][1]]
        }, SetOptions(merge: true));
      } else {
        await FirebaseFirestore.instance
            .collection('userInfo/${uid}/inventory')
            .doc(ingredients[keys[i]][2])
            .update({'${item}': FieldValue.delete()});
      }
    }
  }

  Future addHistory({required String RecipeId}) async {
    DateTime currentPhoneDate = DateTime.now();
    await FirebaseFirestore.instance.collection('userInfo').doc(uid).set({
      'history': {"$currentPhoneDate": RecipeId},
    }, SetOptions(merge: true));
  }

  Future getHistory() async {
    final userinfo =
        await FirebaseFirestore.instance.collection('userInfo').doc(uid).get();
    Map<String, dynamic> history =
        userinfo.data()!['history'] as Map<String, dynamic>;
    var keys = history.keys.toList();
    keys.sort((a, b) => b.compareTo(a));

    int length = min(10, keys.length);
    List<recipeModel> his = [];
    List<String> dates = [];
    List<String> Times = [];
    for (int i = 0; i < length; i++) {
      his.add(await getRecipe(RecipeId: history[keys[i]]));
      var formattedDate = DateFormat.yMMMd().format(DateTime.parse(keys[i]));
      var formattedTime = DateFormat('kk:mm a').format(DateTime.parse(keys[i]));
      dates.add(formattedDate);
      Times.add(formattedTime);
    }
    var result = [his, dates, Times];
    return result;
  }
}

double convertUnits({required String unit, required dynamic qty}) {
  unit = unit.toLowerCase();
  var newQty = qty;
  if (qty.runtimeType != double) newQty = qty.toDouble();

  if (unit == 'teaspoon' || unit == 'teaspoons') {
    newQty = newQty * 0.00492892;
  } else if (unit == 'tablespoon' || unit == 'tablespoons') {
    newQty = newQty * 0.0147868;
  } else if (unit == 'cup' || unit == 'cups') {
    newQty = newQty * 0.236588;
  } else if (unit == 'g') {
    newQty = newQty * 0.001;
  } else if (unit == 'Kg' || unit == 'L' || unit == 'kg' || unit == 'l') {
    newQty = newQty * 1;
  } else {
    print("passed unit error");
    return -1;
  }
  return newQty;
}

double dp(double val, int places) {
  num mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}
