import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';
import '../../../services/databaseService.dart';

class UserBookings extends StatefulWidget {
  const UserBookings({required this.user});
  final NewUser user;

  @override
  State<UserBookings> createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AllJourneyTravellerDatabaseService(useremail: widget.user.username).corider,
        initialData: null,
        child: DriverDetails(user:  widget.user,));
  }
}

class DriverDetails extends StatefulWidget {
  const DriverDetails({required this.user});
  final NewUser user;

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {
    final driverlist = Provider.of<List<Corider>?>(context)??[];
    print("driverloist is "+ driverlist.length.toString());
    return ListView.separated(
      itemCount: driverlist.length,
      itemBuilder: (context,index){
        return Card(
          child: ListTile(
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
