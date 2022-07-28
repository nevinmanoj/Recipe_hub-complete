import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/database.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class DeleteItem extends StatefulWidget {
  String category;
  String item;
  DeleteItem({required this.category, required this.item});
  @override
  State<DeleteItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DeleteItem> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                    child: AlertDialog(
                        insetPadding: EdgeInsets.fromLTRB(
                          0,
                          0,
                          0,
                          ht * 0.1,
                        ),
                        title: Center(child: Text("Delete Item")),
                        content: Column(children: [
                          Text("Press Confirm to delete the item"),

                          // Row(

                          // )
                          InkWell(
                            child: Container(
                              child: Text("Confirm"),
                            ),
                            onTap: () async {
                              await DatabaseService(uid: user!.uid).deleteItem(
                                  itemname: widget.item,
                                  category: widget.category);
                            },
                          )
                        ])));
              });
        },
        icon: Icon(
          Icons.delete,
        ));
  }
}
