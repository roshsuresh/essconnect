import 'package:essconnect/Application/AdminProviders/StaffReportProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../Domain/Admin/StaffReportModel.dart';
import '../../utils/constants.dart';

class StaffInfo extends StatefulWidget {

  StaffReportByAdmin staff;
   StaffInfo({Key? key, required this.staff}) : super(key: key);

  @override
  State<StaffInfo> createState() => _StaffInfoState();
}

class _StaffInfoState extends State<StaffInfo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIGuide.light_Purple,
        toolbarHeight: 0,
      ),
      body: Consumer<StaffReportProviders>(
        builder: (context, value, child) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: 190,
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: 120,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          UIGuide.light_Purple,
                          Color.fromARGB(255, 46, 127, 202),
                          Color.fromARGB(255, 100, 162, 219),
                        ]),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                  ),
                  Positioned(
                    top: 60,
                    left: 100,
                    right: 100,
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 211, 211, 211),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.staff
                                                .staffPhoto ==
                                            null
                                        ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-01.jpeg'
                                        : widget.staff.staffPhoto
                                            .toString())),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: UIGuide.WHITE,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1, 4),
                      blurRadius: 4,
                      spreadRadius: 1.5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Name : '),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: const StrutStyle(fontSize: 13),
                              maxLines: 2,
                              text: TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 44, 43, 43)),
                                  text: widget.staff.name ??
                                      '--'),
                            ),
                          ),
                        ],
                      ),
                      kheight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Designation : '),
                          Text(
                            widget.staff.designation ?? '--',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      kheight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.mobile_friendly,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Mobile Number : '),
                          Text(
                           widget.staff.mobileNo ?? '--',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      kheight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Email : '),
                          Text(
                          widget.staff.emailId ?? '--',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      kheight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.list_alt_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Section : '),
                          Text(
                           widget.staff.section ?? '--',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      kheight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.redeem_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Birthday : '),
                          Text(
                            widget.staff.dateOfBirth ?? '--',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      kheight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.man_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Gender : '),
                          Text(
                           widget.staff.gender ?? '--',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      kheight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.home_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Text('Address : '),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: const StrutStyle(fontSize: 13),
                              maxLines: 3,
                              text: TextSpan(
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 44, 43, 43)),
                                text: widget.staff.address ??
                                    '--',
                              ),
                            ),
                          ),
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
}
