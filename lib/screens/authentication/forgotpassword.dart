import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';


///page for implementing forget password
class ForgotPassWord extends StatefulWidget {
  ForgotPassWord({Key? key}) : super(key: key);

  @override
  State<ForgotPassWord> createState() => _ForgotPassWordState();
  final FirebaseAuth auth = FirebaseAuth.instance;
}

class _ForgotPassWordState extends State<ForgotPassWord> {
  @override
  var email_cont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;

    final AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 65,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black54, // shadow color
                    blurRadius: 20, // shadow radius
                    offset: Offset(5, 5), // shadow offset
                    spreadRadius:
                    0.1, // The amount the box should be inflated prior to applying the blur
                    blurStyle: BlurStyle.normal // set blur style
                ),
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.cyan, Colors.green])),
        ),
        leading: BackButton(),
        centerTitle: true,
        shape: const RoundedRectangleBorder(),
        // toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        title: Text(
          'Sign in',
        ),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height/3,
              //   width: MediaQuery.of(context).size.width/2,
              //   child: Image.network(logoLink,
              //     headers: {'Access-Control-Allow-Origin':'*'},
              //     loadingBuilder: (context,child,loadingProgress){
              //       if(loadingProgress==null){return child;}
              //       return Text("");
              //     },errorBuilder: (context,error,stackTrace){
              //       return Text("");
              //     },
              //   ),                //child: Image.asset('logo.jpg'),
              // ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: ht * 0.05),
                    Text(
                      ' Enter your registered email id',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(width: MediaQuery.of(context).size.width/2,
                        child: TextFormField(
                          style: TextStyle(),
                          controller: email_cont,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(),
                            hintText: 'EmailID',hintStyle: TextStyle(color: Colors.black87),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)), //////// HERE
                          ),
                          onPressed: () async {
                            await _authService.resetPassword(
                                email_cont.text.trim(), context);
                          },
                          child: Text(
                            "Submit",
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
