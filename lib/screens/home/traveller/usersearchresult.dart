import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/services/auth.dart';

import '../../../main.dart';
import '../../../models/user.dart';
import '../../../services/databaseService.dart';


class Search extends StatefulWidget {
  const Search({required this.user});
  final NewUser user;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController startLoc=TextEditingController();
  TextEditingController endLoc=TextEditingController();
  TextEditingController tdate=TextEditingController();
  bool vis=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: MediaQuery.of(context).size.height/1.5,
        //color: Colors.blue[200],
        // padding: EdgeInsets.only(
        //   left: MediaQuery
        //       .of(context)
        //       .size
        //       .height / 100,
        //   right: MediaQuery
        //       .of(context)
        //       .size
        //       .height / 100,
        //   top: MediaQuery
        //       .of(context)
        //       .size
        //       .height / 100,),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
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
            ElevatedButton(onPressed: () async{
              print(vis);
              vis=!vis;print(vis);
              }, child: Text('search')),
            Visibility(
                visible: vis,
                child: MySearch(user: widget.user ,startloc:startLoc.text,endloc: endLoc.text, date: tdate.text,))
          ],
        ),
      ),
    );
  }
}



class MySearch extends StatefulWidget {
  const MySearch({required this.startloc,required this.endloc,required this.date,required this.user});
  final String startloc,endloc,date;final NewUser user;

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    print("clicked");
    return StreamProvider.value(
        value: JourneyDatabaseService().journeylist,
        initialData: null,
        child: MySearchData(user:widget.user,startloc: widget.startloc,date: widget.date,endloc: widget.endloc,)
    );
  }
}

class MySearchData extends StatefulWidget {
  const MySearchData({required this.startloc,required this.endloc,required this.date,required this.user});
  final String startloc,endloc,date;final NewUser user;

  @override
  State<MySearchData> createState() => _MySearchDataState();
}

class _MySearchDataState extends State<MySearchData> {
  @override
  Widget build(BuildContext context) {
    List<Journey> searchlist=[];
    final journeylist = Provider.of<List<Journey>?>(context)??[];
    print("journey lentgth is "+journeylist.length.toString());
    for(int i=0;i<journeylist.length;i++){
      print(journeylist[i].endingloc);
      if(journeylist[i].startingloc ==widget.startloc
      && journeylist[i].endingloc==widget.endloc && double.parse(journeylist[i].remseats)>0){
        searchlist.add(journeylist[i]);
        print(double.parse(journeylist[i].remseats));
      }
    }
    return Container(height: MediaQuery.of(context).size.height/3,
      child: ListView.separated(itemBuilder: (context,index){
        return GestureDetector(
          child: Card(elevation: 5,
            child:  Container(padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(searchlist[index].email.split('@').first),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(searchlist[index].startingloc),
                    Text("=====>",style: TextStyle(color: Colors.red,fontSize: 35),),
                    Text(searchlist[index].endingloc),],),
                ],
              ),
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                SelectJourney(selected: searchlist[index],user: widget.user)));
          },
        );
      },
          separatorBuilder: (context,index){
            return Container(height: 20,);
          }
          , itemCount: searchlist.length),
    );

  }
}

class SelectJourney extends StatefulWidget {
  const SelectJourney({required this.selected,required this.user});
  final NewUser user;
  final Journey selected;

  @override
  State<SelectJourney> createState() => _SelectJourneyState();
}

class _SelectJourneyState extends State<SelectJourney> {
  final AuthService _auth = AuthService();String error="";
  TextEditingController startingloc= TextEditingController(text: "starting");
  TextEditingController endingloc= TextEditingController(text: "ending");
  TextEditingController numseats= TextEditingController(text: "seats");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ), toolbarHeight: MediaQuery.of(context).size.height/15,
        title: Center(child:
        Text('V-Pool',style: TextStyle(
            fontSize: 25,fontWeight:FontWeight.w900),)),
        backgroundColor: topcolor,
        centerTitle: true,
        leading: BackButton(onPressed: (){
          //Navigator.of(context).pushNamed(Login.id);
        },),
        actions: [
          PopupMenuButton(
              itemBuilder: (context){
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("My Account"),
                  ),

                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Settings"),
                  ),

                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected:(value)async{
                if(value == 0){
                  print("My account menu is selected.");
                }else if(value == 1) {
                  print("My settings menu is selected.");
                }else if(value == 2){
                  await _auth.signOut();
                }
              }
          ),
        ],
      ),
      body: Column(
        children: [Text(widget.selected.email),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text(widget.selected.startingloc),
            Text("--------->"),
            Text(widget.selected.endingloc),],),
          Text(widget.selected.date),
          Text(widget.selected.startingtime),
          Text(widget.selected.endingtime),
          Form(child: Column(
            children: [
              TextFormField(
                controller: startingloc,
              ),
              TextFormField(
                controller: endingloc,
              ),
              TextFormField(
                controller: numseats,
              ),
            ],
          )),
          ElevatedButton(onPressed: () async{
            double numseats1= double.parse(widget.selected.remseats);
            double reqseats= double.parse(numseats.text);
            double remseats=numseats1-reqseats;
            if(remseats>=0){error="";
        dynamic result = await JourneyDriverTravellerConnection(
            driverid: widget.selected.email).AddTravellerJourneyData(
            widget.user.username, startingloc.text, endingloc.text, numseats.text,widget.selected.journeyid);
            await JourneyDriverTravellerConnection(
                driverid: widget.selected.email).AddAdminJourneyData(
                widget.user.username, startingloc.text, endingloc.text, numseats.text,widget.selected.journeyid);
            await JourneyDriverTravellerConnection(
                driverid: widget.selected.email).AddAdminJourneyUserData(widget.selected.date,
                widget.user.username, startingloc.text, endingloc.text, numseats.text,widget.selected.journeyid);
        await JourneyDriverTravellerConnection(
            driverid: widget.selected.email).UpdateDriverJourneyDataInJourney(remseats.toString());
        await JourneyDriverTravellerConnection(
                driverid: widget.selected.email).UpdateDriverJourneyDataInUser(remseats.toString(),widget.selected.journeyid);//give value
          }else{error="seats not available";}}, child: Text('add')),
          Text(error),
        ],
      ),
    );
  }
}

