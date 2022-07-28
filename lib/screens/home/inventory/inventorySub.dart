import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/home/inventory/deleteItem.dart';
import 'package:untitled/shared/Constants.dart';
final FirebaseAuth _auth =FirebaseAuth.instance;
final User? user = _auth.currentUser;
class on_tap_inventory extends StatelessWidget {
  String foodItem;
  on_tap_inventory({Key? key, required this.foodItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<String> invent = [
    //   'Fruits',
    //   'Vegetables',
    //   'Frozen',
    //   'Dairy',
    //   'Grains',
    //   'Juices Oils And Sauces',
    //   'Spices',
    //   'adarsh',
    //   'akhil',
    //   'pranoy',
    // ];
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:
         
          AppBar(
        backgroundColor: appYellow,
      ),
      // ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffEAE8E8),
          ),
          margin: EdgeInsets.all(10),
          height: 48,
          width: 420,
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

        Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                foodItem,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              height: 5,
            ),

        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('userInfo/${user!.uid}/inventory').doc(foodItem).snapshots(),
          builder: (context, snapshot) {
            dynamic items;

        
             items = snapshot.data!.data() as Map<String,dynamic>;
          
            
           

            var keys=items.keys.toList();
            
            if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );}
          

          return Expanded(
             
              child: Align(alignment: Alignment.topCenter,
                child: SizedBox(width: wt*0.95,
                  child: ListView.builder(
                    itemCount: items.length,
                   shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                      padding: EdgeInsets.fromLTRB(
                          wt * 0.015, 0, wt * 0.015, ht * 0.009),
                      child: Container(
                        height: ht * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2.5,
                                color: Colors.grey,
                                offset: Offset(0.0, 3.75))
                          ],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(wt * 0.05, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "${keys[i]}    ",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${items[keys[i]][0]}  ${items[keys[i]][1]}",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                DeleteItem(
                                    category: foodItem, item: keys[i]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    },
                  ),
                ),
              ),
            );
        }),
      ]),
    );
  }
}
