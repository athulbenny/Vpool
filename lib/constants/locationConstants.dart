//class for location format
import 'dart:ui';

import 'package:flutter/material.dart';

class LocationDataFormat{
  String placeName;
  double lat;
  double long;

  LocationDataFormat({
    required this.placeName,
    required this.lat,
    required this.long,

  });
}

TextStyle text=  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300);











//class for auto suggest
class addressResolution{
  double lat;
  double long;
  String placeName;

  addressResolution({required this.lat,required this.long,required this.placeName});
}

class CurrentLocation{
  double lat;
  double long;

  CurrentLocation({required this.lat,required this.long});
}

class currentDate{
  bool isAssigned;
  int index;

  currentDate({required this.isAssigned,required this.index});
}


String termsAndCondition= """1. Eligibility: The Vpooling app is available to individuals who are 18 years or older and have a valid driver's license and insurance.
2. User Conduct: Users of the Vpooling app must conduct themselves in a respectful and responsible manner. Any inappropriate behavior, including but not limited to harassment, discrimination, or dangerous driving, will result in immediate termination of the user's account.
3. Liability: The Vpooling app is not liable for any accidents, injuries, or damages that may occur during a vpool ride. Users are responsible for their own safety and should take necessary precautions, such as wearing a seatbelt and following traffic laws.
4. Payment: The Vpooling app does not charge any fees for using the service. However, users may agree to split the cost of gas and tolls among themselves.
5. Cancellation Policy: Users may cancel a Vpool ride up to 24 hours before the scheduled departure time without penalty. Cancellations made within 24 hours of the scheduled departure time may result in a penalty fee.
6. Feedback and Ratings: Users are encouraged to provide feedback and ratings after each Vpool ride to help improve the service and ensure a positive experience for all users.
7. Privacy: The Vpooling app respects the privacy of its users and will not share personal information with third parties without consent.
8. Modifications: The Vpooling app reserves the right to modify these terms and conditions at any time. Users will be notified of any changes via email or in-app notification.
By using the Vpooling app, users agree to abide by these terms and conditions.""";