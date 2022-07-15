

// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/home/cook.dart';
import 'package:untitled/services/auth.dart';
import 'profile.dart';
String name="";

final AuthSerivice _auth = AuthSerivice();
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
              
              
              
                color: Color(0xFFF8DA19),
                // image: DecorationImage(
                //     fit: BoxFit.fill,
                //     // image: AssetImage('assets/images/cover.jpg')
                //     )
                 ),
            child: Column(
              children: [
                Text( 'Recipe Hub',style: TextStyle(color: Colors.white, fontSize: 25),),
                Text(name),
              ],
            ),
          ),
          
          ListTile(
            leading: Icon(CupertinoIcons.profile_circled),
            title: Text('Profile'),
            onTap: () => {Navigator.push(context,MaterialPageRoute(builder: (context) => const Profile()))},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
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