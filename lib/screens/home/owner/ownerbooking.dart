import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../services/databaseService.dart';

class OwnerBooking extends StatefulWidget {
  const OwnerBooking({required this.user});
  final NewUser user;

  @override
  State<OwnerBooking> createState() => _OwnerBookingState();
}

class _OwnerBookingState extends State<OwnerBooking> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AllJourneyDriverDatabaseService(useremail: widget.user.username).corider,
        initialData: null,
        child: TravellerDetails(user:  widget.user,));
  }
}

class TravellerDetails extends StatefulWidget {
  const TravellerDetails({required this.user});
  final NewUser user;

  @override
  State<TravellerDetails> createState() => _TravellerDetailsState();
}

class _TravellerDetailsState extends State<TravellerDetails> {
  @override
  Widget build(BuildContext context) {
    final driverlist = Provider.of<List<Cocorider>?>(context)??[];
    print("driverloist is "+ driverlist.length.toString());
    return ListView.separated(
      itemCount: driverlist.length,
      itemBuilder: (context,index){
        return Card(
          child: ListTile(
            title: Text(driverlist[index].date),
            leading: Text(driverlist[index].nofseats),
            trailing: Text(driverlist[index].email),
          ),
        );
      },
      separatorBuilder: (context,index){
        return Container(padding: EdgeInsets.all(20 ),);
      },
    );
  }
}

