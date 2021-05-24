import 'dart:async';
import 'package:hunter/main.dart';
import 'package:hunter/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//void main() => runApp(MyApp());




class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => LocationScreenState();
  static const routeName = '/location';
}

class LocationScreenState extends State<LocationScreen> {
  Completer<GoogleMapController> _controller = Completer();



  static const LatLng _center = const LatLng(48.804789, 44.712501);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Ресторан Hunter',
          snippet: 'Доставка шашлыков',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Мы здесь'),
          backgroundColor: Colors.red,
        ),
        drawer: AppDrawer(),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 18.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),

          ],
        ),

    );
  }
}