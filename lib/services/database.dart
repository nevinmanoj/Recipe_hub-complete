import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/shared/recipe.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference Usercollection =FirebaseFirestore.instance.collection('userInfo');
  
  Future updateUserName(String Name)async{
    return await Usercollection.doc(uid).set({'Name':Name,},SetOptions(merge: true));
  }

  Future updateUserPhone(String PhoneNumber)async{
    return await Usercollection.doc(uid).set({'PhoneNumber':PhoneNumber,},SetOptions(merge:true));
  }

   
    
  }

  // class RecipeGet{

  //   String RecipeId;
  //   RecipeGet({required this.RecipeId});

  //   Future<recipes> getRecipe() async {
    

  //   final Recipe =await FirebaseFirestore.instance.collection('Recipes').doc(RecipeId).get();

    
  //      int Calories= Recipe.data()!['Calories'];
  //      String Cuisine= Recipe.data()!['Cuisine'];
  //      String Time= Recipe.data()!['Time'];
  //      String Title= Recipe.data()!['Title'];
  //      String img= Recipe.data()!['img'];
  //      List <String> Preparation=Recipe.data()!['Preparation'];
  //      Map <String,String> ingredients =Recipe.data()!['ingre'];


  //      return recipes(Calories:Calories,Cuisine:Cuisine,Time:Time,Title:Title,
  //                       img:img,Preparation:Preparation,ingredients:ingredients) ;

  // }

  // }

  // Future<String> getName() async {
  //   DocumentReference documentReference = Usercollection.doc(uid);
  //   String name="";
  //   await documentReference.get().then((snapshot) {
  //     name = snapshot.data().toString();
  //   });
  //   return name;
  // }
