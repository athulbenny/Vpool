import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/auth.dart';

class Login extends StatefulWidget {
  const Login({required this.toggleView});
  final Function toggleView;
  static final String id="login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController username1=new TextEditingController();
  TextEditingController passsord1=new TextEditingController();
String error="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: (){exit(0);},),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),toolbarHeight: 70,
        backgroundColor: Colors.green,
          title: Text('Sign in'),
          actions: [
          IconButton(onPressed: (){
    widget.toggleView();
    }, icon: Icon(Icons.person))
   ]
      ),
      body:  Container(
    padding: EdgeInsets.only(
      left: MediaQuery
          .of(context)
          .size
          .height / 70,
      right: MediaQuery
          .of(context)
          .size
          .height / 70,
      top: MediaQuery
          .of(context)
          .size
          .height / 100,),
        child: Form(
        key: _formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children:[
             //const Expanded(flex:1,child: Text("Username",style: TextStyle(fontSize: 18.0,color: Colors.red),)),
              Expanded(flex: 3,
                child: TextField(
                  controller: username1,
                  decoration: const InputDecoration(
                      hintText: 'username',border: OutlineInputBorder()
                  ),
                ),
              ),]),SizedBox(height: 20,),
            Row(children:[
             // Expanded(flex:1,child: Text("Password",style: TextStyle(fontSize: 18.0,color: Colors.red),)),
              Expanded(flex: 3,
                child: TextField(
                  controller: passsord1,obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'password',border: OutlineInputBorder()
                  ),
                ),
              ),]),SizedBox(height: 50,),
            SizedBox(height: MediaQuery.of(context).size.height/50,),
              ElevatedButton(onPressed: ()async{
              if(_formKey.currentState!.validate()){
              dynamic result = await _auth.signInWithEmailandPassword(username1.text,passsord1.text);
              if(result==null){
             setState(() {
             error="sign in failed";
              });
             }
              }}, child: Text('login')),
              SizedBox(height: 12,),
              Text(error),
          ],
        ),
      ),),
    );
  }
}

