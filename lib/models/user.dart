class NewUser{
  String uid,username;
  NewUser({required this.uid,required this.username });
}

class Travellers{
  String email, username, isOwner,vehicleno,vehicletype;
  Travellers({required this.email,required this.username,required this.isOwner,
    required this.vehicleno, required this.vehicletype});
}

class Journey{
  String startingloc, endingloc, date, startingtime, endingtime,
      numseats,email,remseats,journeyid, price,vehicleno,vehicletype;
  Journey({required this.startingloc,required this.endingloc,required this.date,required this.price,
           required this.startingtime,required this.endingtime,required this.numseats,required this.vehicletype,
           required this.email,required this.remseats,required this.journeyid, required this.vehicleno});
}

class Corider{/// users or travellers details
  String email,nofseats,startloc,endloc,date,slat,slong,elat,elong,journeyid,isjoined,isleaved,otp;
  Corider({required this.email,required this.nofseats,required this.date,
          required this.startloc,required this.endloc,required this.slat,
          required this.slong,required this.elat,required this.elong,required this.otp,
          required this.journeyid,required this.isjoined,required this.isleaved});
}

class Rider{/// driver or owner details
  String email,nofseats,date,journeyid,startloc,endloc,isstart,currentlocation,
      isnotified,driverid,distance,startingtime,endingtime,otp,vehicleno,isEnd;
  Rider({required this.email,required this.nofseats,required this.date,required this.journeyid,
          required this.startloc,required this.endloc,required this.isstart,
    required this.isEnd,
          required this.startingtime,required this.endingtime,required this.otp,required this.currentlocation,
          required this.isnotified,required this.driverid,required this.distance,required this.vehicleno});
}

class Travel{
  String email,nofseats,startloc,endloc,date,slat,slong,elat,
      elong,journeyid,startingtime,endingtime,isEnd,isstart;
  Travel({required this.email,required this.nofseats,required this.date,
  required this.startloc,required this.endloc,required this.slat,required this.isstart,
    required this.startingtime,required this.endingtime,required this.isEnd,
  required this.slong,required this.elat,required this.elong,required this.journeyid});

}