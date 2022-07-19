

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/screens/home/sideMenu/Favorites.dart';
import 'package:untitled/services/auth.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Colors.dart';
import 'package:untitled/shared/recipe.dart';
import 'sideMenu/profile.dart';
final FirebaseAuth _auth =FirebaseAuth.instance;
final User? user = _auth.currentUser;



class sideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     

    return Drawer(
      
      backgroundColor: Colors.white.withOpacity(0.9),
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            
            
            decoration: BoxDecoration(
              
              
              
                color: appYellow,
                // image: DecorationImage(
                //     fit: BoxFit.fill,
                //     // image: AssetImage('assets/images/cover.jpg')
                //     )
                 ),
            child: Column(
              children: [
                Text( 'Recipe Hub',style: TextStyle(color: Colors.white, fontSize: 25),),
               
              ],
            ),
          ),
          
          ListTile(
            leading: Icon(CupertinoIcons.profile_circled),
            title: Text('Profile'),
            onTap: ()async{
              final curUser =await FirebaseFirestore.instance.collection('userInfo').doc(user!.uid).get();
              String name= curUser.data()!['Name'];
              String phoneNumber=curUser.data()!['PhoneNumber'];
              
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  Profile(name: name,phoneNumber: phoneNumber,)));},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () async {

              List<recipeModel> R=await DatabaseService(uid: user!.uid).getFavoriteList();
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  Favorites(R: R)));

            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signOut();
              },
          ),
          // SizedBox(height: 490,),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: ()  {
            
              },
          ),
        ],
      ),
    );
  }
}