import 'package:ezparking/Services/Auth.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:ezparking/Boundary/SearchPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ezparking/Utils/NavDrawer.dart';
import 'dart:math' as Math;

import 'ViewCarparkInfoPage.dart';

const kGoogleApiKey = "AIzaSyAzedSahYVFaCTK3_YP19NYYd9_mW3EI5A";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapPage extends StatefulWidget {
  MapPage({Key key, @required this.auth}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
  final AuthBase auth;
}

class _MapPageState extends State<MapPage> {
  // _MapPageState({Key key, @required this.auth}) : super(key: key);
  GoogleMapController mapController;
  LatLng _initialcameraposition = LatLng(1.282302, 103.858528);
  final _location = LocationManager.Location();
  final double EARTH_RADIUS = 6378.137;
  Set<Marker> _markers = {};
  BitmapDescriptor mapMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();

  }

  void setCustomMarker() async {
    // mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)), 'assets/pin2.png');
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    mapController = _cntlr;
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          // CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
          CameraPosition(target: LatLng(1.348310, 103.683136), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavDrawer(auth: widget.auth),
        appBar: AppBar(
          title: Text('Car parks'),

          backgroundColor: Colors.amber.shade300,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },)
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: _initialcameraposition),
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          markers: _markers,

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _markers.add(
                Marker(
                  markerId: MarkerId('id-1'),
                  position: LatLng(1.348310, 103.683136),
                  icon: mapMarker,
                  infoWindow: InfoWindow(
                    title: 'NTU',
                    snippet: 'School',
                    onTap: () => { /*test length conversion*/
                      getDistance(103.683136, 1.348310, 103.7050706, 1.3356503),   //home to ntu
                      getDistance(103.7050706, 1.3356503,103.7865766,1.2979674)    //ntu to one north
                    },
                  ),
                ),
              );
            });
          },
          child: Icon(Icons.pin_drop_outlined),
        ),
      ),);
  }

  double getDistance(double longitude1, double latitude1, double longitude2, double latitude2) {
    double lat1 = latitude1 * Math.pi / 180;
    double lat2 = latitude2 * Math.pi / 180;
    double lng1 = longitude1* Math.pi / 180;
    double lng2 = longitude2* Math.pi / 180;
    double a = lat1 - lat2;
    double b = lng1 - lng2;
    double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) +
        Math.cos(lat1) * Math.cos(lat2) * Math.pow(Math.sin(b / 2), 2)));
    s =  s * EARTH_RADIUS;
    print("Distance is $s km");
    return s;
  }

}


