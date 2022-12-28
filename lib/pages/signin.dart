import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
 

TextEditingController _emailcontroller = TextEditingController();
TextEditingController _passwordcontroller = TextEditingController();
TextEditingController _confirmpasswordcontroller = TextEditingController();
TextEditingController _phonecontroller = TextEditingController();

Widget _buildInput({ required String label,required TextEditingController controller,required bool obscureText,required String? validate(String? s),required Function onTap}){
  return
  Container(
    height: 60,
    width: 300,
    // decoration: BoxDecoration(
    //   border: Border.all(color: Colors.amber,width: 1),
    //   borderRadius: BorderRadius.circular(10)
    // ),
   child:Padding(
       padding: const EdgeInsets.only(left: 8,right: 8),
       child: 
      TextFormField(
        validator: validate,
        cursorColor: Colors.amber,
        cursorHeight: 20,
         style: TextStyle(color: Colors.grey.shade600),
        controller: controller,
        obscureText: obscureText,
        onEditingComplete: onTap(),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),

          label: Text(
            label,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 15
              ),
              ),
          ),
          )));
}

  @override
  Widget build(BuildContext context) {
     final height=MediaQuery.of(context).size.height;
      final width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.amber,
      
      body: SafeArea(
        child: Container(
          child: Stack(
            children:[ Column(children: [
              Container(color: Colors.amber,height: height*0.3,width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,top: 65),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text("Signup",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 27),),
                    SizedBox(height: 10,),
                    Text("Get started with new account",style:TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              ),
              Container(color: Colors.white,height: height*0.6419,width: width,
              child: Padding(
                padding: EdgeInsets.only(top: 480),
                child: Column(
                  children: [
                    Icon(Icons.android,color: Colors.amber,size: 55,),
                    Text("©2022 Darshankumar vanol",style: TextStyle(color: Colors.grey.shade400),)
                  ],
                ))
              
              ,)
            ],),
            Positioned(
              left: width*0.1,
              top: height*0.2,
              child: Form(
                key: _formkey,
                child: Container(
                    
                  height: height*0.47,
                  width: width*0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
              
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2,2),
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                        spreadRadius: 1
                      
                    )],
                  ),
                  child: Column(children: [
                    SizedBox(height: 20,),
                    _buildInput(label: "Email",obscureText: false,onTap: (){}
                    ,validate: (String? val){
                      if(val!.isEmpty || val==null){
                        return "* required";
                      }
                    },controller: _emailcontroller),
                    SizedBox(height: 15,),
                   _buildInput(label: "Password",obscureText: true,onTap: (){},validate: (String? val){
                      if(val!.isEmpty || val==null){
                        return "* required";
                      }
                    },controller: _passwordcontroller),
                    SizedBox(height: 15,),
                     _buildInput(label: "Confirm Password",obscureText: true,onTap: (){},validate: (String? val){
                      if(val!.isEmpty || val==null){
                        return "* required";
                      }
                    },controller: _confirmpasswordcontroller),
                    SizedBox(height: 15,),
                    _buildInput(label: "Phone Number",obscureText: false,onTap: (){},validate: (String? val){
                      if(val!.isEmpty || val==null){
                        return "* required";
                      }
                    },controller: _phonecontroller),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        if(_formkey.currentState!.validate()){
                          print("Validated");
                        }else{
                          print("Invalid");
                        }

                      }, 
                      child: Text("SIGN UP",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.amber),
                        fixedSize: MaterialStatePropertyAll(Size(200,40)),
                        
                        ),
                        )
                  ]),
                  ),
              ),
            )
            ]
          ) 
          ),
      ),
    );
  }
}