import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:essconnect/Presentation/Admin/FlashNews/FlashnewsScreen.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Admin/FlashNewsList.dart';

class FlashNewsProviderAdmin with ChangeNotifier {
  DateTime? fromexam;
  String fromDateDis = '';
  late DateTime fromDateCheck;

  getVariables() {
    fromDateDis = '';
    toDateDis = '';
    notifyListeners();
  }

  //Get From date

  getFromDate(BuildContext context) async {
    fromexam = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );

    fromDateDis = DateFormat('dd/MMM/yyyy').format(fromexam!);
    fromDateCheck = DateTime(fromexam!.year, fromexam!.month, fromexam!.day);
    print(fromDateDis);
    notifyListeners();
  }

  // Get To date

  DateTime? toexam;
  String toDateDis = '';
  late DateTime toDateCheck;

  getToDate(BuildContext context) async {
    toexam = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: UIGuide.light_Purple,
              colorScheme: const ColorScheme.light(
                primary: UIGuide.light_Purple,
              ),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    toDateDis = DateFormat('dd/MMM/yyyy').format(toexam!);
    toDateCheck = DateTime(toexam!.year, toexam!.month, toexam!.day);
    print(toDateDis);
    notifyListeners();
  }

  Future flashNewsUpload(
    context,
    String entryDate,
    String displayStartDate,
    String displayEndDate,
    String news,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'POST', Uri.parse('${UIGuide.baseURL}/communication/flashnews/create'));
    request.body = json.encode({
      "EntryDate": entryDate,
      "DisplayStartDate": displayStartDate,
      "DisplayEndDate": displayEndDate,
      "News": news
    });
    print(json.encode({
      "EntryDate": entryDate,
      "DisplayStartDate": displayStartDate,
      "DisplayEndDate": displayEndDate,
      "News": news
    }));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Correct...______________________________');
      AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Success',
              desc: 'Uploaded Successfully',
              btnOkOnPress: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenFlashNews()));
              },
              btnOkIcon: Icons.cancel,
              btnOkColor: Colors.green)
          .show();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Something Went Wrong....',
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  //flash list

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<FlashnewsListAdmin> flashlist = [];
  Future getFlashnewsList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setLoading(true);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };

    var request = http.Request(
        'GET', Uri.parse('${UIGuide.baseURL}/mobileapp/admin/flash-news-list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(await response.stream.bytesToString());

      List<FlashnewsListAdmin> templist = List<FlashnewsListAdmin>.from(
          data["flashnewsList"].map((x) => FlashnewsListAdmin.fromJson(x)));
      flashlist.addAll(templist);
      setLoading(false);
      notifyListeners();
    } else {
      setLoading(false);
      print("Error in flashnewsList response");
    }
  }

  //delete flashnews

  Future flashnewsDelete(
      String eventID, BuildContext context, int indexx) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    };
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${UIGuide.baseURL}/communication/flashnews/delete-event/$eventID'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      flashlist.removeAt(indexx);
      print(await response.stream.bytesToString());
      print('correct');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        duration: Duration(seconds: 1),
        margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Deleted Succesfully',
          textAlign: TextAlign.center,
        ),
      ));

      notifyListeners();
    } else {
      print('Error in galleryDelete stf');
    }
  }
}
