// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:untitled/screens/authenticate/signUp.dart';
import 'package:untitled/services/auth.dart';
import '../../shared/loading.dart';
import'/main.dart';
import 'package:untitled/screens/home/home.dart';
String password1="";
String email1="";
class login extends StatefulWidget {
  final Function toggleView;
  login({ required this.toggleView });
  

  @override
  State<login> createState() => _loginState();
}

final AuthSerivice _auth = AuthSerivice();

class _loginState extends State<login> {
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  bool loading=false;
  String error='';
  @override
  Widget build(BuildContext context) {
    double ht= MediaQuery.of(context).size.height;
    double wt= MediaQuery.of(context).size.width;
    return Scaffold(
      body:
        
         Stack(
           
          children:[
            
             Container(
               child: Positioned(
                 bottom: 20,
                 left: 100,
                 child: Container(
                   height: ht,
                   width: wt,
                       //  alignment: Alignment.centerRight,
                         child: Center(child: RotatedBox(
                         quarterTurns: 1,
                         child: Container(
                  
                  child: Image.asset(
                     fit:BoxFit.fitHeight,
                    "assets/lemon.png"),)))
                  ),
               ),
             ),
             Positioned(
               top: 300,
               left: 55,
               child:Container(
                 height: 450,
                 width: 350,
                 //color: Colors.green,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(70),
                   color: Color.fromARGB(255, 213, 213, 213).withOpacity(0.6),
                   
                 ),
                 child:Center(
                   child:Form(
                    key:_formKey,
                     child: Column(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       
                       children: [
                         SizedBox(height: ht*0.055,),
                         Text(error,style:TextStyle(color:Colors.red,fontSize: 16,fontWeight:FontWeight.bold )),
                         SizedBox(height: ht*0.02,),
                         Lemail(),
                         
                         SizedBox(height: ht*0.02,),
                         
                         Lpass(),
                         
                         SizedBox(height: ht*0.02,),
                         
                         Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [Container(
                           child:Text("Dont have an account?"),
                         ),
                   
                         SizedBox(width: 5,),
                         InkWell(
                          onTap:() { 
                            widget.toggleView();
                            
                            //  Navigator.push(context,MaterialPageRoute(builder: (context) =>signUp()),);
                          },
                           child: Container(
                             child:Text("Sign-up",
                            style:TextStyle(color: Colors.blue[400]))
                           ),
                         )],
                       ),
                         
                         SizedBox(height: ht*0.02,),
                         
                                   
                         SizedBox(width:100,height:50 ,
                         
                         
                           child:
                                ElevatedButton(
                                  
                             onPressed: () async {
                              if(_formKey.currentState!.validate())
                            {
                              setState(()=>loading=true);
                              dynamic result =await _auth.loginWithEmail(email1, password1);
                          
                           if(result==null)
                             {
                              
                              setState(() { 
                                loading=false;
                                error='Could not Login with the given credentials ';});
                             }
                            }
                              
                              
                          // Navigator.push(context,MaterialPageRoute(builder: (context) =>  home()));
                        
                                     },
                             style:ButtonStyle(
                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(70.0),
                                
                             )),
                             backgroundColor: MaterialStateProperty.all<Color>(Color(0xEDF2D308))
                             ),
                             child: Center(child: Text("Log In",
                              style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:16
                              ))),),
                         ),
                   
                         SizedBox(height:20,),
                   
                        //  SizedBox(width:300,height:50 ,
                        //     child:
                        //         ElevatedButton(
                        //      onPressed: ()  async{
                        //       // dynamic result=await _auth.SignInAnon();
                              
                        //   },
                         
                         
                        //      style:ButtonStyle(
                        //        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        //         RoundedRectangleBorder(
                        //            borderRadius: BorderRadius.circular(70.0),
                                   
                         
                        //      )),
                        //      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(237, 85, 85, 84))
                        //      ),
                        //      child: Center(child: Text("Sign in Anonymously",
                        //       style:TextStyle(
                        //         color:Colors.white,
                        //         fontWeight:FontWeight.bold,
                        //         fontSize:16
                        //       ))),),
                        //  ),
                   
                       ],
                       
                     ),
                   )
                 )
               ),
             ),
      
      if(loading)
      Loading(),
        ],
        ),
      

    );
  }
}
class Lemail extends StatefulWidget {
  const Lemail({Key? key}) : super(key: key);

  @override
  State<Lemail> createState() => _emailState();
}

class _emailState extends State<Lemail> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
                       height:50,
                       width:300,
                       decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(70),
                 color: Colors.grey[200]?.withOpacity(0.6),
                 boxShadow:[ 
               BoxShadow(
                  color: Color(0xFFCCCCCC).withOpacity(0.5), //color of shadow
                  spreadRadius: 4, //spread radius
                  blurRadius: 4, // blur radius
                  offset: Offset(6, 4), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
               ),
               //you can set more BoxShadow() here
              ],
    ),
                       child: TextFormField(
                       validator: (value) =>value!.isEmpty?' Email cannot be empty':null,
                       keyboardType: TextInputType.emailAddress,
                       textAlign: TextAlign.center,
                  onChanged: (value) {
                    email1 = value;
                    //Do something with the user input.
                  },
                   decoration: InputDecoration(border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
                   hintText: 'E-Mail',
                   )
               ));
  }
}

class Lpass extends StatefulWidget {
  const Lpass({Key? key}) : super(key: key);

  @override
  State<Lpass> createState() => _passState();
}

class _passState extends State<Lpass> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
                       height:50,
                       width:300,
                       decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(70),
                 color: Color(0xFFEEEEEE).withOpacity(0.6),
                 boxShadow:[ 
               BoxShadow(
                  color: Color(0xFFCCCCCC).withOpacity(0.5), //color of shadow
                  spreadRadius: 1, //spread radius
                  blurRadius: 4, 
                   
                  offset: Offset(4, 4), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
               ),
               //you can set more BoxShadow() here
              ],
               ),
                       child:TextFormField(
                      validator: (value) =>value!.isEmpty?'Enter password':null,
                        
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password1 = value;
                    
                    //Do something with the user input.
                  },
                   decoration: InputDecoration(
                     border: InputBorder.none,
        
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
                   hintText: 'Password',
                   )
               )
                     );
  }
}
// class signuplink extends StatelessWidget {
  
//   signuplink({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [Container(
//                          child:Text("Dont have an account?"),
//                        ),

//                        SizedBox(width: 5,),
//                        InkWell(
//                         onTap:() { 
//                           Widget.toggleView();
                          
//                           //  Navigator.push(context,MaterialPageRoute(builder: (context) =>signUp()),);
//                         },
//                          child: Container(
//                            child:Text("Sign-up",
//                           style:TextStyle(color: Colors.blue[400]))
//                          ),
//                        )],
//                      );
//   }
// }