import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ngawasi/styles/colors.dart';

class GoogleMaps extends StatefulWidget {
  static const routeName = '/google-maps';
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _contoller = Completer();

  final LatLng _center = const LatLng(45.521563, -122.677433);

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(20.42796133580664, 80.885749655962),
      infoWindow: InfoWindow(
        title: 'My Position',
      ),
    ),
  ];

  Future<geolocator.Position> getUserCurrentLocation() async {
    await geolocator.Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await geolocator.Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await geolocator.Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: kDeepBlue),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        elevation: 0.5,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.account_balance),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: SafeArea(
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _contoller.complete(controller);
          },
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then(
            (value) async {
              print(
                  value.latitude.toString() + " " + value.longitude.toString());

              _markers.add(
                Marker(
                  markerId: MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: InfoWindow(
                    title: 'My Current Location',
                  ),
                ),
              );
              CameraPosition cameraPosition = new CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 14,
              );

              final GoogleMapController controller = await _contoller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(cameraPosition),
              );
              setState(() {});
            },
          );
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
}
