import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/services/databaseService.dart';
import '../models/user.dart';

class AuthService{
  final FirebaseAuth _auth= FirebaseAuth.instance;

  NewUser? _userFromFirebaseUser(User? user){
    return user != null ? NewUser(uid: user.uid, username: user.email??""): null ;
  }

  Stream<NewUser?> get user{
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      //UserCredential====AuthResult,User====FirebaseUser,onAuthSTateChanges====authStateChanges
      User user= result.user!;
      return _userFromFirebaseUser(user);
    }
    catch(e){print(e.toString());
    return null;
    }
  }

  Future signInWithEmailandPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user= result.user!;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailandPasswordtraveller(String email,String password,
      String username,String phno,String adhar) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user= result.user!;
      await UserDatabaseService().updateTravellerData(email, username, phno, adhar);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailandPasswordowner(String email,String password, String username,String phno,
      String adhar,String licence,String rcbook,String vno) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user= result.user!;
      await UserDatabaseService().updateOwnerData(email, username, phno, adhar, vno, rcbook, licence);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailandPassworddual(String email,String password, String username,String phno,
      String adhar,String licence,String rcbook,String vno) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user= result.user!;
      await UserDatabaseService().updateDualData(email, username, phno, adhar, vno, rcbook, licence);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());return null;
    }
  }
}