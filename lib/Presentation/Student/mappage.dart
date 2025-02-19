import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../Application/StudentProviders/LocationServiceProvider.dart';
import '../../utils/constants.dart';

class MapScreen extends StatefulWidget {
  final String imeiNumber;

  const MapScreen({super.key, required this.imeiNumber});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Timer? _permissionTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var provider = Provider.of<LocationProvider>(context, listen: false);
      provider.setImei(widget.imeiNumber); // Pass the IMEI number to the provider
      _startPermissionCheck(provider);
    });
  }

  void _startPermissionCheck(LocationProvider provider) {
    _permissionTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      try {
        // await provider.checkPermissions();
        // await provider.startLocationService();
        await provider.locationListfn(context);
      } catch (e) {
        print(e);
      }
    });
  }

  void _stopPermissionCheck() {
    _permissionTimer?.cancel();
    _permissionTimer = null;
  }

  @override
  void dispose() {
    if (mounted) {
      var provider = Provider.of<LocationProvider>(context, listen: false);
      provider.stopLocationService(); // Stop location service
      _stopPermissionCheck(); // Stop permission check
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var provider = Provider.of<LocationProvider>(context, listen: false);
        _stopPermissionCheck();  // Stop the permission check timer
        provider.stopLocationService();  // Stop the location service
        return true; // Al // Allow the back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bus Tracking'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              var provider = Provider.of<LocationProvider>(context, listen: false);
              _stopPermissionCheck();  // Stop the permission check timer
              provider.stopLocationService();  // Stop the location service

              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          backgroundColor: UIGuide.light_Purple,
        ),
        body: Consumer<LocationProvider>(builder: (context, provider, _) {
          if (provider.statuscode == 200) {
            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.locationlist.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              double latitude = double.parse(provider.locationlist[0].latitude!) ?? 0.00;
              double longitude = double.parse(provider.locationlist[0].longitude!) ?? 0.00;

              return FlutterMap(
                options: MapOptions(
                  initialZoom: 13.0,
                  initialCenter: LatLng(latitude, longitude),
                  keepAlive: true,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  // MarkerLayer(
                  //   markers: [
                  //     if (provider.currentPosition != null)
                  //       Marker(
                  //         point: LatLng(provider.currentPosition!.latitude,
                  //             provider.currentPosition!.longitude),
                  //         width: 80,
                  //         height: 80,
                  //         child: const Icon(Icons.location_on, color: Colors.red, size: 30),
                  //       ),
                  //   ],
                  // ),
                  CurrentLocationLayer(),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(latitude, longitude),
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset('assets/bus.svg'),
                      ),
                    ],
                  ),
                ],
              );
            }
          } else {
            return const AlertDialog(
              icon: Icon(Icons.error_rounded, size: 100, color: Colors.red),
              title: Text("GPS Server down!"),
            );
          }
        }),
      ),
    );
  }
}
