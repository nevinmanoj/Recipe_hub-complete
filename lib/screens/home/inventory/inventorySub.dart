import 'package:flutter/material.dart';
import 'package:untitled/shared/Constants.dart';

class on_tap_inventory extends StatelessWidget {
  String foodItem;
   on_tap_inventory({Key? key, required this.foodItem}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    List<String> invent = [
  'Fruits',
  'Vegetables',
  'Frozen',
  'Dairy',
  'Grains',
  'Juices Oils And Sauces',
  'Spices',
  'adarsh',
  
  'akhil',
  'pranoy',
];
    double wt = MediaQuery.of(context).size.width;
    double ht = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: 
      // PreferredSize(
      //   preferredSize: Size.fromHeight(0.0), // here the desired height
      //   child: 
        AppBar(
          backgroundColor:appYellow,
        ),
      // ),
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Container(
            //   width: wt,
            //   color: Colors.green,
            //   height: 0.1 * ht,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       Container(
            //         width: 100,
            //         child: TextButton.icon(
            //           onPressed: () {
            //             Navigator.pop(context);
            //             },
            //           icon: const Icon(Icons.arrow_back_ios),
            //           label: const Text('Back'),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
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
                    child:  Text(
                      foodItem,
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
                        return Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 0.1 * ht,
                          margin: const EdgeInsets.only(bottom: 4),
                          color: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(invent[index]),


                            ],
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




