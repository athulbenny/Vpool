import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/home/home.dart';
import '../../models/user.dart';



class EmailVerify extends StatefulWidget {
  const EmailVerify({required this.user});
  final NewUser user;

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  bool isVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

      if (isVerified) timer?.cancel();
    });
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Widget build(BuildContext context) => isVerified
      ? Home(user: widget.user)
      : Scaffold(
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
      leading: IconButton(
        icon: Icon(
          Icons.backspace,
        ),
        onPressed: () {
          exit(0);
        },
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(),
      // toolbarHeight: 70,
      backgroundColor: Colors.transparent,
      title: Text(
        'Sign in',
      ),
      elevation: 0,
    ),
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
          //   ),
          //   //child: Image.asset('logo.jpg'),
          // ),
            SingleChildScrollView(
              child: Column(
                children: [ const
                Padding(
                  padding:  EdgeInsets.all(40.0),
                  child: Text(
                    "A verification Email has been sent to your mail",
                    textAlign: TextAlign.center,
                  ),
                ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (canResendEmail == true) {
                            sendVerificationEmail();
                          }
                        },
                        child:
                        Text(
                          "ReSent Email",

                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text(
                        "Cancel",
                      )),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}