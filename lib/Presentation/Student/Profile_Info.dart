import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:essconnect/Application/StudentProviders/ProfileProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Student/ProfileEdit.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Profile_Info extends StatelessWidget {
  const Profile_Info({Key? key}) : super(key: key);
  String formatDOB(String dobString) {
    // Parse the string into a DateTime object
    DateTime dob = DateTime.parse(dobString);

    // Format the DateTime object to 'dd-MMM-yyyy'
    return DateFormat('dd-MMM-yyyy').format(dob);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).profileData();

    var size = MediaQuery.of(context).size;

    var width = size.width;
    const Color background = Colors.white;
    const Color fill1 = Color.fromARGB(255, 70, 151, 226);
    const Color fill2 = UIGuide.light_Purple;
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 70, 151, 226),
        toolbarHeight: 0,
      ),
      body: Consumer<ProfileProvider>(
        builder: (_, provider, child) {
          return provider.loading
              ? spinkitLoader()
              : ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 260,
                          width: width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradient,
                              stops: stops,
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                            ),
                          ),
                        ),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


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



                            provider.editProfile == true
                                ? Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfileEdit()),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.mode_edit_outline_outlined,
                                        size: 25.0,
                                        color:
                                            Color.fromARGB(255, 232, 232, 250),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                          ],
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
                                      BorderRadius.all(Radius.circular(8))),
                              width: width - 50,
                              height: 170,
                              child: Column(
                                children: [
                                  kheight20,
                                  kheight20,
                                  kheight20,
                                  kheight10,
                                  Text(
                                    provider.studName == null
                                        ? '--'
                                        : provider.studName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        provider.division == null
                                            ? '--'
                                            : provider.division.toString(),
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color:
                                              Color.fromARGB(255, 82, 82, 82),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Table(
                                      border: TableBorder.all(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              255, 219, 219, 219)),
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                const Text('Roll No',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey)),
                                                Text(
                                                  provider.rollNo == null
                                                      ? '--'
                                                      : provider.rollNo
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                const Text(
                                                  'Adm No',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  provider.admissionNo == null
                                                      ? '--'
                                                      : provider.admissionNo
                                                          .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ])
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  provider.studPhoto == null
                                      ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg'
                                      : provider.studPhoto.toString(),
                                  scale: 1),
                              radius: 65,
                              backgroundColor: UIGuide.WHITE,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width,
                        color: const Color.fromARGB(255, 240, 243, 247),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              kheight10,
                              const Row(
                                children: [
                                  kWidth,
                                  Icon(Icons.person_outline_outlined),
                                  kWidth,
                                  Text(
                                    'Personal Info',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 20.0),
                                child: const Divider(
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Table(
                                  defaultColumnWidth:
                                      const FixedColumnWidth(200.0),
                                  children: [
                                    TableRow(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.cake_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.dob == null
                                                          ? '--'
                                                          : formatDOB(provider.dob
                                                          .toString()),
                                                      style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple),
                                                    ),
                                                    const Text(
                                                      'Birthday',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.person_outlined,
                                                      size: 22,
                                                    ),
                                                    kWidth,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          provider.gender
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'Gender',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.bloodtype_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.bloodGroup ==
                                                              null
                                                          ? '--'
                                                          : provider.bloodGroup
                                                              .toString(),
                                                      style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Blood Group',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.flag_outlined,
                                                      size: 22,
                                                    ),
                                                    kWidth,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          provider.houseGroup ==
                                                                  null
                                                              ? '--'
                                                              : provider
                                                                  .houseGroup
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'House Group',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.height_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.height == null
                                                          ? '0.00'
                                                          : provider.height
                                                              .toString(),
                                                      style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Height',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .line_weight_outlined,
                                                      size: 22,
                                                    ),
                                                    kWidth,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          provider.weight ==
                                                                  null
                                                              ? '0.00'
                                                              : provider.weight
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'Weight',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.sticky_note_2_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.classTeacher ==
                                                              null
                                                          ? '--'
                                                          : provider
                                                              .classTeacher
                                                              .toString(),
                                                      style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Class Teacher',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.location_on,
                                                      size: 22,
                                                    ),
                                                    kWidth,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          provider.area ==
                                                                      'NIL' ||
                                                                  provider.area ==
                                                                      null
                                                              ? '--'
                                                              : provider.area
                                                                  .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'Area',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.email_outlined,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.35,
                                                      child: Text(
                                                        provider.guardianEmail ??
                                                            "--",
                                                        style: const TextStyle(
                                                          color: UIGuide
                                                              .light_Purple,
                                                        ),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Guardian E-mail',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .phone_android_outlined,
                                                      size: 22,
                                                    ),
                                                    kWidth,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          provider.guardianMobile ??
                                                              "--",
                                                          style:
                                                              const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'Guardian Phone',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.directions_bus_sharp,
                                                  size: 22,
                                                ),
                                                kWidth,
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      provider.busName ==
                                                          null
                                                          ? '--'
                                                          : provider.busName
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: UIGuide
                                                            .light_Purple,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Bus',
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.departure_board,
                                                      size: 22,
                                                    ),
                                                    kWidth,
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          provider.busStop ==
                                                              null
                                                              ? '--'
                                                              : provider
                                                              .busStop
                                                              .toString(),
                                                          style:
                                                          const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple,
                                                          ),
                                                        ),
                                                        const Text(
                                                          'Stop',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black38,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            kheight10,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 240, 243, 247),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  width: width,
                                  // height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Permanent Address',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        LimitedBox(
                                          maxHeight: 250,
                                          child: Text(
                                            provider.address == null
                                                ? '---'
                                                : provider.address.toString(),
                                            maxLines: 6,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: UIGuide.light_Purple,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CarouselSlider(
                      items: [
                        Container(
                          width: width,
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: .5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      provider.fatherName == null
                                          ? '---'
                                          : provider.fatherName.toString(),
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    const Text(
                                      ' ( Father ) ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, bottom: 10, left: 10),
                                    child: Container(
                                      width: 60,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 244, 246, 255)),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                provider.fatherPhoto == null
                                                    ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLGZsYc8h4Zds-CgwVk_T5ykObxIbZKfvHtQ&usqp=CAU'
                                                    : provider.fatherPhoto
                                                        .toString(),
                                              )),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                  // kWidth,
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.phone_android_outlined,
                                                size: 12,
                                                color: UIGuide.light_Purple,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(provider.fatherMobileno ==
                                                      null
                                                  ? '+91 --'
                                                  : '+91 ${provider.fatherMobileno.toString()}')
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.email_outlined,
                                                size: 14,
                                                color: UIGuide.light_Purple,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: size.width / 3,
                                                child: Text(
                                                    provider.fatherMail ??
                                                        '--'),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // kheight10,
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width,
                          margin: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: UIGuide.light_Purple, width: .5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      provider.motherName == null
                                          ? '---'
                                          : provider.motherName.toString(),
                                      style: const TextStyle(
                                          color: UIGuide.light_Purple,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    const Text(
                                      ' ( Mother ) ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, bottom: 10, left: 10),
                                    child: Container(
                                      width: 60,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 244, 246, 255)),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                provider.motherPhoto == null
                                                    ? 'https://www.techniquehow.com/wp-content/uploads/2021/09/random-DP-image.png'
                                                    : provider.motherPhoto
                                                        .toString(),
                                              )),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                  ),
                                  // kWidth,
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.phone_android_outlined,
                                                size: 12,
                                                color: UIGuide.light_Purple,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(provider.motherMobileno ==
                                                      null
                                                  ? '+91 --'
                                                  : '+91 ${provider.motherMobileno.toString()}')
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.email_outlined,
                                                size: 14,
                                                color: UIGuide.light_Purple,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: size.width / 3,
                                                child: Text(
                                                    provider.motherMailId ??
                                                        '--'),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // kheight10,
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   width: width,
                        //   margin: const EdgeInsets.all(6.0),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       border: Border.all(
                        //         width: .5,
                        //         color: UIGuide.light_Purple,
                        //       ),
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(5))),
                        //   child: Column(
                        //     children: [
                        //       const Text(
                        //         'Mother',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(color: Colors.black),
                        //       ),
                        //       //kheight10,
                        //       Center(
                        //           child: Text(
                        //         provider.motherName == null
                        //             ? '---'
                        //             : provider.motherName.toString(),
                        //         style: const TextStyle(
                        //             color: UIGuide.light_Purple,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 12),
                        //       )),
                        //       Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           const Icon(
                        //             Icons.email_outlined,
                        //             size: 14,
                        //           ),
                        //           Flexible(
                        //             child: RichText(
                        //               overflow: TextOverflow.ellipsis,
                        //               strutStyle:
                        //                   const StrutStyle(fontSize: 12.0),
                        //               text: TextSpan(
                        //                   style: const TextStyle(
                        //                     color: UIGuide.light_Purple,
                        //                   ),
                        //                   text: provider.motherMailId == null
                        //                       ? '---'
                        //                       : provider.motherMailId
                        //                           .toString()),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Container(
                        //               width: 60,
                        //               height: 80,
                        //               decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   image: DecorationImage(
                        //                       fit: BoxFit.fill,
                        //                       image: NetworkImage(
                        //                         provider.motherPhoto == null
                        //                             ? 'https://www.techniquehow.com/wp-content/uploads/2021/09/random-DP-image.png'
                        //                             : provider.motherPhoto
                        //                                 .toString(),
                        //                       )),
                        //                   borderRadius: const BorderRadius.all(
                        //                       Radius.circular(10))),
                        //             ),
                        //           ),
                        //           kWidth,
                        //           Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               kheight10,
                        //               kheight10,
                        //               Row(
                        //                 children: [
                        //                   const Icon(
                        //                     Icons.phone_android_outlined,
                        //                     size: 12,
                        //                   ),
                        //                   Text(provider.motherMobileno == null
                        //                       ? '  +91 ----'
                        //                       : '  +91 ${provider.motherMobileno.toString()}')
                        //                 ],
                        //               ),
                        //               kheight10,
                        //             ],
                        //           )
                        //         ],
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: const EdgeInsets.all(6.0),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8.0),
                        //     image: const DecorationImage(
                        //       //fit: BoxFit.fitHeight,
                        //       image: NetworkImage(
                        //           "https://cdn.vectorstock.com/i/1000x1000/50/63/people-human-together-family-logo-icon-vector-32705063.webp"),
                        //     ),
                        //   ),
                        // ),
                      ],
                      options: CarouselOptions(
                        height: 150.0,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                    kheight10,
                  ],
                );
        },
      ),
    );
  }
}
