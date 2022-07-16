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
     Map <String,dynamic> ingredients;
     
  cookPage({required this.Calories,required this.Cuisine,required this.Time,required this.Title,
  required this.img,required this.isveg,
   required this.preparation,required this.ingredients
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
           
            SizedBox(height: 15,),
  
            
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: wt,
                // height: double.infinity,
                child: ListView(
                  
                  
                  scrollDirection: Axis.vertical,
                  children:[
                     Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Time to Cook: ${Time}",style:TextStyle(fontSize: 15,fontWeight:FontWeight.w400,)),
                Text("Calories: ${Calories}",style:TextStyle(fontSize: 15,fontWeight:FontWeight.w400,)),

              ],),
            ),
                  Center(child: Text("INGREDIENTS",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,))),
                //ingredients tiles
                  Container(
                            width: wt,
                            child: ListView.builder(
                              itemCount: ingredients.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int ind) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("${ind+1}:${ingredients[ind]}",style: TextStyle(color:Colors.grey[800],fontWeight:FontWeight.w300 ),),
                                );
                              },
                            ),
                          ),
                  Center(child: Text("PREPARATION",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500,))),
                
                  
                   Container(
                            width: wt,
                            child: ListView.builder(
                              itemCount: preparation.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("${index+1}:${preparation[index]}",style: TextStyle(color:Colors.grey[800],fontWeight:FontWeight.w300 ),),
                                );
                              },
                            ),
                          ),
            
                  
                  ]
                  ),
              ),
            )


                
                       
             
            

          ],
        )



      )



    );
  }
}

