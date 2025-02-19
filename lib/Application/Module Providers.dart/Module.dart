import 'dart:developer';

import 'package:flutter/material.dart';

import '../../utils/constants.dart';


class ModuleProviders extends ChangeNotifier {
  bool fees = false;
  bool feesOnly = false;
  bool tabulation = false;
  bool timetable = false;
  bool curiculam = false;
  bool offlineAttendence = false;
  bool offlineTab = false;
  bool attendenceEntry = false;
  bool offlineFees = false;
  bool mobileApp = false;
  bool hpc = false;
  // bool gps = false;
  Future getModuleDetails() async {
    var parsedResponse = await parseJWT();

    final newParse = await parsedResponse['Modules'];
    print(newParse);
    String data = await newParse;

    if (RegExp(r'\bFEE\b').hasMatch(data)) {
      fees = true;
      notifyListeners();
      print('Fees Module Provided');
    }
    if (RegExp(r'\bTT\b').hasMatch(data)) {
      timetable = true;
      notifyListeners();
    }
    if (RegExp(r'\bTAB\b').hasMatch(data)) {
      tabulation = true;
      notifyListeners();
    }
    if (RegExp(r'\bCC\b').hasMatch(data)) {
      curiculam = true;
      notifyListeners();
    }
    if (RegExp(r'\bOFFLINE_ATT\b').hasMatch(data)) {
      offlineAttendence = true;
      notifyListeners();
    }
    if (RegExp(r'\bOFFLINE_TAB\b').hasMatch(data))
    {
      offlineTab = true;
      notifyListeners();
    }

    if(RegExp(r'\bATT\b').hasMatch(data))
    {
      attendenceEntry = true;
      notifyListeners();
    }
    if(RegExp(r'\bFEE_ONLY\b').hasMatch(data))
    {
      feesOnly = true;
      notifyListeners();
    }
    if (RegExp(r'\bOFFLINE_FEES\b').hasMatch(data))
    {
      offlineFees = true;
      notifyListeners();
    }
    if (RegExp(r'\bMOB_APP\b').hasMatch(data))
    {
      mobileApp = true;
      notifyListeners();
      print('Mobile App not provided');
    }
    print("fesssssssss  $fees");
    log('Module Checked '.toString());
    if (RegExp(r'\bHPC\b').hasMatch(data))
    {
      hpc = true;
      notifyListeners();
      print('HPC Provided');
    }
    // if (RegExp(r'\bHPC\b').hasMatch(data))
    // {
    //   gps = true;
    //   notifyListeners();
    //   print('GPS Provided');
    // }
    notifyListeners();
  }
}
