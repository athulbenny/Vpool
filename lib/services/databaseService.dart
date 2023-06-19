import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';



class UserDatabaseService {

  //final String adusername;

  //AdminDatabaseService({required this.adusername});

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');


  Future updateOwnerData(String email, String username,
      String phno, String adhar, String vno, String rcbook,
      String licence) async {
    return await _usercollection.doc(email).set({
      "isOwner": "1",
      "username": username,
      'email': email,
      'phno': phno,
      "adhar": adhar,
      "licence": licence,
      "rcbook": rcbook,
      "vehicleno": vno,
    });
  }

  Future updateTravellerData(String email, String username,
      String phno, String adhar) async {
    return await _usercollection.doc(email).set({
      "isOwner": "0",
      "username": username,
      'email': email,
      'phno': phno,
      "adhar": adhar,
    });
  }

  Future updateDualData(String email, String username,
      String phno, String adhar, String vno, String rcbook,
      String licence) async {
    return await _usercollection.doc(email).set({
      "isOwner": "2",
      "username": username,
      'email': email,
      'phno': phno,
      "adhar": adhar,
      "licence": licence,
      "rcbook": rcbook,
      "vehicleno": vno,
    });
  }


  Stream<List<Travellers>> get users {
    return _usercollection.snapshots().map(_usersListFromDatabase);
  }

  List<Travellers> _usersListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("travelling users is" + _user.toString());
      return Travellers(email: _user["email"] ?? "",
          username: _user["username"] ?? "",
          isOwner: _user["isOwner"] ?? "");
    }).toList();
  }


}


class JourneyDatabaseService{

  // String email;
  // JourneyDatabaseService({required this.email});

  final CollectionReference _journeycollection = FirebaseFirestore.instance
      .collection('journey');

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Future addAdminJourneyDataInUser(String email,String startingtime, String endingtime,
      String startingloc, String endingloc, String numseats, String date,
      String desc,String journeyid) async {
    return await _usercollection.doc(email).collection('journey').doc(journeyid).set({
      "email":email,
      "startingtime": startingtime,
      "endingtime": endingtime,
      'date': date,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "numseats": numseats,
      "remseats":numseats,
      "desc": desc,
      "journeyid":journeyid
      //"vehicleno": vno,
    });
  }

  Future addAdminJourneyDataInJourney(String email,String startingtime, String endingtime,
      String startingloc, String endingloc, String numseats, String date,
      String desc,String journeyid) async {
    return await _journeycollection.doc(journeyid).set({
      "email":email,
      "startingtime": startingtime,
      "endingtime": endingtime,
      'date': date,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "numseats": numseats,
      "remseats":numseats,
      "desc": desc,
      "journeyid":journeyid
      //"vehicleno": vno,
    });
  }

  Stream<List<Journey>> get journeylist{
    return _journeycollection.snapshots().map(_journeyListFromDatabase );
  }
  List<Journey> _journeyListFromDatabase(QuerySnapshot snapshot){
    return snapshot.docs.map((usersnapshot){
      Map<String,dynamic> _journeylist = jsonDecode(jsonEncode(usersnapshot.data()));
      print("Journey is " + _journeylist.toString());
      return Journey(startingtime: _journeylist["startingtime"],endingtime: _journeylist["endingtime"]??"",
          date: _journeylist["date"]??"",startingloc: _journeylist["startingloc"]??"",
          endingloc: _journeylist["endingloc"]??"", numseats: _journeylist["numseats"]??"",
          email: _journeylist["email"]??"",remseats: _journeylist["remseats"]??"",journeyid: _journeylist["journeyid"]??"");
    }).toList();
  }

}


class JourneyDriverTravellerConnection{
  String driverid;
  JourneyDriverTravellerConnection({required this.driverid});

  final CollectionReference _journeycollection = FirebaseFirestore.instance
      .collection('journey');
  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Future AddTravellerJourneyData(String email, String startingloc, String endingloc, String numseats,String journeyid) async {
    return await _usercollection.doc(driverid).collection('journey').doc(journeyid).collection('coriders').doc(email).set({
      "email":email,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "numseats": numseats,
      "journeyid":journeyid,
      "driverid":driverid,
    });
  }

  Future AddAdminJourneyData(String email, String startingloc, String endingloc, String numseats,String journeyid) async {
    return await _usercollection.doc(email).collection('journey').doc(journeyid).set({
      "email":email,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "numseats": numseats,
      "journeyid":journeyid,
      "driverid":driverid,
    });
  }

  Future AddAdminJourneyUserData(String date,String email, String startingloc, String endingloc, String numseats,String journeyid) async {
    var em= email+ DateTime.now().toString();
    return await _usercollection.doc(driverid).collection('journeyuser').doc(em).set({
      "email":email,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "numseats": numseats,
      "date":date,
      "journeyid":journeyid,
      "driverid":driverid,
    });
  }

  Future UpdateDriverJourneyDataInJourney(String remseats) async {
    return await _journeycollection.doc(driverid).update({
      "remseats": remseats,
    });
  }

  Future UpdateDriverJourneyDataInUser(String remseats,String journeyid) async {
    return await _usercollection.doc(driverid).collection('journey').doc(journeyid).update({
      "remseats": remseats,
    });
  }

}

///////////////////////////////////////////////////////////////////////////////////////
class AllJourneyTravellerDatabaseService{
    String useremail;
    AllJourneyTravellerDatabaseService({required this.useremail});

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Stream<List<Corider>> get corider {
    return _usercollection.doc(useremail).collection('journey').snapshots().map(_gobacktoDriverListFromDatabase);
  }
  List<Corider> _gobacktoDriverListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("journey travelling users is" + _user.toString());
      return Corider(email: _user["driverid"] ?? "",
          nofseats: _user["numseats"] ?? "");
    }).toList();
  }
}

class AllJourneyDriverDatabaseService{
  String useremail;
  AllJourneyDriverDatabaseService({required this.useremail});

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Stream<List<Cocorider>> get corider {
    return _usercollection.doc(useremail).collection('journeyuser').snapshots().map(_gobacktoDriverListFromDatabase);
  }
  List<Cocorider> _gobacktoDriverListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("journey travelling users is" + _user.toString());
      return Cocorider(email: _user["email"] ?? "",
          date: _user["date"]??"",
          nofseats: _user["numseats"] ?? "");
    }).toList();
  }
}