import 'package:flutter/material.dart';
import 'package:untitled/screens/home/inventory/inventorySub.dart';
import 'package:untitled/shared/Colors.dart';
class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _inventoryState();
}

class _inventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    List<String> invent = [
  'Fruits',
  'Vegetables',
  'Frozen',
  'Dairy',
  'Grains',
  'Oils And Sauces',
  'Spices',
  'Juices',
  'Eggs',
  'Other',
  'pranoy',
];


    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
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
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 100,
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
                      itemCount: invent.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  on_tap_inventory(foodItem:invent[index]))
                            );

                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            height: 0.1 * ht,
                            margin: const EdgeInsets.only(bottom: 4),
                            // color: Colors.grey,
                           decoration:BoxDecoration(image: DecorationImage(image:NetworkImage("https://i.imgur.com/WmOGEmu.jpg"),fit: BoxFit.cover )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15,0 , 0, 0),
                                      child: Text(invent[index],style: TextStyle(fontWeight:FontWeight.w500,
                                      foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 3
                                           ..color = Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15,0 , 0, 0),
                                      child: Text(invent[index],style: TextStyle(fontWeight:FontWeight.w500,
                                      foreground: Paint()
                                          ..style = PaintingStyle.fill
                                          ..strokeWidth = 1
                                           ..color = Colors.white,
                                      fontSize: 20,),),
                                    ),
                                  ],
                                ),
                                IconButton(onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  on_tap_inventory(foodItem:invent[index]))
                                  );
                                }
                                    , icon: Icon(Icons.keyboard_arrow_right_rounded)),

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


