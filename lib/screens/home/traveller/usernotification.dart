import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/services/databaseService.dart';
import '../../../constants/locationConstants.dart';
import '../../../models/user.dart';

///user notification, notify the user about the journey details
class UserNotification extends StatefulWidget {
  const UserNotification({required this.user});
  final NewUser user;

  @override
  State<UserNotification> createState() => _UserNotificationState();
}

class _UserNotificationState extends State<UserNotification> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value:
            AllJourneyTravellerDatabaseService(useremail: widget.user.username)
                .corider,
        initialData: null,
        child: TravelNotification(
          user: widget.user,
        ));
  }
}

///collecting journey details
class TravelNotification extends StatefulWidget {
  const TravelNotification({required this.user});
  final NewUser user;

  @override
  State<TravelNotification> createState() => _TravelNotificationState();
}

class _TravelNotificationState extends State<TravelNotification> {
  List<Rider> notif = [];
  @override
  Widget build(BuildContext context) {
    notif.clear();
    final traveljourneylist = Provider.of<List<Rider>?>(context) ?? [];
    print("length isss" + traveljourneylist.length.toString());
    for (int i = 0; i < traveljourneylist.length; i++) {
      if ((traveljourneylist[i].isstart != traveljourneylist[i].isnotified) && traveljourneylist[i].isEnd!="true" ) {
        notif.add(traveljourneylist[i]); //// i++;
        notif = [
          ...{...notif}
        ];
        print("length of notif" + notif.length.toString());
      }
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/8,
                left: MediaQuery.of(context).size.width/50,
                right: MediaQuery.of(context).size.width/50),
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Journey ID',
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text(notif[index].journeyid,
                                  )),                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('Journey Driver',),),
                              Expanded(
                                  flex: 1,
                                  child: Text(notif[index].driverid,                   )),],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Driver's Location details",),
                            // style: GoogleFonts.poppins(
                            //     fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('Drivers position',)),
                              Expanded(
                                  flex: 1,
                                  child: Text(notif[index].distance + ' KM')),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text('Drivers current loaction',)),
                              Expanded(
                                  flex: 1,
                                  child: Text(notif[index].currentlocation)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('OTP '),
                              ),
                              Expanded(flex: 1, child: Text(notif[index].otp)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(height: 5);
                },
                itemCount: notif.length),
          ),
          // TextButton(onPressed: (){
          //   print(notif[0].distance);
          //   setState(() {
          //     notif.clear();
          //   });
          //   //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notif[notif.length-1].distance.toString())));
          // }, child: Text('Refresh'))
        ],
      ),
    );
  }
}

//
