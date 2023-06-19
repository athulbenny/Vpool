class NewUser{
  String uid,username;
  NewUser({required this.uid,required this.username });
}

class Travellers{
  String email, username, isOwner;
  Travellers({required this.email,required this.username,required this.isOwner});
}

class Journey{
  String startingloc, endingloc, date, startingtime, endingtime, numseats,email,remseats,journeyid;
  Journey({required this.startingloc,required this.endingloc,required this.date,
    required this.startingtime,required this.endingtime,required this.numseats,
    required this.email,required this.remseats,required this.journeyid});
}

class Corider{
  String email,nofseats;
  Corider({required this.email,required this.nofseats});
}

class Cocorider{
  String email,nofseats,date;
  Cocorider({required this.email,required this.nofseats,required this.date});
}