
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'authentication/authenticate.dart';
import 'home/home.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser?>(context);
    print(user);
    //final user=null;
    if(user == null){
      print('user is null');
      return Authenticate();
    }else{
      return Home(user: user);
    }
  }
}

