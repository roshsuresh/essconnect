import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/Student/Locationmodel.dart';
import '../../utils/constants.dart';







class LocationProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<D> locationlist = [];
  StreamSubscription<Position>? _positionStreamSubscription;
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  String? imeiNumber;
  String? gpsdevice;
  String? gpstoken;
  List<BusImeiNoList> buslist = []; //Bus List For Admin

  void setImei(String imei) {
    imeiNumber = imei;
  }
int statuscode = 0;

  //Gps Device Recognising Api
  Future<void> gpsDevice( ) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
      Uri.parse("${UIGuide.baseURL}/mobileapp/common/get-default-gps-tracking-token"),
      headers: headers,
    );
    print("${UIGuide.baseURL}/mobileapp/common/get-default-gps-tracking-token");
    statuscode = response.statusCode;
    print(statuscode);
    print("GPS Device fetching Started");

    if (response.statusCode == 200) {
      setLoading(true);
      // final jsonResponse = json.decode(response.body);
      var data = jsonDecode(response.body.toString());
      // print(data);
      GpsDevice dev = GpsDevice.fromJson(data);
      gpsdevice = dev.deviceName;
      gpstoken = dev.token;
      print(gpsdevice);
      print(gpstoken);
      setLoading(false);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> busListfn() async {
    setLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var response = await http.get(
      Uri.parse("${UIGuide.baseURL}/mobileapp/admin/bus-imei-no"),
      headers: headers,
    );
    statuscode = response.statusCode;
    print(statuscode);

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      setLoading(true);

      List<BusImeiNoList> templist = List<BusImeiNoList>.from(data["busImeiNoList"].map((x) => BusImeiNoList.fromJson(x)));
      buslist.clear();
      buslist.addAll(templist);

      print(buslist[0].busName);



      setLoading(false);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);
      notifyListeners();
    }
  }


  Future<void> locationListfn(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $gpstoken'
    };

    var response = await http.get(
      Uri.parse("https://mobiles.mercydatrack.com/mtrack/last_five_packets?imei_no=$imeiNumber"),
      headers: headers,
    );
    statuscode = response.statusCode;
    print(statuscode);

    if (response.statusCode == 200) {
      setLoading(true);
      final jsonResponse = json.decode(response.body);

      Locationlist locationList = Locationlist.fromJson(jsonResponse);

      if (locationList.data != null && locationList.data!.data != null) {
        locationlist.clear();
        for (var dataList in locationList.data!.data!) {
          // print('DataList: ${dataList.toJson()}');
          if (dataList.d != null) {
            locationlist.add(dataList.d!);
          }
        }
        print("list**** ${locationlist[0].longitude}");
        print("list**** ${locationlist[0].latitude}");
      }
      setLoading(false);
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      setLoading(false);
      notifyListeners();
    }
  }

  // StreamSubscription<Position>? _positionStreamSubscription;
  // Position? _currentPosition;
  bool _isLocationServiceRunning = false; // New flag to track if service is running

  // Future<void> checkPermissions() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
  //       throw Exception('Location permissions are denied');
  //     }
  //   }
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       throw Exception('Location services are disabled');
  //     }
  //   }
  // }
  //
  // Future<void> startLocationService() async {
  //   if (_isLocationServiceRunning) {
  //     print("Location service is already running.");
  //     LocationSettings locationSettings;
  //     if (Platform.isAndroid) {
  //       locationSettings = AndroidSettings(
  //         accuracy: LocationAccuracy.best,
  //         distanceFilter: 0,
  //         intervalDuration: const Duration(milliseconds: 1),
  //         foregroundNotificationConfig: const ForegroundNotificationConfig(
  //           notificationText: "App is tracking your location.",
  //           notificationTitle: "Location Service Running in Background",
  //           enableWakeLock: true,
  //           notificationChannelName: "location_channel",
  //         ),
  //       );
  //     }
  //     else if (Platform.isIOS) {
  //       locationSettings = AppleSettings(
  //         accuracy: LocationAccuracy.best,
  //         activityType: ActivityType.fitness,
  //         distanceFilter: 0,
  //         pauseLocationUpdatesAutomatically: true,
  //         showBackgroundLocationIndicator: false,
  //       );
  //     } else {
  //       locationSettings = const LocationSettings(
  //         accuracy: LocationAccuracy.best,
  //         distanceFilter: 0,
  //       );
  //     }
  //     return; // Prevent starting service again if it's already running
  //   }
  //
  //   print("Starting location service...");
  //   _isLocationServiceRunning = true; // Set flag to true
  //
  //   LocationSettings locationSettings;
  //   if (Platform.isAndroid) {
  //     locationSettings = AndroidSettings(
  //       accuracy: LocationAccuracy.best,
  //       distanceFilter: 0,
  //       intervalDuration: const Duration(milliseconds: 1),
  //       foregroundNotificationConfig: const ForegroundNotificationConfig(
  //         notificationText: "App is tracking your location.",
  //         notificationTitle: "Running in Background",
  //         enableWakeLock: true,
  //         notificationChannelName: "location_channel",
  //       ),
  //     );
  //   } else if (Platform.isIOS) {
  //     locationSettings = AppleSettings(
  //       accuracy: LocationAccuracy.best,
  //       activityType: ActivityType.fitness,
  //       distanceFilter: 0,
  //       pauseLocationUpdatesAutomatically: true,
  //       showBackgroundLocationIndicator: false,
  //     );
  //   } else {
  //     locationSettings = const LocationSettings(
  //       accuracy: LocationAccuracy.best,
  //       distanceFilter: 0,
  //     );
  //   }
  //
  //   _positionStreamSubscription = Geolocator.getPositionStream(
  //     locationSettings: locationSettings,
  //   ).listen((Position position) {
  //     _currentPosition = position;
  //     print("Current position: Latitude: ${position.latitude}, Longitude: ${position.longitude}");
  //     notifyListeners();
  //   }, onError: (e) {
  //     print('Error in position stream: $e');
  //   });
  //
  //   print("Location service started.");
  // }

  Future<void> stopLocationService() async {
    if (_positionStreamSubscription != null) {
      print("Stopping location service...");
      // await _positionStreamSubscription!.cancel();
      // _positionStreamSubscription = null;
      // _currentPosition = null;
      // _isLocationServiceRunning = false; // Reset the flag
      // notifyListeners();
      print("Location service stopped.");
    } else {
      print("No location service to stop.");
    }
  }

}
