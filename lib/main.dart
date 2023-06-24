import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/screens/wrapper.dart';
import 'package:untitled1/services/auth.dart';
import 'package:untitled1/models/user.dart';



Color topcolor=Colors.red,bottomColor=Colors.red;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: 'AIzaSyDDmABkeycFEBf3XeAirjJRlHS7IYfUBc4',
      appId: '1:607586358441:android:13fd17f9ad35095583c5b8',
      messagingSenderId: '607586358441', projectId: 'miniproject-d04f9'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<NewUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}