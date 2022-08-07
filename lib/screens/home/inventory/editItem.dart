import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/database.dart';
import 'package:untitled/shared/Constants.dart';
import 'package:untitled/shared/classes.dart';

String newUnit = units[0];
String qty = "";
double quantity = 0;

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;

class EditItem extends StatefulWidget {
  String category;
  String item;
  EditItem({required this.category, required this.item});
  @override
  State<EditItem> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditItem> {
  final _formKey = GlobalKey<FormState>();
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
                    child: SizedBox(
                  height: ht * 0.7,
                  child: AlertDialog(
                    insetPadding: EdgeInsets.fromLTRB(
                      0,
                      0,
                      0,
                      ht * 0.1,
                    ),
                    title: Center(child: Text("Enter New Quantity ")),
                    content: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text("Item Name: ${widget.item}"),
                            ItemQuantity(),
                            SizedBox(
                              width: 170,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    quantity = double.parse(qty);

                                    Item I = Item(
                                        name: widget.item,
                                        qty: quantity,
                                        unit: newUnit,
                                        category: widget.category);
                                    final r =
                                        await DatabaseService(uid: user!.uid)
                                            .addInventory(I);

                                    Navigator.pop(context);
                                  }
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            appYellow)),
                                child: Center(
                                    child: Text("Update",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                              ),
                            ),
                          ],
                        )),
                  ),
                ));
              });
        },
        icon: Icon(
          color: appYellow,
          Icons.edit,
        ));
  }
}

class ItemQuantity extends StatefulWidget {
  const ItemQuantity({Key? key}) : super(key: key);

  @override
  State<ItemQuantity> createState() => _ItemQuantityState();
}

class _ItemQuantityState extends State<ItemQuantity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 215,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200]?.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFCCCCCC).withOpacity(0.5), //color of shadow
                // spreadRadius: 4, blurRadius: 4,
                // offset: Offset(6, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextFormField(
              onChanged: (value) {
                qty = value;
              },
              validator: (value) =>
                  value!.isEmpty ? 'quantity must not be null' : null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
                hintText: 'Quantity',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 60,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200]?.withOpacity(0.6),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFCCCCCC).withOpacity(0.5), //color of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: DropdownButtonFormField<String>(
              value: units[0],
              validator: (value) => value!.isEmpty
                  ? ' Must select a Unit of measurementfor item'
                  : null,
              decoration: InputDecoration(border: InputBorder.none),
              hint: Text(
                "Unit",
                style: TextStyle(color: Colors.grey.withOpacity(0.8)),
              ),
              onChanged: (Value) {
                setState(() {
                  newUnit = Value!;
                });
              },
              items: units.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
}
