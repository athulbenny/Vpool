import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/services/databaseService.dart';

import '../../../models/user.dart';

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
        value: AllJourneyTravellerDatabaseService(useremail: widget.user.username).corider,
        initialData: null,
        child: TravelNotification(user:  widget.user,));
  }
}

class TravelNotification extends StatefulWidget {
  const TravelNotification({required this.user});
  final NewUser user;

  @override
  State<TravelNotification> createState() => _TravelNotificationState();
}

class _TravelNotificationState extends State<TravelNotification> {


  List<Rider> notif=[];
  @override
  Widget build(BuildContext context) {
    final traveljourneylist = Provider.of<List<Rider>?>(context) ?? [];
    print(traveljourneylist.length);
    for(int i=0;i<traveljourneylist.length;i++){
      if(traveljourneylist[i].isstart!=traveljourneylist[i].isnotified){
        notif.add(traveljourneylist[i]);
        notif=[...{...notif}];
      }
    }
    return Column(
      children: [
        Container(height: MediaQuery.of(context).size.height/2,
          child: ListView.separated(
              itemBuilder: (context,index){
                 return Card(elevation: 5,shadowColor: Colors.black87,
                   child: Column(
                     children: [
                       Row(
                         children: [
                           Expanded(flex:1,child:Text('journeyid'),),
                           Expanded(flex: 1,child: Text(notif[index].journeyid)),
                         ],
                       ),
                       Row(
                         children: [
                           Expanded(flex:1,child:Text('journey driver'),),
                           Expanded(flex: 1,child: Text( notif[index].driverid)),
                         ],
                       ),
                       Text("driver has started the journey"),
                       Row(
                         children: [
                           Expanded(flex:1,child:Text('drivers position'),),
                           Expanded(flex: 1,child: Text(notif[index].distance+' KM')),
                         ],
                       ),
                     ],
                   ),
                 );
          }, separatorBuilder: (context,index){
              return Container(height: 5);
          }, itemCount: notif.length),
        ),
        ElevatedButton(onPressed: (){
          print(notif[0].distance);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(notif[0].distance.toString())));
        }, child: Text(''))
      ],
    );
  }
}

//