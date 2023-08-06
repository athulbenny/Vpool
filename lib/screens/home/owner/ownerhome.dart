import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/models/components.dart';
import 'package:untitled1/screens/home/owner/addjourney.dart';
import 'package:untitled1/screens/home/owner/ownerbooking.dart';
import 'package:untitled1/screens/home/owner/ownerpaymnet.dart';
import '../../../constants/locationConstants.dart';
import '../../../models/user.dart';
import '../../../services/auth.dart';

/// Owners or drivers initial home page this page deviates to all several services of driver
class OwnerHome extends StatefulWidget {
  const OwnerHome({required this.user,required this.numpl,required this.vtype});
  final NewUser user;final String numpl,vtype;

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  int pageIndex = 0;
  final AuthService _auth = AuthService();

  ///creating instance of authservice

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///pages is navigation pages of bottom navgation bar
    final pages = [
      DriverHome(),
      OwnerSearch(user: widget.user,numpl: widget.numpl,vtype: widget.vtype),
      OwnerPayment(user: widget.user),
      OwnerBooking(user: widget.user),
    ];

    return Scaffold(
      backgroundColor: Colors.black87,
      ///app bar of driver pages
      appBar: AppBar(
        flexibleSpace: Appbarstylining(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 15,
        title: Center(
            child: Text(
          'V-Pool',
        )),
        //backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            exit(0);
          },
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Account"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Logout"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              print("My account menu is selected.");
            } else if (value == 2) {
              await _auth.signOut();
            }

            ///sign out
          }),
        ],
      ),

      ///body of driver pages
      body: SafeArea(
        child: Stack(
          children: [
            // Container(height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     image: new DecorationImage(image: AssetImage('assets/images/Frame.jpg'),fit:BoxFit.cover)
            //   ),
            // ),
            Container(color: Colors.transparent,
                // padding: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.height / 50,
                //     right: MediaQuery.of(context).size.height / 50),
                height: MediaQuery.of(context).size.height,
                child: pages[pageIndex]),
            Positioned(
                top: MediaQuery.of(context).size.height / 1.25,
                right: 0,
                left: 0,bottom: 0,
                child: buildMyNavBar(context)),
            Positioned(
              bottom:
                  100.0, // Customize the distance from the bottom as per your needs
              right:
                  16.0, // Customize the distance from the right as per your needs
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () async {
                  ///location service is enabling while cicking the floating action button for enabling location
                  Location location = new Location();
                  bool _serviceEnabled;
                  PermissionStatus _permissionGranted;
                  LocationData _locationData;
                  _serviceEnabled = await location.serviceEnabled();
                  if (!_serviceEnabled) {
                    _serviceEnabled = await location.requestService();
                    if (!_serviceEnabled) {
                      return;
                    }
                  }
                  _permissionGranted = await location.hasPermission();
                  if (_permissionGranted == PermissionStatus.denied) {
                    _permissionGranted = await location.requestPermission();
                    if (_permissionGranted != PermissionStatus.granted) {
                      return;
                    }
                  }
                  _locationData = await location.getLocation();
                  double? latx = _locationData.latitude;
                  double? longx = _locationData.longitude;
                  print(latx!);
                  print(longx!);
                  location.enableBackgroundMode(enable: true);
                },
                child: Icon(Icons.location_on_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///bottom navigation bar of driver
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Colors.cyan, Colors.green]),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [
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
            SizedBox(height: 8,),
            const Text("Home")
          ]),
          Column(children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
            ),SizedBox(height: 8,),
            const Text('Add')
          ]),
          Column(children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.payments,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.payments_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),SizedBox(height: 8,),
            const Text('Transaction ')
          ]),
          Column(children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.dashboard_customize_sharp,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.dashboard_customize_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),SizedBox(height: 8,),
            const Text('Bookings')
          ]),
        ],
      ),
    );
  }
}

///driver home: initial loading page of driver
class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //       image: new DecorationImage(image: AssetImage('images/Frame.jpg'),fit:BoxFit.cover)
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Welcome back !',style:text,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Complete 5 journeys and get exciting coupons!",style: text.copyWith(fontSize: 25),
            ),
          ),
          Container(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 50, 5, 50),
            child: Image.asset(
              'assets/images/car2.jpeg',
              fit: BoxFit.cover,
              height: 200.0,
            ),
          ),
        ],
      )),
    );
  }
}
