import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth =FirebaseAuth.instance;
// final Future<UserAccountsDrawerHeader> user = _auth.currentUser();
// UserCredential result = _auth.currentUser;
// User? user = result.user;

bool updateName=false;
bool updatePhone=false;


// String email ="";
  
final _formKeyN = GlobalKey<FormState>();
final _formKeyP = GlobalKey<FormState>();

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

 class _ProfileState extends State<Profile> {
  
  final _formKeyN = GlobalKey<FormState>();
 final _formKeyP = GlobalKey<FormState>();
 
  
  @override
  Widget build(BuildContext context) {
      double wt= MediaQuery.of(context).size.width;
      final User? user = _auth.currentUser;
      String? email123=user?.email;
      String name="";
      String phoneNumber="";
      // name= DatabaseService(uid: user!.uid).getName().toString();


      
    return Scaffold(
    appBar: AppBar(
     backgroundColor: Color(0xFFF8DA19),
    ),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(15, 12,10,0 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Text('NAME',style:TextStyle(color:Colors.grey[400],fontSize: 12)),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            
            children: [
              if(!updateName)Text(name,style: TextStyle(color: Colors.grey[600],fontWeight:FontWeight.w400))
               else Form
               (key: _formKeyN,
                 child: TextFormField(
                   
                  initialValue: name,
                         validator: (value) =>value!.isEmpty?'Name cannot be empty':null,
                         keyboardType: TextInputType.name,
                         textAlign: TextAlign.left,
                         
                      onChanged: (value) {
                      name = value;
                    },
                      decoration: InputDecoration(border: InputBorder.none,
                      constraints: BoxConstraints(maxWidth:0.8*wt),
                     
                      )
                 ),
               )
              ,
              if(!updateName)InkWell(
                    onTap:(){setState(() => updateName=true);
                      
                    },
                    child:Text('EDIT',style: TextStyle(color: Colors.yellow[600],fontSize: 15,fontWeight: FontWeight.bold))
                    ),
            ],
          ),
          if(updateName)Container(child:Column(
      children: [SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            SizedBox(height: 45,width:207,
              child: ElevatedButton(onPressed:()async{
                if(_formKeyN.currentState!.validate()){
                  await DatabaseService(uid: user!.uid).updateUserName(name);
                  setState(() => updateName=false);

                }

              }, child: Text('UPDATE',),
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xEDF2D308)))
              ),
            ),
            SizedBox(height: 45,width:207,
              child: ElevatedButton(onPressed:(){
                setState(() => updateName=false);
            
              }, child: Text('CANCEL',style: TextStyle(color: Color(0xEDF2D308)),),
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(236, 255, 255, 255)))
              ),
            ),



          ],
        ),
      ],
    )

    ),
         
          SizedBox(height: 3,),
          Divider(color: Colors.grey[400],),
          SizedBox(height: 15,),
          Text('PHONE NUMBER',style:TextStyle(color:Colors.grey[400],fontSize: 12)),
          SizedBox(height: 5,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if(!updatePhone)Text(phoneNumber,style: TextStyle(color: Colors.grey[600],fontWeight:FontWeight.w400))
               else Form(
                key: _formKeyP,
                 child: TextFormField(
                   
                  initialValue: phoneNumber,
                   validator: (value) =>value!.isEmpty?'Phone Number cannot be empty':null,
                           
                          keyboardType: TextInputType.number,
                         textAlign: TextAlign.left,
                         
                      onChanged: (value) {
                      phoneNumber = value;
                    },
                      decoration: InputDecoration(border: InputBorder.none,
                      constraints: BoxConstraints(maxWidth:0.8*wt),
                     
                      )
                 ),
               ),
              
              
              if(!updatePhone)InkWell(
                    onTap:(){setState(()=>updatePhone=true);
                      
                    },
                    child:Text('EDIT',style: TextStyle(color: Colors.yellow[600],fontSize: 15,fontWeight: FontWeight.bold))
                    ),
          
            ],
          ),
          if(updatePhone)Container(child:Column(
      children: [SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            SizedBox(height: 45,width:207,
              child: ElevatedButton(onPressed:()async {
                
                if(_formKeyP.currentState!.validate())
                            {

                 await DatabaseService(uid: user!.uid).updateUserPhone(phoneNumber);
                 setState(() => updatePhone=false);
                            }

              }, child: Text('UPDATE',),
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xEDF2D308)))
              ),
            ),
            SizedBox(height: 45,width:207,
              child: ElevatedButton(onPressed:(){
                setState(() => updatePhone=false);
            
              }, child: Text('CANCEL',style: TextStyle(color: Color(0xEDF2D308)),),
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(236, 255, 255, 255)))
              ),
            ),



          ],
        ),
      ],
    )

    ),
    
          SizedBox(height: 3,),
          Divider(color: Colors.grey[400],),
          SizedBox(height: 15,),
          Text('EMAIL',style:TextStyle(color:Colors.grey[400],fontSize: 12)),
          SizedBox(height: 5,),
          Text(email123!,style: TextStyle(color: Colors.grey[600],fontWeight:FontWeight.w400)),
          SizedBox(height: 3,),
          Divider(color: Colors.grey[400],),
   
        ],
      
      ),
    ),

    );
  }
}

