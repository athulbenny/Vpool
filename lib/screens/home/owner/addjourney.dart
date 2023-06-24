import 'package:flutter/material.dart';
import 'package:untitled1/screens/home/owner/openstreetmaplink.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../models/user.dart';
import '../../../services/databaseService.dart';

import 'package:intl/intl.dart';


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
  TextEditingController lat=TextEditingController();
  TextEditingController long=TextEditingController();

  //late double _height,_width;
  late String startlat,endlat,startlong,endlong;
  //late String _setTime;//, _setDate;
  late String _hour, _minute, _time,_am;
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  var timerx,timery;

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
            top: MediaQuery.of(context).size.height / 5,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Container(width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(readOnly: true,
                    controller: startLoc,
                    decoration: InputDecoration(
                      labelText: 'Start location',
                      icon: IconButton(onPressed: ()async{
                        await showDialog(context: context, builder: (_){
                          return Dialog(
                            child: OpenStreetMapLink(user: widget.user,loctra: startLoc,lat: lat,long: long),
                          );
                        });startlat=lat.text;startlong=long.text;
                        print("lat is "+startlat+"    long is "+startlong);
                      },icon: Icon(Icons.location_on_outlined),),
                      border: OutlineInputBorder(),
                    ),),),),
              ListTile(
                leading: Container(width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(readOnly: true,
                    controller: endLoc,
                    decoration: InputDecoration(
                      labelText: 'End location',
                      icon: IconButton(onPressed: ()async{
                        await showDialog(context: context, builder: (_){
                          return Dialog(
                            child: OpenStreetMapLink(user: widget.user,loctra: endLoc,lat: lat,long: long),);
                        });
                        endlat=lat.text;endlong=long.text;
                        print("lat is "+endlat+"    long is "+endlong);
                      },icon: Icon(Icons.location_city),),
                      border: OutlineInputBorder(),
                    ),),),),
              ListTile(
                leading: Container(decoration: const BoxDecoration(
                  //border: Border.all(color: Colors.black87)
                ),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(readOnly: true,
                    controller: tdate,
                    decoration: InputDecoration(
                      labelText: 'date',
                      icon: IconButton(onPressed: ()async{
                        await showDialog(context: context, builder: (_){
                          return Dialog(
                            child: Calender(locctrl: tdate),
                          );
                        });if(tdate.text!=null) print(tdate.text.split(' ').first);
                      },icon: Icon(Icons.date_range),),
                      border: OutlineInputBorder(),
                    ),),),),
              ListTile(
                leading: Container(decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(readOnly: true,
                    controller: starttime,
                    decoration: InputDecoration(
                      labelText: 'start time',
                      icon: IconButton(onPressed: ()async{
                        timery=await timerselect();print(timery);
                        setState(() {
                          starttime.text=timery.toString();
                        });
                      },icon: Icon(Icons.access_time_rounded),),
                      border: OutlineInputBorder(),
                    ),),),),
              ListTile(
                leading: Container(decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(readOnly: true,
                    controller: endtime,
                    decoration: InputDecoration(
                      labelText: 'End time',
                      icon: IconButton(onPressed: ()async{
                        timerx=await timerselect();print(timerx);
                        setState(() {
                          endtime.text=timerx.toString();
                        });
                      },icon: Icon(Icons.more_time_rounded),),
                      border: OutlineInputBorder(),
                    ),),),
              ),ListTile(
                leading: Container(decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    controller: numseats,
                    decoration: const InputDecoration(
                      labelText: 'Number of seats',hintText: 'type here',
                      icon: Icon(Icons.numbers),
                      border: OutlineInputBorder(),
                    ),),),),
              ListTile(
                leading: Container(decoration: BoxDecoration(),
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    controller: desc,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      icon: Icon(Icons.message),
                      border: OutlineInputBorder(),
                    ),),),),
              ElevatedButton(onPressed: ()async {
                String datetime=DateTime.now().toString();
                String datetime1=datetime.split(' ').first.split('-').first;
                String datetime2=datetime.split(' ').first.split('-').elementAt(1);
                String datetime3=datetime.split(' ').first.split('-').last;
                String datetime4=datetime.split(' ').last.split(':').elementAt(0);
                String datetime5=datetime.split(' ').last.split(':').elementAt(1);
                String datetime6=datetime.split(' ').last.split(':').last.split('.').first;
                String datetime7=datetime.split(' ').last.split(':').last.split('.').last;
                String journeyid= '#'+datetime1+datetime2+datetime3+datetime4+datetime5+datetime6+datetime7;
                print(journeyid);
                dynamic result =await JourneyDatabaseService().addAdminJourneyDataInUser(widget.user.username,
                    starttime.text, endtime.text, startLoc.text,  endLoc.text,
                    numseats.text, tdate.text, desc.text,journeyid,startlat,startlong,endlat,endlong);
                dynamic result1 =await JourneyDatabaseService().addAdminJourneyDataInJourney(widget.user.username,
                    starttime.text, endtime.text, startLoc.text,  endLoc.text,
                    numseats.text, tdate.text, desc.text,journeyid,startlat,startlong,endlat,endlong);
              }, child: Text('Add'))
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic?> timerselect() async{
  final TimeOfDay? picked = await showTimePicker(
  context: context,
  initialTime: selectedTime,
  );
  if (picked != null) {
    setState(() {
  selectedTime = picked;
  _hour = selectedTime.hour.toString();
  _minute = selectedTime.minute.toString();
  _am= selectedTime.period.toString();
  _time = _hour + ':' + _minute;
  print(_time);
  // _timeController.text = formatDate(
  //     DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
  //     [hh, ':', nn, " ", am]).toString();
  });
  }return _time;
}
}

class Calender extends StatefulWidget {
  const Calender({required this.locctrl});
  final TextEditingController locctrl;

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day+1);//DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25)),
      ), toolbarHeight: MediaQuery.of(context).size.height/15,title: Text('Choose Date'),
        centerTitle: true,backgroundColor: Colors.green,),
      body: TableCalendar(
        firstDay: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day+1),
        lastDay: DateTime.utc(2050,12,31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        weekNumbersVisible: true,
        rowHeight: 50,
        daysOfWeekHeight: 25,
        pageJumpingEnabled: true,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              widget.locctrl.text= _focusedDay.toString().split(' ').first;
            });}},
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });}},
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),);
  }
}
