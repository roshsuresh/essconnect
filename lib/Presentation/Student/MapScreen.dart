import 'dart:async';

import 'package:essconnect/Application/StudentProviders/StudLocationProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng _pGooglePlex = const LatLng(0, 0);
  //= LatLng(010.947392, 075.917664);

  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //  await Future.delayed(Duration(seconds: 1));
      try {
        var p = Provider.of<StudLocationProvider>(context, listen: false);
        await p.getBusLocation();
        _getLocation();
        Timer.periodic(const Duration(seconds: 15), (Timer timer) async {
          await p.getBusLocation();
          getLocationUpdates();
        });
        addCustomIcon();
        getLocationUpdates().then(
          (_) => {
            getPolylinePoints().then((coordinates) => {
                  generatePolyLineFromPoints(coordinates),
                }),
          },
        );
      } catch (e) {
        print('Error: $e');
        print(e);
      }
    });
  }

  Location location = Location();
  LocationData? currentLocatio;
  Future<void> _getLocation() async {
    try {
      var _currentLocation = await location.getLocation();
      setState(() {
        currentLocatio = _currentLocation;
        if (currentLocatio!.latitude != null &&
            currentLocatio!.longitude != null) {
          _pGooglePlex =
              LatLng(currentLocatio!.latitude!, currentLocatio!.longitude!);
        }
      });
      print("currentLocation :   $currentLocatio");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/Location_marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  // Future<void> _getLocation() async {
  //   Location location = Location();
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   // Check if location services are enabled
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   // Check if location permission is granted
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   // Get the current location
  //   // _currentP = LatLng(_currentP!.latitude, _currentP!.longitude);
  //   // print(_currentP);
  //   // setState(() {
  //   //   // Update the UI with the current location
  //   // });

  //   LocationData locationData = await location.getLocation();
  //   setState(() {
  //     // Update the UI with the current location
  //     _currentP = LatLng(locationData.latitude!, locationData.longitude!);
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(
              child: LottieAminBus(),
            )
          : GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              // myLocationEnabled: true,
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentP!.latitude ?? 0.0,
                  _currentP!.longitude ?? 0.0,
                ),
                zoom: 10.0,
              ),
              // initialCameraPosition: CameraPosition(
              //   target: _pGooglePlex,
              //     zoom: 13,
              // ),
              markers: {
                Marker(
                  markerId: const MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  position: _currentP!,
                ),
                Marker(
                  markerId: const MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _pGooglePlex,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 14,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // await p.getBusLocation();

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      snackbarWidget(2, "Enable location to continue", context);

      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // _locationController.onLocationChanged.listen(
    //   (LocationData currentLocatio) {
    //     if (currentLocatio.latitude != null &&
    //         currentLocatio.longitude != null) {
    if (mounted)
      setState(() {
        var p = Provider.of<StudLocationProvider>(context, listen: false);
        String latitude = p.busLocationList[0].d!.latitude.toString();
        double latitudeValue = double.parse(latitude);
        String longitude = p.busLocationList[0].d!.longitude.toString();
        double longitudeValue = double.parse(longitude);

        _currentP = LatLng(latitudeValue, longitudeValue);
        print(_currentP);
        // _cameraToPosition(_currentP!);
      });
    //     }
    //   },
    // );
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDPKi7RHsv3jzTUZz_yooD08AOZIBrBu04',
      // PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(_currentP!.latitude, _currentP!.longitude),
      PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
      // PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }

  // void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       color: Colors.black,
  //       points: polylineCoordinates,
  //       width: 8);
  //   setState(() {
  //     polylines[id] = polyline;
  //   });
  // }
  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    try {
      print("============================");
      PolylineId id = const PolylineId("poly");
      Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.black,
          points: polylineCoordinates,
          width: 8);
      if (mounted)
        setState(() {
          polylines[id] = polyline;
        });

      // if (result.points.isNotEmpty) {
      //
      // } else {
      //   print(result.errorMessage);
      // }
    } catch (e) {
      print('Error in getPolylinePoints: $e');
      // Handle the error appropriately, log more details, or show an error message to the user
    }
  }
}
