import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Application/Staff_Providers/StaffProfile.dart';
import '../../Constants.dart';
import '../../utils/constants.dart';

class StaffProfileView extends StatelessWidget {
  const StaffProfileView({Key? key}) : super(key: key);

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
                                          fontWeight: FontWeight.w500,
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
                                      fontWeight: FontWeight.w500,
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
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 235, 234, 234),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 235, 234, 234),
                              ),
                              width: size.width,
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.home_outlined),
                                      Text(
                                        'Permenent Address',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      strutStyle:
                                          const StrutStyle(fontSize: 13),
                                      maxLines: 3,
                                      text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: UIGuide.light_Purple,
                                          ),
                                          text: value.address == null
                                              ? '----'
                                              : value.address.toString()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.person_outlined),
                                    Text(
                                      ' Gender : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                Text(
                                  value.gender == null
                                      ? '--'
                                      : value.gender.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                      color: UIGuide.light_Purple,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            kheight10,
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.cake_outlined),
                                    Text(
                                      ' DOB : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                Text(
                                  value.dateOfBirth == null
                                      ? '--'
                                      : value.dateOfBirth.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                      color: UIGuide.light_Purple,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            kheight10,
                            GestureDetector(
                              onTap: () {
                                _makingPhoneCall();
                              },
                              child: Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.phone),
                                      Text(
                                        ' Phone No : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    value.mobileNo == null
                                        ? '--'
                                        : value.mobileNo.toString(),
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        color: UIGuide.light_Purple,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            kheight10,
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.cake_outlined),
                                    Text(
                                      ' Short Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                Text(
                                  value.shortname == null
                                      ? '--'
                                      : value.shortname.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                      color: UIGuide.light_Purple,
                                      fontSize: 12),
                                )
                              ],
                            ),
                            kheight10,
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.email_outlined),
                                    Text(
                                      ' Email : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                Text(
                                  value.emailid == null
                                      ? '--'
                                      : value.emailid.toString(),
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: UIGuide.light_Purple,
                                  ),
                                )
                              ],
                            ),
                            kheight10,
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

  _makingPhoneCall() async {
    var url = Uri.parse("tel:807812564");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
