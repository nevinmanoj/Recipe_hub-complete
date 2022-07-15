import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:untitled/shared/recipe.dart';

import '../../services/database.dart';



class cookPage extends StatelessWidget {
    // recipes currentRecipe;
     int Calories;
     String Cuisine;
     String Time;
     String Title;
     String img;
     bool isveg;
     List preparation;
     
  cookPage({required this.Calories,required this.Cuisine,required this.Time,required this.Title,
  required this.img,required this.isveg,
   required this.preparation
  });
    // cookPage({required this.currentRecipe});
  @override
  Widget build(BuildContext context) {
    


    double ht= MediaQuery.of(context).size.height;
    double wt= MediaQuery.of(context).size.width;
  



    return Scaffold(
      appBar:AppBar(backgroundColor: Color(0xffF8DA19),
      ),
      body: Container(
        child:Column(

          children: [
            Container(height:250,width:wt ,decoration: BoxDecoration(color:Colors.amber,
            image: DecorationImage(image: NetworkImage(img),fit: BoxFit.fill)),),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: Divider(height: ht*0.05,color:Colors.grey[900]),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[ Text(Title,style:TextStyle(fontSize: 30,fontWeight:FontWeight.w500,)),
              Container(height:30,width:30,decoration: BoxDecoration(image: DecorationImage(image: isveg?AssetImage("assets/veg.png"):AssetImage("assets/nonVeg.png"))),
                
              )
              ]),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20,0,15,0),
              child: Divider(height: ht*0.05,color:Colors.grey[900]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,0,30,0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Time to Cook: ${Time}",style:TextStyle(fontSize: 15,fontWeight:FontWeight.w400,)),
                Text("Calories: ${Calories}",style:TextStyle(fontSize: 15,fontWeight:FontWeight.w400,)),

              ],),
            ),
            SizedBox(height: 15,),
            Text("INGREDIENTS",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,)),

            
            //ingredients tiles
            SizedBox(height: 300,),
            Text("PREPARATION",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,)),
            
           


          ],
        )



      )



    );
  }
}

