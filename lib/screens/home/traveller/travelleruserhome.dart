import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/models/user.dart';
import 'package:untitled1/services/databaseService.dart';

class MyUserHome extends StatefulWidget {
  const MyUserHome({Key? key}) : super(key: key);

  @override
  State<MyUserHome> createState() => _MyUserHomeState();
}

class _MyUserHomeState extends State<MyUserHome> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: JourneyDatabaseService().journeylist,
        initialData: null,
        child: AllJourneys());
  }
}

class AllJourneys extends StatefulWidget {
  const AllJourneys({Key? key}) : super(key: key);

  @override
  State<AllJourneys> createState() => _AllJourneysState();
}

class _AllJourneysState extends State<AllJourneys> {
  @override
  Widget build(BuildContext context) {
    final journeylist = Provider.of<List<Journey>?>(context)??[];
    print("journey length"+journeylist.length.toString());
    return ListView.separated(itemBuilder: (context,index){
      return Card(elevation: 5,
        child: Column(
          children:[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(journeylist[index].startingloc),
                Text('-------->'),
                Text(journeylist[index].endingloc)
              ],),
            Text(journeylist[index].date),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text(journeylist[index].startingtime),
              Text(journeylist[index].endingtime),],),
            Text(journeylist[index].remseats),
          ],
        ),
      );
    },
        separatorBuilder: (context,index){
      return Container(height: 20,);
        }
        , itemCount: journeylist.length);
  }
}

//Container(
//       padding: EdgeInsets.symmetric(
//         vertical: 20,horizontal: 20,
//       ),
//
//     );