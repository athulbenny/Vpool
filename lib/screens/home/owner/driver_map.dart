
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:geolocator/geolocator.dart";
import "package:latlong2/latlong.dart" as latLng;
import "package:url_launcher/url_launcher.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geol;
import "../../../constants/locationConstants.dart";
import "../../../models/components.dart";


















/// Class that contain funtions like
///     - request location access permission
///     - request permission
///     - access currentLocation
///     - geocode location names from a given input auto suggestion using https://geocode.maps.co/
///     - geocode location names from a given latitude and longitude using https://geocode.maps.co/
class LocTracker{

  var location=new Location();
  var _serviceEnabled;
  var _permissionGranted;

  //checks for location access
  void initilaiseService() async{
    _serviceEnabled=await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled=await location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }
  }

  //checks for permissions
  void permissionForService() async{
    _permissionGranted=await location.hasPermission();
    if(_permissionGranted==PermissionStatus.denied){
      _permissionGranted=await location.requestPermission();
      if(_permissionGranted !=PermissionStatus.granted){
        return;
      }
    }
  }



  //gets location names for auto suggestions
  Future<List<addressResolution>?> getLocationsFromNames(String address) async{
    Uri uri=Uri.parse("https://geocode.maps.co/search?q=${address}");
    var locationsJSON=await http.get(uri);

    List<addressResolution>? _locations=jsonDecode(locationsJSON.body).map<addressResolution>((val){
      print("display name ${val["display_name"]} has kerala in it${val["display_name"].contains("Kerala")} ");
      return addressResolution(lat: double.parse(val["lat"]),
          long: double.parse(val["lon"]),
          placeName: val["display_name"]);
    }).toList();

    return _locations;
  }

  //gets location from latitude and longitude
  Future<String?> getLocationsFromLatLong(double lat,double long) async{
    print("gt location is called");
    Uri uri=Uri.parse("https://geocode.maps.co/reverse?lat=${lat}&lon=${long}");
    var locationsJSON=await http.get(uri);
    String? _locations=jsonDecode(locationsJSON.body)["display_name"];
    print(_locations);
    return _locations;
  }
}
























/// Class that performs functions like
///         - request location access permission
///         - request permission
///         - get current location
///         - calculate distance between two points based on latitude and longitudes
class UserCurrentLocation{

  //initialize permissions
  void InitializeService() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  //continously provides users location data
  Stream<Position?>  getCurrentLocation(){
    InitializeService();
    final LocationSettings locationSettings = LocationSettings(
      accuracy: geol.LocationAccuracy.high,
      distanceFilter: 100,
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }


  Future<Position> getMapBaseCoordinates(){
    return Geolocator.getCurrentPosition();
  }

}























class MapLoc extends StatefulWidget {
TextEditingController place;TextEditingController latitude;TextEditingController longitude;
MapLoc({required this.place,required this.longitude,required this.latitude});

  @override
  State<MapLoc> createState() => _MapLocState();
}

class _MapLocState extends State<MapLoc> {

  //current location (not used)
  LocTracker _location=LocTracker();
  UserCurrentLocation _userCurrentLocation=UserCurrentLocation();
  CurrentLocation loctnDta=CurrentLocation(lat: 11.987887319723766, long: 75.3812417561967);

  //location search
  List<addressResolution>? _locationFromNames=[];
  CurrentLocation _searchLocation=CurrentLocation(lat: 11.987887319723766, long: 75.3812417561967);

  //locations from map
  List<LocationDataFormat> _locationsMarked=[];
  MapController _mapController=MapController();
  double zoom=18;

  //initialize the widget
  //convert checkpoints to map data
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();

  }

  //auto suggestion
  void getPlacesFromNames(val) async{
    _locationFromNames=await LocTracker().getLocationsFromNames(val);
    setState(() {

    });
  }

  //place markers
  void addMarker(String placeName,latLng.LatLng location){
    if(_locationsMarked.length>=1){
      _locationsMarked.removeRange(0, _locationsMarked.length);
    }
    _locationsMarked.add(
        LocationDataFormat(
          placeName: placeName,
          lat: location.latitude,
          long: location.longitude,
        ));

    print('${placeName} lat ${location.latitude} and log ${location.longitude}');

    widget.place.text= placeName;
    widget.latitude.text=location.latitude.toString();
    widget.longitude.text=location.longitude.toString();

    setState(() {

    });
  }

  //allows to navigate to search location from auto suggestion
  void reNavigate(double lat,double long) {
    print("Renavigating");
    _locationFromNames=[];
    _searchLocation=CurrentLocation(lat: lat, long: long);
    _mapController.move(latLng.LatLng(lat, long), zoom);
    setState(() {

    });
  }

  //gets current location for easier map
  void getLocation() async{
    Position location=await _userCurrentLocation.getMapBaseCoordinates();
    _searchLocation=CurrentLocation(lat: location.latitude, long: location.longitude);
    _mapController.move(latLng.LatLng(_searchLocation.lat, _searchLocation.long),18);
    setState(() {

    });

  }

  Future<String?> getPlaceName(double lat,double long) async{
    try {
      return await LocTracker().getLocationsFromLatLong(lat, long);
    }
    catch(e){
      return "";
    }
  }

  void editMarker(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Appbarstylining(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        title: Center(
            child: Text(
              'Vpool',
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Stack(
        children: [
          /**
           * Flutter Map helps to provide a map view
           *
           *     features-
           *            - maxZoom:18 //otherwise causes the map to not load data
           *            - default location is taken from _searchLocation
           *              which is changed when a new location is searched
           *            - movement/updation in map is done using map controller
           *    working-
           *            - takes the locations from the variable _locationsMarked
           *            - markers added or removed from map are reflected in _locationsMarked
           * */
          FlutterMap(
            mapController: _mapController,
            options:MapOptions(
              onTap: (tapPosition,point)async{
                print(point.toString());
                _mapController.move(latLng.LatLng(point.latitude, point.longitude), zoom);
                String? placeName=await getPlaceName(point.latitude, point.longitude);
                addMarker(
                  placeName ?? "Error in selection try once more",
                  point,
                );
                //IconButton(icon: Icon(Icons.location_on_outlined),onPressed: (){},);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${placeName} is selected')));

              },
              center:latLng.LatLng(_searchLocation.lat,_searchLocation.long),
              zoom:zoom,
            ),
            nonRotatedChildren: [
              RichAttributionWidget(attributions: [
                TextSourceAttribution(
                  'Open Street Map Contibutors',
                  onTap: ()=>launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                )
              ])
            ],
            children: [
              TileLayer(
                urlTemplate: 'https://c.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                  markers:List.generate(_locationsMarked.length, (index)  {
                    print(index);
                    return Marker(
                        point:latLng.LatLng(_locationsMarked[index].lat, _locationsMarked[index].long) ,
                        width: 50,
                        height: 50,
                        builder: (BuildContext DialogContext){
                          return IconButton(
                            icon: Icon(Icons.location_on),
                            onPressed: (){

                            },
                          );
                        }
                    );
                  })
              ),
            ],
          ),

          /**
           * this widget is used to retrieve locations from https://geocode.maps.co/
           *          - used in auto suggestion feature
           *          - uses function getPlacesFromNames(string place) to get places
           *
           * update Required
           *                -automatic limiting to locations in kerala
           * */
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 50,),
                  TextFormField(
                    onChanged: (val){
                      getPlacesFromNames(val);
                    },
                    decoration:const  InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Location'
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.05*_locationFromNames!.length,
                    child: ListView.builder(
                        itemCount: _locationFromNames!.length,
                        itemBuilder: (context,index){
                          print('location ${index} ${_locationFromNames![index].placeName}');
                          return Card(
                            child: ListTile(
                              onTap: (){
                                print('lat ${_locationFromNames![index].lat} long ${_locationFromNames![index].long}');
                                reNavigate(_locationFromNames![index].lat, _locationFromNames![index].long);
                              },
                              tileColor: Colors.white,
                              title: Text(_locationFromNames![index]==null?'Error':_locationFromNames![index].placeName),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width/3,
            bottom: 10,
            child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Save and Continue')),
          )
        ],

      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.transit_enterexit),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }
}
