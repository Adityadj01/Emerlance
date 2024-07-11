import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:emerlance/screens/search_places_screen.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User current location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: Padding( 
        padding: const EdgeInsets.only(left:30),
        child:Row(

        crossAxisAlignment: CrossAxisAlignment.end,
        children:[
          FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));


          markers.clear();

          markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));

          setState(() {});

        },
        label: const Text("Location"),
        icon: const Icon(Icons.location_history),
      ),
        Expanded(child: Container()),
          FloatingActionButton.extended(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const SearchPlacesScreen();
              }));
            }, 
            label: const Text("search"),
            ),
        ],
      ),
      )
    );
  }
}
