import 'dart:convert';

import 'package:essconnect/Domain/Student/BusLocationModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudLocationProvider with ChangeNotifier {
  List<Data> busLocationList = [];
  Future getBusLocation() async {
    //  SharedPreferences _pref = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJzb2Z0dGVrSldUIiwic3ViIjoiY3Jlc2VudCIsImF1dGhvcml0aWVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE3MDI0NjI0MzUsImV4cCI6MTczNDAwMjQzNX0.BIVHtt1fu9Q3mbh3cPEZMhrXDa4Eb8qhSvMvkaN8bBobn66DZVhkcP6z3E3NdqvTuaJZF-e2wC47wPjSFo_JJw'
    };
    var response = await http.get(
        Uri.parse(
            "https://mobiles.mercydatrack.com/mtrack/last_five_packets?imei_no=862493056823929"),
        headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      final dataCollect = data["data"]['data'];
      //  print(dataCollect);

      List<Data> templist =
          List<Data>.from(dataCollect.map((x) => Data.fromJson(x)));
      busLocationList.addAll(templist);
      notifyListeners();
    } else {
      print('Error getBusLocation');
    }
  }
}
