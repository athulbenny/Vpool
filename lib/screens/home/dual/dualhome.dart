import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../services/auth.dart';



class DualHome extends StatefulWidget {
  const DualHome({required this.user});
  final NewUser user;


  @override
  State<DualHome> createState() => _DualHomeState();
}

class _DualHomeState extends State<DualHome> {
  int pageIndex = 0;
  final AuthService _auth =AuthService();

  @override
  void initState() {
    super.initState();}

  @override
  Widget build(BuildContext context) {
    final pages = [

      OwnerSearch()
    ];
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
        backgroundColor: Colors.green,
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
                  await _auth.signOut();                }
              }
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(padding: EdgeInsets.only(left: MediaQuery.of(context).size.height/50,right: MediaQuery.of(context).size.height/50),
              height: MediaQuery.of(context).size.height,child: pages[pageIndex]),
          Positioned(top: MediaQuery.of(context).size.height/1.25,
              right: 5,left:5,child: buildMyNavBar(context)),
          Positioned(top: MediaQuery.of(context).size.height/1.30,left: MediaQuery.of(context).size.width/2.35,
              child: FloatingActionButton.extended(onPressed: (){}, label: Icon(Icons.person),elevation: 5,)),
        ],
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
              children:[
                IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                      : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                const Text("Home")
              ]),
          Column(children:[
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                Icons.search,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),const Text('Search')]),
          Column(children:[
            IconButton(
              enableFeedback: false,
              onPressed: () {
                // setState(() {
                //   pageIndex = 2;
                // });
              },
              icon: pageIndex == 2
                  ? const Icon(
                Icons.filter_none,
                color: Colors.transparent,
                size: 35,
              )
                  : const Icon(
                Icons.filter_none,
                color: Colors.transparent,
                size: 35,
              ),
            ),const Text('')]),
          Column(children:[
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                Icons.notifications_active,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),const Text('Notification')]),
          Column(children:[
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 4;
                });
              },
              icon: pageIndex == 4
                  ? const Icon(
                Icons.person_2,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.person_2_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),const Text('Profile')]),
        ],
      ),
    );
  }
}


class OwnerSearch extends StatefulWidget {
  const OwnerSearch({Key? key}) : super(key: key);

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
              ElevatedButton(onPressed: () {}, child: Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
}