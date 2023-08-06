import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

///calss holds all the databse services

class UserDatabaseService {

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Future updateOwnerData(String email, String username,
      String phno, String adhar, String vno, String rcbook,
      String licence,String vehtype) async {
    return await _usercollection.doc(email).set({
      "isOwner": "1",
      "username": username,
      'email': email,
      'phno': phno,
      "adhar": adhar,
      "licence": licence,
      "rcbook": rcbook,
      "vehicleno": vno,
      "vehicletype":vehtype,
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
      String licence,String vehtype) async {
    return await _usercollection.doc(email).set({
      "isOwner": "2",
      "username": username,
      'email': email,
      'phno': phno,
      "adhar": adhar,
      "licence": licence,
      "rcbook": rcbook,
      "vehicleno": vno,
      "vehicletype":vehtype,
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
          vehicleno: _user["vehicleno"]??"",
          isOwner: _user["isOwner"] ?? "",
      vehicletype: _user["vehicletype"]??"");
    }).toList();
  }

}


class JourneyDatabaseService{

  final CollectionReference _journeycollection = FirebaseFirestore.instance
      .collection('journey');

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Future journeydltoptions(String journeyid) async{
    return await _journeycollection.doc(journeyid).delete();
  }

  Future addAdminJourneyDataInUser(String email,String startingtime, String endingtime,
      String startingloc, String endingloc, String numseats, String date,
      String desc,String journeyid,String slat,String slong,String elat,String elong,String price) async {
    return await _usercollection.doc(email).collection('journey').doc(journeyid).set({
      "email":email,
      "startingtime": startingtime,
      "endingtime": endingtime,
      'date': date,
      "price":price,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "startlat":slat,
      "startlong":slong,
      "endlat":elat,
      "endlong":elong,
      "numseats": numseats,
      "remseats":numseats,
      "journeyid":journeyid,
      "isEnd":"false",
      "isleaved":"false",
      "isjoined":"false"
    });
  }

  Future addAdminJourneyDataInJourney(String email,String startingtime, String endingtime,
      String startingloc, String endingloc, String numseats, String date,
      String desc,String journeyid,String slat,String slong,String elat,
      String elong,String price,String numpl,String vtype) async {
    return await _journeycollection.doc(journeyid).set({
      "email":email,
      "startingtime": startingtime,
      "endingtime": endingtime,
      'date': date,
      "price":price,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "numseats": numseats,
      "remseats":numseats,
      "startlat":slat,
      "startlong":slong,
      "endlat":elat,
      "endlong":elong,
      "desc": desc,
      "journeyid":journeyid,
      "vehicleno":numpl,
      "vehicletype":vtype
    });
  }

  Stream<List<Journey>> get journeylist{
    return _journeycollection.snapshots().map(_journeyListFromDatabase );
  }
  List<Journey> _journeyListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _journeylist = jsonDecode(
          jsonEncode(usersnapshot.data()));
      print("Journey is " + _journeylist.toString());
      return Journey(startingtime: _journeylist["startingtime"],
          endingtime: _journeylist["endingtime"] ?? "",
          date: _journeylist["date"] ?? "",
          startingloc: _journeylist["startingloc"] ?? "",
          endingloc: _journeylist["endingloc"] ?? "",
          numseats: _journeylist["numseats"] ?? "",
          email: _journeylist["email"] ?? "",
          price: _journeylist["price"]??"",
          remseats: _journeylist["remseats"] ?? "",
          vehicleno: _journeylist["vehicleno"]??"",
          vehicletype: _journeylist["vehicletype"]??"",
          journeyid: _journeylist["journeyid"] ?? "");
    }).toList();
  }

}


class JourneyDriverTravellerConnection {
  String driverid;

  JourneyDriverTravellerConnection({required this.driverid});

  final CollectionReference _journeycollection = FirebaseFirestore.instance
      .collection('journey');
  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Future AddTravellerJourneyData(String date,String email, String startingloc,
      String endingloc, String numseats, String journeyid,
      String slat,String slong,String elat,String elong,) async {
    return await _usercollection.doc(driverid).collection('journey').doc(
        journeyid).collection('coriders').doc(email).set({
      "date":date,
      "email": email,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "startlat":slat,
      "startlong":slong,
      "endlat":elat,
      "endlong":elong,
      "numseats": numseats,
      "journeyid": journeyid,
      "driverid": driverid,
      "isjoined":"false",
      "isleaved":"false",
    });
  }

  Future AddAdminJourneyData(String date,String email, String startingloc, String endingloc,
      String numseats, String journeyid, String startingtime, String endingtime,String vehicleno) async {
    return await _usercollection.doc(email).collection('journey')
        .doc(journeyid)
        .set({
      "date": date,
      "email": email,
      "startingtime":startingtime,
      "endingtime":endingtime,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "numseats": numseats,
      "journeyid": journeyid,
      "driverid": driverid,
      "vehicleno":vehicleno,
      "isEnd":"false",
      "isstart":"false",
    });
  }

  Future AddAdminJourneyUserData(String date, String email, String startingloc,
      String endingloc,
      String numseats, String journeyid, String slat, String slong, String elat,
      String elong) async {
    return await _usercollection.doc(driverid).collection('journeyuser').doc(
        journeyid).set({
      "email": email,
      'startingloc': startingloc,
      "endingloc": endingloc,
      "startlat": slat,
      "startlong": slong,
      "endlat": elat,
      "endlong": elong,
      "numseats": numseats,
      "date": date,
      "journeyid": journeyid,
      "driverid": driverid,
    });
  }

  Future UpdateDriverJourneyDataInJourney(String remseats,
      String journeyid) async {
    return await _journeycollection.doc(journeyid).update({
      "remseats": remseats,
    });
  }

  Future UpdateDriverJourneyDataInUser(String remseats,
      String journeyid) async {
    return await _usercollection.doc(driverid).collection('journey').doc(
        journeyid).update({
      "remseats": remseats,
    });
  }

}

class AllJourneyTravellerDatabaseService {
  String useremail;

  AllJourneyTravellerDatabaseService({required this.useremail});

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Stream<List<Rider>> get corider {
    return _usercollection.doc(useremail).collection('journey').snapshots().map(
        _gobacktoDriverListFromDatabase);
  }

  List<Rider> _gobacktoDriverListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("journey travelling users is" + _user.toString());
      return Rider(email: _user["email"] ?? "",
          nofseats: _user["numseats"] ?? "",
          date: _user["date"] ?? "",
          endloc: _user["endingloc"] ?? "",
          startloc: _user["startingloc"] ?? "",
          journeyid: _user["journeyid"] ?? "",
          isstart: _user["isstart"]??"",
          isnotified: _user["isnotified"]??"",
          driverid: _user["driverid"]??"",
          otp: _user["otp"]??"",
          isEnd: _user["isEnd"]??"",
          startingtime: _user["startingtime"]??"",
          endingtime: _user["endingtime"]??"",
          vehicleno: _user["vehicleno"]??"",
          currentlocation: _user["currentlocation"]??"",
          distance: _user["distance"]??"");
    }).toList();
  }

  Future updateDriverJSStartData(String journeyid)async{
    return await _usercollection.doc(useremail).collection('journey').doc(journeyid).update(
      {"isstart":"true","isEnd":"false"});
  }

  Future updateDriverJEStartData(String journeyid)async{
    return await _usercollection.doc(useremail).collection('journey').doc(journeyid).update(
        {"isEnd":"true",});
  }

}

class AllJourneyDriverDatabaseService {
  String useremail;

  AllJourneyDriverDatabaseService({required this.useremail});

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Stream<List<Travel>> get corider {
    return _usercollection.doc(useremail).collection('journey')
        .snapshots()
        .map(_gobacktoDriverListFromDatabase);
  }

  List<Travel> _gobacktoDriverListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("journey travelling users is" + _user.toString());
      return Travel(email: _user["driverid"] ?? "",
          startingtime: _user["startingtime"]??"",
          endingtime: _user["endingtime"]??"",
          nofseats: _user["numseats"] ?? "",
          date: _user["date"] ?? "",
          endloc: _user["endingloc"] ?? "",
          startloc: _user["startingloc"] ?? "",
          slat: _user["startlat"] ?? "",
          slong: _user["startlong"] ?? "",
          elat: _user["endlat"] ?? "",
          elong: _user["endlong"] ?? "",
          isEnd: _user["isEnd"]??"",
          isstart: _user["isstart"]??"",
          journeyid: _user["journeyid"] ?? "");
    }).toList();
  }
}

class AdminJourneyDatabaseService {

  String useremail, journeyid;

  AdminJourneyDatabaseService({required this.useremail, required this.journeyid});

  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');

  Stream<List<Corider>> get corider {
    return _usercollection.doc(useremail).collection('journey').doc(journeyid)
        .collection('coriders').snapshots()
        .map(_gobacktoDriverJListFromDatabase);
  }

  List<Corider> _gobacktoDriverJListFromDatabase(QuerySnapshot snapshot) {
    return snapshot.docs.map((usersnapshot) {
      Map<String, dynamic> _user = jsonDecode(jsonEncode(usersnapshot.data()));
      print("journey travelling users is" + _user.toString());
      return Corider(email: _user["email"] ?? "",
          nofseats: _user["numseats"] ?? "",
          date: _user["date"] ?? "",
          endloc: _user["endingloc"] ?? "",
          startloc: _user["startingloc"] ?? "",
          slat: _user["startlat"] ?? "",
          slong: _user["startlong"] ?? "",
          elat: _user["endlat"] ?? "",
          elong: _user["endlong"] ?? "",
          journeyid: _user["journeyid"] ?? "",
          isjoined: _user["isjoined"]??"",
          otp:_user["otp"]??"",
          isleaved: _user["isleaved"]??"");
    }).toList();
  }

  Future updateDriverJourneyDataInUser(String isjoined,String tremail,String otp) async {
    return await _usercollection.doc(useremail).collection('journey').doc(
        journeyid).collection('coriders').doc(tremail).update({
      "isjoined": isjoined,
      'isleaved':'false',
      'otp': otp
    });
  }
  Future updateDriverJourneyDistanceDataOtp(String otp,String tremail) async {
    return await _usercollection.doc(tremail).collection('journey').doc(
        journeyid).update({
      "otp": otp,
    });
  }

  Future updateDriverJourneyDataInUsers(String tremail) async {
    return await _usercollection.doc(useremail).collection('journey').doc(
        journeyid).collection('coriders').doc(tremail).update({
      'isleaved':'true',
    });
  }
  Future updateDriverJourneyDistanceData(String distance,String place) async {
    return await _usercollection.doc(useremail).collection('journey').doc(
        journeyid).update({
      "distance": distance,"currentlocation":place,
    });
  }
}

class LiftService{


  final CollectionReference _usercollection = FirebaseFirestore.instance
      .collection('user');
  
  Future setLiftServiceUserDetails(String useremail,String journeyid,String driverid,String otp)async{
    return await _usercollection.doc(useremail).collection('journey').doc(journeyid).set({
      "email":useremail,
      "driverid": driverid,
      "otp":otp,
      "journeyid":journeyid
    });
  }

  Future setLiftServiceDriverDetails(String useremail,String journeyid,String driverid,String otp,String isjoined)async{
    return await _usercollection.doc(driverid).collection('journey').doc(journeyid).collection('coriders').doc(useremail).set({
      "email":useremail,
      "driverid": driverid,
      "otp":otp,
      "journeyid":journeyid,
      "isjoined": isjoined,
      'isleaved':'false',
    });
  }
}

