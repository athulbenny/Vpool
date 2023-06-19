import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../services/databaseService.dart';


class OwnerSearch extends StatefulWidget {
  const OwnerSearch({required this.user});
  final NewUser user;

  @override
  State<OwnerSearch> createState() => _OwnerSearchState();
}

class _OwnerSearchState extends State<OwnerSearch> {
  TextEditingController startLoc=TextEditingController();
  TextEditingController endLoc=TextEditingController();
  TextEditingController tdate=TextEditingController();
  TextEditingController starttime=TextEditingController();
  TextEditingController endtime=TextEditingController();
  TextEditingController desc=TextEditingController();
  TextEditingController numseats=TextEditingController();

  //final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.blue[200],
          padding: EdgeInsets.only(
            //   left: MediaQuery
            //       .of(context)
            //       .size
            //       .height / 100,
            //   right: MediaQuery
            //       .of(context)
            //       .size
            //       .height / 100,
            top: MediaQuery
                .of(context)
                .size
                .height / 5,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.3,
                  child: TextField(
                    controller: startLoc,
                    decoration: InputDecoration(
                      labelText: 'Start location',
                      icon: IconButton(onPressed: (){print("object");},icon: Icon(Icons.location_on_outlined),),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //trailing: Icon(Icons.restart_alt),
              ),
              ListTile(
                leading: Container(width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.3,
                  child: TextField(
                    controller: endLoc,
                    decoration: InputDecoration(
                      labelText: 'End location',
                      icon: IconButton(onPressed: (){print("object");},icon: Icon(Icons.location_city),),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // trailing: Icon(Icons.restart_alt),
              ),
              ListTile(
                leading: Container(decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black87)
                ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.3,
                  child: TextField(
                    controller: tdate,
                    decoration: InputDecoration(
                      labelText: 'date',
                      icon: IconButton(onPressed: (){print("object");},icon: Icon(Icons.date_range),),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // trailing: Icon(Icons.date_range),
              ),
              ListTile(
                leading: Container(decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black87)
                ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.3,
                  child: TextField(
                    controller: starttime,
                    decoration: InputDecoration(
                      labelText: 'start time',
                      icon: IconButton(onPressed: (){print("object");},icon: Icon(Icons.access_time_rounded),),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // trailing: Icon(Icons.date_range),
              ),
              ListTile(
                leading: Container(decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black87)
                ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.3,
                  child: TextField(
                    controller: endtime,
                    decoration: InputDecoration(
                      labelText: 'End time',
                      icon: IconButton(onPressed: (){print("object");},icon: Icon(Icons.more_time_rounded),),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // trailing: Icon(Icons.date_range),
              ),ListTile(
                leading: Container(decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black87)
                ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.3,
                  child: TextField(
                    controller: numseats,
                    decoration: InputDecoration(
                      labelText: 'Number of seats',
                      icon: Icon(Icons.numbers),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // trailing: Icon(Icons.date_range),
              ),
              ListTile(
                leading: Container(decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black87)
                ),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.3,
                  child: TextField(
                    controller: desc,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      icon: IconButton(onPressed: (){print("object");},icon: Icon(Icons.message),),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // trailing: Icon(Icons.date_range),
              ),
              ElevatedButton(onPressed: ()async {
                String journeyid= widget.user.username+DateTime.now().toString();
                dynamic result =await JourneyDatabaseService().addAdminJourneyDataInUser(widget.user.username,
                    starttime.text, endtime.text, startLoc.text,  endLoc.text,
                    numseats.text, tdate.text, desc.text,journeyid);
                dynamic result1 =await JourneyDatabaseService().addAdminJourneyDataInJourney(widget.user.username,
                    starttime.text, endtime.text, startLoc.text,  endLoc.text,
                    numseats.text, tdate.text, desc.text,journeyid);
              }, child: Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}