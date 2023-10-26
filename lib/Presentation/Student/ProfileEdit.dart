import 'dart:io';
import 'package:essconnect/Application/StudentProviders/ProfileProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _guardiancontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();
  final _bloodgroupcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _photoIDcontroller = TextEditingController();
  bool isEmailValid = true;

  void validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$');
    setState(() {
      isEmailValid = emailRegex.hasMatch(email);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<ProfileProvider>(context, listen: false);

      await p.getProfileEdit();
      _guardiancontroller.text = p.idOffline == null
          ? p.guardianNameEdit ?? ""
          : p.guardianNameOffline ?? "";
      _emailcontroller.text =
          p.idOffline == null ? p.emailIdEdit ?? "" : p.emailIdOffline ?? "";
      _mobilecontroller.text =
          p.idOffline == null ? p.mobileNoEdit ?? "" : p.mobileNoOffline ?? "";
      _bloodgroupcontroller.text = p.bloodGroup ?? "";
      _addresscontroller.text =
          p.idOffline == null ? p.addressEdit ?? "" : p.addressOffline ?? "";
      _photoIDcontroller.text = p.idOffline == null
          ? p.photoIdEdit ?? ""
          : p.studentPhotoIdOffline ?? "";
      p.selectedImage = null;
    });
  }

  bool load = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
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
      body: Consumer<ProfileProvider>(builder: (context, value, _) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: value.selectedImage != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          FileImage(value.selectedImage!),
                                      radius: 65,
                                      backgroundColor: Colors.white,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          value.idOffline == null
                                              ? value.studentPhotoEdit == null
                                                  ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg'
                                                  : value.studentPhotoEdit!.url
                                                      .toString()
                                              : value.studentPhotoOffline ==
                                                      null
                                                  ? 'https://gj-eschool-files-public.s3.ap-south-1.amazonaws.com/ess-connect/student/avathar-02.jpeg'
                                                  : value
                                                      .studentPhotoOffline!.url
                                                      .toString(),
                                          scale: 1),
                                      radius: 65,
                                      backgroundColor: UIGuide.WHITE,
                                    ),
                            ),
                            // value.selectedImage != null
                            //     ? Positioned(
                            //         right: -10,
                            //         child: InkWell(
                            //           onTap: () async {
                            //             await value.removeSelectedImage();
                            //             _photoIDcontroller.text = null;

                            //             snackbarWidget(
                            //                 2, "Image Removed", context);
                            //           },
                            //           child: Container(
                            //               decoration: BoxDecoration(
                            //                 color: Colors
                            //                     .grey, // Set the background color here
                            //                 shape: BoxShape
                            //                     .circle, // You can change the shape as needed
                            //               ),
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(4.0),
                            //                 child: Icon(Icons.close),
                            //               )),
                            //         ))
                            //     : SizedBox(
                            //         height: 0,
                            //         width: 0,
                            //       ),
                            Positioned(
                                right: -10,
                                bottom: 10,
                                // top: 87,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircleAvatar(
                                    backgroundColor: UIGuide.light_Purple,
                                    radius: 20,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon:
                                          const Icon(Icons.camera_alt_outlined),
                                      color: Colors.white,
                                      onPressed: () async {
                                        showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30)),
                                            ),
                                            builder: (BuildContext context) {
                                              return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        width: size.width / 3.5,
                                                        child: const Divider(
                                                          thickness: 5,
                                                          color: Color.fromARGB(
                                                              255,
                                                              188,
                                                              189,
                                                              190),
                                                        ),
                                                      ),
                                                    ),
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              "  Profile Photo",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 20),
                                                            )),
                                                      ],
                                                    ),
                                                    value.loadingg
                                                        ? SizedBox(
                                                            height: 0,
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      final result = await FilePicker.platform.pickFiles(
                                                                          type:
                                                                              FileType.custom,
                                                                          allowMultiple: false,
                                                                          allowedExtensions: [
                                                                            'jpeg',
                                                                            'jpg',
                                                                            'jfif'
                                                                          ]);

                                                                      if (result ==
                                                                          null) {
                                                                        return;
                                                                      }

                                                                      final file = result
                                                                          .files
                                                                          .first;
                                                                      int sizee =
                                                                          file.size;
                                                                      print(
                                                                          sizee);

                                                                      if (sizee <=
                                                                          200000) {
                                                                        await value.studentImageSave(
                                                                            context,
                                                                            file.path!);

                                                                        _photoIDcontroller
                                                                            .text = (value.attachmentid ==
                                                                                null
                                                                            ? null
                                                                            : value.attachmentid)!;

                                                                        setState(
                                                                            () {
                                                                          value.selectedImage =
                                                                              File(file.path!);
                                                                        });
                                                                      } else {
                                                                        print(
                                                                            'Size Exceed');
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(const SnackBar(
                                                                          elevation:
                                                                              10,
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                          ),
                                                                          duration:
                                                                              Duration(seconds: 1),
                                                                          margin: EdgeInsets.only(
                                                                              bottom: 80,
                                                                              left: 30,
                                                                              right: 30),
                                                                          behavior:
                                                                              SnackBarBehavior.floating,
                                                                          content:
                                                                              Text(
                                                                            "Size Exceed(Less than 200KB allowed)",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ));
                                                                      }

                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          child:
                                                                              Card(
                                                                            elevation:
                                                                                5,
                                                                            shape:
                                                                                CircleBorder(side: BorderSide(color: UIGuide.light_black)),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(8.0),
                                                                              child: Icon(
                                                                                Icons.add_photo_alternate_outlined,
                                                                                size: 35,
                                                                                color: UIGuide.light_Purple,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "Choose File",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                UIGuide.light_Purple,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )),
                                                                if (value
                                                                        .studentPhotoOffline !=
                                                                    null)
                                                                  InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        if (value.idOffline ==
                                                                            null) {
                                                                          snackbarWidget(
                                                                              2,
                                                                              "No image to delete",
                                                                              context);
                                                                        } else if (value.idOffline !=
                                                                                null &&
                                                                            value.studentPhotoIdOffline ==
                                                                                null) {
                                                                          print(
                                                                              "studentPhoto   ${value.studentPhotoIdOffline}");
                                                                          print(
                                                                              value.idOffline);
                                                                          snackbarWidget(
                                                                              2,
                                                                              "No image to delete",
                                                                              context);
                                                                          print(
                                                                              "object1");
                                                                        } else if (value.idOffline !=
                                                                                null &&
                                                                            value.studentPhotoIdOffline !=
                                                                                null) {
                                                                          await value.deleteStudentImage(
                                                                              context,
                                                                              value.studentPhotoIdOffline ?? "");

                                                                          _photoIDcontroller.text =
                                                                              value.studentPhotoIdOffline ?? "";
                                                                        } else {
                                                                          print(
                                                                              "object============");
                                                                          snackbarWidget(
                                                                              2,
                                                                              "No image to delete",
                                                                              context);
                                                                        }
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Card(
                                                                              elevation: 5,
                                                                              shape: CircleBorder(side: BorderSide(color: UIGuide.light_black)),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(8.0),
                                                                                child: Icon(
                                                                                  Icons.delete_outline_outlined,
                                                                                  size: 35,
                                                                                  color: UIGuide.light_Purple,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "Remove Image",
                                                                            style:
                                                                                TextStyle(
                                                                              color: UIGuide.light_Purple,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ))
                                                              ],
                                                            ),
                                                          )
                                                  ]);
                                            });
                                      },
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Center(
                        child: Text(
                      "[ Maximum allowed file size is 200 KB ]",
                      style: TextStyle(color: Colors.redAccent, fontSize: 10),
                    )),
                  ),
                  kheight10,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 55,
                      width: size.width,
                      child: TextField(
                        controller: _guardiancontroller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: "Guardian",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: size.width,
                      child: TextFormField(
                        controller: _emailcontroller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                        ),
                        onChanged: (value) {
                          validateEmail(value);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: size.width,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _mobilecontroller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: "Mobile",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SizedBox(
                  //     height: 50,
                  //     width: size.width,
                  //     child: TextField(
                  //       controller: _bloodgroupcontroller,
                  //       decoration: const InputDecoration(
                  //         contentPadding: EdgeInsets.only(bottom: 0),
                  //         labelText: "Blood Group",
                  //         labelStyle: TextStyle(
                  //           color: Colors.grey,
                  //         ),
                  //         enabledBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.black45),
                  //         ),
                  //         focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.black54),
                  //         ),
                  //       ),

                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 120,
                      width: size.width,
                      child: TextField(
                        controller: _addresscontroller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          labelText: "Address",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black45),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black54),
                          ),
                        ),
                        maxLines: null,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(500)
                        ],
                        keyboardType: TextInputType.multiline, //or null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (value.loadingg)
              Container(
                color: Colors.black.withOpacity(0.2),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(color: UIGuide.WHITE),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: UIGuide.light_Purple,
                            strokeWidth: 2,
                          ),
                          kWidth,
                          Text(
                            "Please Wait...",
                            style: TextStyle(
                                color: UIGuide.light_Purple,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
      bottomNavigationBar: Consumer<ProfileProvider>(
        builder: (context, value, _) => BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kWidth20,
              Expanded(
                  child: ElevatedButton(
                onPressed: value.loadingg
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: UIGuide.WHITE,
                  foregroundColor: UIGuide.light_Purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: UIGuide.light_Purple,
                      width: 2.0,
                    ),
                  ),
                ),
                child: const Text("Cancel",
                    style: TextStyle(color: UIGuide.light_Purple)),
              )),
              kWidth20,
              Expanded(
                  child: ElevatedButton(
                onPressed: value.loadingg
                    ? null
                    : () async {
                        if ((value.addressEdit != null) &&
                            _addresscontroller.text.trim().isEmpty) {
                          print("address empty");
                          snackbarWidget(
                              2, "Add address to continue...", context);
                        } else if (((value.mobileNoEdit != null) &&
                            _mobilecontroller.text.trim().isEmpty)) {
                          print("mobile empty");
                          snackbarWidget(
                              2, "Enter valid mobile number", context);
                        } else if (((value.guardianNameEdit != null) &&
                            _guardiancontroller.text.trim().isEmpty)) {
                          print("Guardian empty");
                          snackbarWidget(
                              2, "Enter Guardian name to continue", context);
                        } else if (((value.emailIdEdit != null) &&
                            _emailcontroller.text.trim().isEmpty)) {
                          print("email empty");
                          snackbarWidget(2, "Enter valid Email", context);
                        } else if (((value.mobileNoEdit != null) &&
                            _mobilecontroller.text.trim().length != 10)) {
                          snackbarWidget(
                              2, "Enter valid mobile number", context);
                        } else if (_mobilecontroller.text.length == 10 ||
                            _mobilecontroller.text.trim().isEmpty) {
                          if (isEmailValid ||
                              _emailcontroller.text.trim().isEmpty) {
                            value.idOffline == null
                                ? await value.getSaveProfile(
                                    context,
                                    value.offlineIdEdit ?? 0,
                                    value.installationIdEdit ?? 0,
                                    _guardiancontroller.text.trim(),
                                    _addresscontroller.text.trim(),
                                    _emailcontroller.text.trim(),
                                    _mobilecontroller.text.trim(),
                                    _photoIDcontroller.text.trim())
                                : await value.getUpdateProfile(
                                    context,
                                    value.offlineIdEdit ?? 0,
                                    value.installationIdEdit ?? 0,
                                    _guardiancontroller.text.trim(),
                                    _addresscontroller.text.trim(),
                                    _emailcontroller.text.trim(),
                                    _mobilecontroller.text.trim(),
                                    _photoIDcontroller.text.trim(),
                                    value.idOffline ?? '');
                          } else {
                            snackbarWidget(2, "Enter valid email", context);
                          }
                        } else {
                          snackbarWidget(2, "Something went wrong", context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: UIGuide.light_Purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child:
                    const Text("Save", style: TextStyle(color: Colors.white)),
              )),
              kWidth20
            ],
          ),
        ),
      ),
    );
  }
}
