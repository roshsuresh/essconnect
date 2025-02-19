import 'dart:io';

import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Application/Staff_Providers/StaffProfile.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class StaffProfileView extends StatelessWidget {
  const StaffProfileView({Key? key}) : super(key: key);
  String formatDOB(String dobString) {
    // Parse the string into a DateTime object
    DateTime dob = DateTime.parse(dobString);

    // Format the DateTime object to 'dd-MMM-yyyy'
    return DateFormat('dd-MMM-yyyy').format(dob);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const Color background = Colors.white;
    const Color fill1 = UIGuide.light_Purple;
    const Color fill2 = Color.fromARGB(255, 57, 149, 235);
    final List<Color> gradient = [
      fill1,
      fill2,
      background,
      background,
    ];
    const double fillPercent = 35;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIGuide.light_Purple,
        toolbarHeight: 0,
      ),
      body: Consumer<StaffProfileProvider>(
        builder: (context, value, child) => value.loading
            ? spinkitLoader()
            : ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 210,
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradient,
                            stops: stops,
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon:
                        Platform.isIOS?
                        Icon(Icons.arrow_back_ios_new,color:
                        Colors.white,size: 25.0):
                        Icon(Icons.arrow_back_outlined,color:
                        Colors.white,size: 25.0),
                      ),
                      Positioned(
                        top: 70,
                        left: 30,
                        right: 30,
                        child: Container(
                            decoration: const BoxDecoration(
                                color: UIGuide.WHITE,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 128, 125, 125),
                                    offset: Offset(
                                      2,
                                      5.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: size.width - 50,
                            height: 130,
                            child: Column(
                              children: [
                                kheight20,
                                kheight20,
                                kheight20,
                                kheight10,
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: const StrutStyle(fontSize: 13),
                                  maxLines: 3,
                                  text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: UIGuide.light_Purple),
                                      text: value.name == null
                                          ? '---'
                                          : value.name.toString()),
                                ),
                                Text(
                                  value.designation == null
                                      ? '---'
                                      : value.designation.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                                kheight10,
                              ],
                            )),
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(value.photo == null
                              ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg'
                              : value.photo.toString()),
                          radius: 65,
                          backgroundColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width - 20,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 128, 125, 125),
                            offset: Offset(
                              1,
                              2,
                            ),
                            blurRadius: 2.0,
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 251, 252, 255),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 5, right: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const Text(
                                  '  Gender : ',
                                ),
                                Text(
                                  value.gender == null
                                      ? '--'
                                      : value.gender.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: UIGuide.light_Purple,
                                  ),
                                )
                              ],
                            ),
                            kheight10,
                            Row(
                              children: [
                                const Icon(
                                  Icons.cake_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const Text(
                                  '  DOB : ',
                                ),
                                Text(
                                  value.dateOfBirth == null
                                      ? '--'
                                      : formatDOB(value.dateOfBirth.toString()),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: UIGuide.light_Purple,
                                  ),
                                )
                              ],
                            ),
                            kheight10,
                            GestureDetector(
                              onTap: () {
                                _makingPhoneCall(value.mobileNo.toString());
                              },
                              child: Row(
                                children: [


                                  const Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const Text(
                                    '  Phone No : ',
                                  ),
                                  Text(
                                    value.mobileNo == null
                                        ? '--'
                                        : value.mobileNo.toString(),
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: UIGuide.light_Purple,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            kheight10,
                            Row(
                              children: [
                                const Icon(
                                  Icons.cake_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const Text(
                                  '  Short Name : ',
                                ),
                                Text(
                                  value.shortname == null
                                      ? '--'
                                      : value.shortname.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            kheight10,
                            Row(
                              children: [
                                const Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const Text(
                                  '  Email : ',
                                ),
                                Text(
                                  value.emailid == null
                                      ? '--'
                                      : value.emailid.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    color: UIGuide.light_Purple,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            kheight10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.home_outlined,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    Text(
                                      '  Permanent Address',
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 26.0),
                                  child: LimitedBox(
                                    maxHeight: 250,
                                    child: Text(
                                      value.address ?? "--",
                                      maxLines: 6,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: UIGuide.light_Purple,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  _makingPhoneCall(String phn) async {
    var url = Uri.parse("tel:$phn");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
