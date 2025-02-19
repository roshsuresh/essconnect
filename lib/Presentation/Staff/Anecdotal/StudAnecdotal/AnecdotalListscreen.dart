
import 'package:essconnect/Constants.dart';
import 'package:essconnect/Presentation/Staff/Anecdotal/StudAnecdotal/AnecDotalEditScreen.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../Application/Staff_Providers/Anecdotal/AnecdotalStaffListProvider.dart';
import '../../../../Debouncer.dart';

class AnectdotalListScreen extends StatefulWidget {
  const AnectdotalListScreen({super.key});

  @override
  State<AnectdotalListScreen> createState() => _AnectdotalListScreenState();
}

class _AnectdotalListScreenState extends State<AnectdotalListScreen> {
  final controller = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);

  int? indexx;

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AnecdotalStaffListProviders>(context, listen: false);
      _scrollController.addListener(_scrollListener);

      await p.setLoading(false);
      p.anecDotalList.clear();
      p.currentPage=2;
      await p.getAnecdotalList();

      await p.getId();
      userId=p.userId;

    }
    );
  }

  Future<void> _refresh() async {
    // Simulate fetching new data
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      Provider.of<AnecdotalStaffListProviders>(context, listen: false).anecDotalList.clear();
    });
  }
  String? userId;
  void _scrollListener() async {
    final provider =
    Provider.of<AnecdotalStaffListProviders>(context, listen: false);
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (provider.hasMoreListData()) {
        print("object");
        provider.loadingPage
            ? const Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: UIGuide.light_Purple,
                ),
              ),
              kWidth,
              Text(
                "Please Wait...",
                style: TextStyle(
                    color: UIGuide.light_Purple,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              )
            ],
          ),
        ):
        controller.text.isEmpty?
        await provider.getAnecdotalListPagination():

        await provider.getAnecdotalListPaginationByName();

      }
    }
  }


  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body:Consumer<AnecdotalStaffListProviders>(
          builder: (context, value, _) =>

              Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(

                      children: [

                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              focusNode: FocusNode(),

                              controller: controller,
                              onChanged: (value1) {
                                _debouncer.run(() async {
                                  await Provider.of<AnecdotalStaffListProviders>(context,
                                      listen: false)
                                      .clearAnecdotal();
                                  value.currentPage=2;
                                  await Provider.of<AnecdotalStaffListProviders>(context,
                                      listen: false)
                                      .getAnecdotalListbyName(value1);
                                  print('-***--**-*-*-*-*-');
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      color: Colors.grey,
                                      onPressed: (() async{
                                        controller.clear();

                                        await Provider.of<AnecdotalStaffListProviders>(context,
                                            listen: false)
                                            .clearAnecdotal();
                                        value.currentPage=2;
                                        await Provider.of<AnecdotalStaffListProviders>(context,
                                            listen: false)
                                            .getAnecdotalListbyName('');

                                      }),
                                    ),
                                  ],
                                ),
                                hintText: 'Search By Name',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                                fillColor: UIGuide.light_black,
                                filled: true,
                                //  contentPadding: EdgeInsets.only(left: 8),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              style: const TextStyle(color: UIGuide.light_Purple),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                      child: Consumer<AnecdotalStaffListProviders>(
                        builder: (context, provider, child) {

                          if (value.anecDotalList.isNotEmpty) {
                            return

                              ListView.builder(
                                  controller: _scrollController,
                                  itemCount: value.anecDotalList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    DateTime dateTime = DateTime.parse(
                                        value.anecDotalList[index].date!);
                                    String formattedDate = DateFormat("dd-MM-yyyy")
                                        .format(dateTime);
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        decoration: BoxDecoration(

                                          color:
                                          const Color.fromARGB(
                                              255, 241, 243, 245),
                                          border: Border.all(

                                              color: UIGuide.light_black,
                                              width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  Container(

                                                    decoration: const BoxDecoration(

                                                        color: UIGuide.THEME_LIGHT
                                                    ),

                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: Text(
                                                        (index + 1).toString(),),
                                                    ),
                                                  ),


                                                  const Text("  Name : "),
                                                  Text(
                                                    value.anecDotalList[index].name
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: UIGuide.light_Purple
                                                    ),)
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  const Text("Admn No : "),
                                                  Text(value.anecDotalList[index]
                                                      .admissionNo.toString(),
                                                    style: const TextStyle(
                                                        color: UIGuide.light_Purple
                                                    ),)
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text("Date : "),
                                                      Text(formattedDate,
                                                        style: const TextStyle(
                                                            color: UIGuide
                                                                .light_Purple
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  kWidth,

                                                  Row(
                                                    children: [
                                                      const Text("Created By : "),
                                                      SizedBox(

                                                        width: size.width * 0.40,

                                                        child: Text(
                                                          value
                                                              .anecDotalList[index]
                                                              .createdBy
                                                              .toString(),

                                                          overflow: TextOverflow
                                                              .visible, // or TextOverflow.ellipsis, etc.
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                  bottom: 4.0,
                                                  left: 4.0,
                                                  right: 16),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text("Category: "),
                                                      SizedBox(
                                                        width: size.width * 0.5,
                                                        child: Text(
                                                          "${value
                                                              .anecDotalList[index]
                                                              .remarksCategory
                                                              .toString()} - ${value
                                                              .anecDotalList[index]
                                                              .subject == null
                                                              ? ""
                                                              : value
                                                              .anecDotalList[index]
                                                              .subject
                                                              .toString()}",
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .visible, // or TextOverflow.ellipsis, etc.
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(

                                                    children: [

                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.push(context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        AnecdotalEditScreen(
                                                                            id: value
                                                                                .anecDotalList[index]
                                                                                .id
                                                                                .toString())));
                                                          },
                                                          child: const Icon(
                                                            Icons.edit_sharp,
                                                            color: UIGuide
                                                                .button1,)
                                                      ),
                                                      kWidth,
                                                      value.anecDotalList[index]
                                                          .createStaffId != userId
                                                          ?
                                                      InkWell(
                                                          onTap: () {},
                                                          child: const Icon(Icons
                                                              .delete_forever_sharp,
                                                            color: Color.fromARGB(
                                                                100, 136, 47, 56),)
                                                      )
                                                          :

                                                      InkWell(onTap: () {
                                                        print(userId);
                                                        print(value
                                                            .anecDotalList[index]
                                                            .createStaffId);


                                                        showDialog(
                                                          context: context,
                                                          builder: (
                                                              BuildContext context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  'Are you sure want to delete'),
                                                              content: const Text(
                                                                  'You wont be able to revert this!'),
                                                              actions: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [

                                                                    TextButton(
                                                                      onPressed: () {
                                                                        // Close the dialog
                                                                        Navigator
                                                                            .of(
                                                                            context)
                                                                            .pop();
                                                                      },
                                                                      style: ButtonStyle(
                                                                        backgroundColor: WidgetStateProperty
                                                                            .all(
                                                                            UIGuide
                                                                                .THEME_LIGHT),
                                                                        padding: WidgetStateProperty
                                                                            .all(
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 20.0,
                                                                              vertical: 10.0),
                                                                        ),
                                                                        textStyle: WidgetStateProperty
                                                                            .all(
                                                                          const TextStyle(
                                                                              fontSize: 12.0),
                                                                        ),

                                                                        shape: WidgetStateProperty
                                                                            .all(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                8.0),
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      child: const Text(
                                                                        'Cancel',
                                                                        style: TextStyle(
                                                                            color: UIGuide
                                                                                .light_Purple
                                                                        ),),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        value
                                                                            .anecdotalDelete(
                                                                            context,
                                                                            value
                                                                                .anecDotalList[index]
                                                                                .id
                                                                                .toString(),
                                                                            index);
                                                                      },
                                                                      style: ButtonStyle(
                                                                        backgroundColor: WidgetStateProperty
                                                                            .all(
                                                                            UIGuide
                                                                                .THEME_LIGHT),
                                                                        padding: WidgetStateProperty
                                                                            .all(
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 20.0,
                                                                              vertical: 10.0),
                                                                        ),
                                                                        textStyle: WidgetStateProperty
                                                                            .all(
                                                                          const TextStyle(
                                                                              fontSize: 12.0),
                                                                        ),

                                                                        shape: WidgetStateProperty
                                                                            .all(
                                                                          RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius
                                                                                .circular(
                                                                                8.0),
                                                                          ),
                                                                        ),
                                                                      ),

                                                                      child: const Text(
                                                                        'OK',
                                                                        style: TextStyle(
                                                                            color: UIGuide
                                                                                .light_Purple
                                                                        ),),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                          child: const Icon(Icons
                                                              .delete_forever_sharp,
                                                            color: UIGuide
                                                                .button2,)),


                                                    ],
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              );
                          }

                          else {
                            Future.delayed(const Duration(seconds: 2));

                            return provider.loadingPage
                                ? spinkitLoader()
                                : Center(
                              child: LottieBuilder.network(
                                  'https://assets2.lottiefiles.com/private_files/lf30_lkquf6qz.json'),
                            );
                          }
                        },
                      )
                  ),

                  value.loadingPage
                      ? const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: UIGuide.light_Purple,
                          ),
                        ),
                        kWidth,
                        Text(
                          "Please Wait...",
                          style: TextStyle(
                              color: UIGuide.light_Purple,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        )
                      ],
                    ),
                  )
                      : const SizedBox(
                    height: 0,
                  )

                ],
              ),

        ));
  }
}
