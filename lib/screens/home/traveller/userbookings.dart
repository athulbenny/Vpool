import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../services/databaseService.dart';

///user bookind details page, this page show the detials of all the journye the booked
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
        value:
            AllJourneyTravellerDatabaseService(useremail: widget.user.username)
                .corider,
        initialData: null,
        child: DriverDetails(
          user: widget.user,
        ));
  }
}

///collecting details of driver
class DriverDetails extends StatefulWidget {
  const DriverDetails({required this.user});
  final NewUser user;

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {

  Color colorCard= Colors.white;

  @override
  Widget build(BuildContext context) {
    final driverlist = Provider.of<List<Rider>?>(context) ?? [];
    print("driverlist is " + driverlist.length.toString());
    return Container(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/8,
    left: MediaQuery.of(context).size.width/50,
    right: MediaQuery.of(context).size.width/50),
      child: ListView.separated(
        itemCount: driverlist.length,///end journey--> teal, start journey --->white, upcoming---> green
        itemBuilder: (context, index) {
          if(driverlist[index].isstart=="false"){
            colorCard= Colors.green[300]!;
          }else if(driverlist[index].isEnd=="true"){colorCard=Colors.teal[300]!;}
          else{colorCard=Colors.white;}
          return Card(color: colorCard,
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Text(
                          "FROM",
                        )),
                        Expanded(
                            child: Text("TO",))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: Text(
                          driverlist[index].startloc,
                        )),
                        Expanded(
                            child: Text(driverlist[index].endloc,
          )),                    ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              Text('Journey Date', ),//style: GoogleFonts.poppins()),
                        ),
                        Expanded(
                            child: Text(driverlist[index].date,)),
                                // style: GoogleFonts.poppins())),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Number of seats booked',
                          )),
                        Expanded(
                          child: Text(driverlist[index].nofseats,
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:
                              Text('Journey Time',),// style: GoogleFonts.poppins()),
                        ),
                        Expanded(
                            flex: 1, child: Text(driverlist[index].startingtime)),
                        Expanded(
                            flex: 1, child: Text(driverlist[index].endingtime)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:
                              Text('Driver Email',),// style: GoogleFonts.poppins()),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(driverlist[index].driverid,
                           )),//style: GoogleFonts.poppins())),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:
                          Text('Vehicle Number Plate',),// style: GoogleFonts.poppins()),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(driverlist[index].vehicleno,
                            )),//style: GoogleFonts.poppins())),
                      ],
                    ),
                  ),
                ],
              ));
        },
        separatorBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
          );
        },
      ),
    );
  }
}
