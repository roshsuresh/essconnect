import 'dart:developer';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

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
  bool mobileApp =false;
  Future getModuleDetails() async {
    var parsedResponse = await parseJWT();
    final newParse = await parsedResponse['Modules'];
    print(newParse);
    String data = await newParse;

    if (data.contains('FEE')) {
      fees = true;
      notifyListeners();
      print('Fees Module Provided');
    }
    if (data.contains('TT')) {
      timetable = true;
      notifyListeners();
    }
    if (data.contains('TAB')) {
      tabulation = true;
      notifyListeners();
    }
    if (data.contains('CC')) {
      curiculam = true;
      notifyListeners();
    }
    if (data.contains('OFFLINE_ATT')) {
      offlineAttendence = true;
      notifyListeners();
    }
    if (data.contains('OFFLINE_TAB')) {
      offlineTab = true;
      notifyListeners();
    }

    if (data.contains('ATT')) {
      attendenceEntry = true;
      notifyListeners();
    }
    if (data.contains('FEE_ONLY')) {
      feesOnly = true;
      notifyListeners();
    }
    if (data.contains('OFFLINE_FEES')) {
      offlineFees = true;
      notifyListeners();
    }
    if (data.contains('MOB_APP')) {
      mobileApp = await true;
      notifyListeners();
      print('Mobile App not provided');
    }

    log('Module Checked '.toString());

    notifyListeners();
  }
}
