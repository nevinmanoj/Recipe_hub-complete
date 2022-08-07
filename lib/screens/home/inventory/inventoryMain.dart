import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/home/inventory/addItem.dart';
import 'package:untitled/screens/home/inventory/inventorySub.dart';
import 'package:untitled/shared/Constants.dart';

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _inventoryState();
}

class _inventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          // PreferredSize(
          // preferredSize: Size.fromHeight(0.0), // here the desired height
          // child:
          AppBar(
        backgroundColor: appYellow,
      ),
      // ),
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 20,
            ),
            AddItem(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: const Text(
                      'Your Inventory',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Container(
                    width: wt,
                    child: ListView.builder(
                      itemCount: categories.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => on_tap_inventory(
                                        foodItem: categories[index])));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            height: 0.1 * ht,
                            margin: const EdgeInsets.only(bottom: 4),
                            // color: Colors.grey,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(images[index]),
                                    fit: BoxFit.cover)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 0, 0),
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 3
                                            ..color =
                                                Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 0, 0),
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          foreground: Paint()
                                            ..style = PaintingStyle.fill
                                            ..strokeWidth = 1
                                            ..color = Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  on_tap_inventory(
                                                      foodItem:
                                                          categories[index])));
                                    },
                                    icon: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }
}
