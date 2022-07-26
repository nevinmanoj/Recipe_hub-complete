// ignore_for_file: await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/screens/home/side_menu.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';
class CuisinesPage extends StatefulWidget {
  String Cuisine;
  CuisinesPage({required this.Cuisine});
  @override
  State<CuisinesPage> createState() => _CuisinesPageState();
}

class _CuisinesPageState extends State<CuisinesPage> {
  // List<recipes> recipeList=;
  @override
  Widget build(BuildContext context) {
    double ht=MediaQuery.of(context).size.height;
    double wt=MediaQuery.of(context).size.width;
    return Scaffold(
      
      appBar: AppBar(
        title: Padding(
          padding:  EdgeInsets.fromLTRB(wt*0.22, 0, 0, 0),
          child: Text("${widget.Cuisine} Cuisine",
           style: TextStyle(fontSize: 20.0,
               fontWeight: FontWeight.bold,
               color: Colors.white),
              ),
        ),
        backgroundColor: appYellow,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Recipes').where('Cuisine',isEqualTo: widget.Cuisine).snapshots(),
               builder: (context,RecipeSnapshot){
                var Recipes = RecipeSnapshot.data?.docs;
                
              
                if (RecipeSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
                }
        return Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
               
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffEAE8E8),
              ),
              margin: EdgeInsets.all(10),
              height: 48,
              width: wt,
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xffEAE8E8)),
                    ),
                    hintText: 'Search for recipes',
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xff707070),
                    ),
                    border: InputBorder.none),
              ),
            ),
            // Padding(
            //   padding:  EdgeInsets.fromLTRB(wt*0.095, 0, 0, 10),
            //   child: Text("${widget.Cuisine} Cuisine",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            // ),
      
      
            Expanded(
             
              child: Align(alignment: Alignment.topCenter,
                child: SizedBox(width: wt*0.95,
                  child: ListView.builder(
                    itemCount: Recipes?.length,
                   shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () async {
                        
                           recipeModel R=await DatabaseService(uid:user!.uid).getRecipe(RecipeId:Recipes?[i].id as String) ;
                            
                            Navigator.push(context,MaterialPageRoute(builder: (context) =>  cookPage(currentRecipe:R)));
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.grey.withOpacity(0.15),),borderRadius: BorderRadius.all(Radius.circular(20))),
                            
                          
                          // padding: const EdgeInsets.only(left: 5),
                          height: 0.17 * ht,
                           width: wt*0.8,
                          margin:  EdgeInsets.only(bottom: wt*0.025),
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.fromLTRB(10,0,10,0),
                                child: Container(
                                  
                                  height: 0.15 *ht,
                                  width: wt*0.30,
                                  decoration: BoxDecoration(
                                     image:  DecorationImage(image: NetworkImage(Recipes?[i]['img']),fit: BoxFit.fill,),
                                      borderRadius: BorderRadius.circular(15)
                                ),),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height:ht*0.015 ,),
                                  Text(Recipes?[i]['Title'],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,),),
                                  SizedBox(height:ht*0.03 ,),        
                                  Text('Preparation time: ${Recipes?[i]['Time']}',style: TextStyle(fontSize: 17,color: Color.fromARGB(255, 138, 137, 137),fontWeight: FontWeight.w500,),),
                                  Text('Calories: ${Recipes?[i]['Calories']}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                                  
                                  Row(children:[Text(Recipes?[i]['isVeg']?"VEG ":"!VEG ",style: TextStyle(fontWeight: FontWeight.bold,color: Recipes?[i]['isVeg']?Color(0xFF00923F):Color(0xFFda251e)),),
                                  Image(image: AssetImage(Recipes?[i]['isVeg']?"assets/veg.png":"assets/nonVeg.png"),height: 0.04*ht,width: 0.04*wt,)])
                                  
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
      
          ],
      
      
        );
  }
      )

    );
  }
}