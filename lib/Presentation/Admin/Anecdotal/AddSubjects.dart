
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import '../../../Constants.dart';
import '../../../utils/constants.dart';
import '../../../utils/spinkit.dart';

class AddSubjects extends StatefulWidget {
  const AddSubjects({Key? key}) : super(key: key);

  @override
  State<AddSubjects> createState() => _AddSubjectsState();
}

class _AddSubjectsState extends State<AddSubjects> {
  final addsubjectController = TextEditingController();

  final sortController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      await p.clearListsubjectListt();
      await p.getsubjectList();
      sortController.text = "${p.subjectList.length + 1}".toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            Provider.of<AnecdotalStaffProviders>(context, listen: false).getCategorySubject();

          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text('Diary Subject'),
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
      body: Consumer<AnecdotalStaffProviders>(
        builder: (context, value, child) {
          sortController.text = value.subLastno.toString();
          return ListView(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: addsubjectController,
                        minLines: 1,
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: 'Diary Subject*',
                            labelStyle: const TextStyle(color: UIGuide.light_Purple),
                            hintText: 'Add Subject',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: UIGuide.light_Purple, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            )),

                      ),
                    ),
                    kWidth,
                    SizedBox(
                      width: 70,
                      child: TextFormField(
                        controller: sortController,
                        minLines: 1,
                        inputFormatters: [LengthLimitingTextInputFormatter(3)],
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Order',
                            labelStyle: const TextStyle(color: UIGuide.light_Purple),
                            hintText: 'Order',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: UIGuide.light_Purple, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        enabled: false,

                      ),
                    ),
                  ],
                ),
              ),

              kheight20,
              Center(
                child: SizedBox(
                  width: 150,
                  height: 45,
                  child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0))),
                      color: UIGuide.light_Purple,
                      onPressed: () async {
                        if (addsubjectController.text.isNotEmpty &&
                            sortController.text.isNotEmpty) {
                          await Provider.of<AnecdotalStaffProviders>(context,
                              listen: false)
                              .anecdotalSubjctSave(
                              context,
                              addsubjectController.text.toString(),
                              sortController.text.toString());
                          addsubjectController.clear();



                          await Provider.of<AnecdotalStaffProviders>(context,
                              listen: false)
                              .clearListsubjectListt();
                          await Provider.of<AnecdotalStaffProviders>(context,
                              listen: false)
                              .getsubjectList();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                            ),
                            duration: Duration(seconds: 1),
                            margin: EdgeInsets.only(
                                bottom: 80, left: 30, right: 30),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Enter mandatory fields...',
                              textAlign: TextAlign.center,
                            ),
                          ));
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: UIGuide.WHITE, fontSize: 18),
                      )),
                ),
              ),
              kheight20,
              Table(
                border:
                TableBorder.all(color: const Color.fromARGB(255, 255, 255, 255)),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(1.2),
                },
                children: const [
                  TableRow(
                      decoration: BoxDecoration(
                        color: UIGuide.light_black,
                      ),
                      children: [
                        SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              'Order',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Center(
                              child: Text(
                                'Category',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                        ),
                        SizedBox(
                          height: 30,
                          child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )),
                        ),
                      ]),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: LimitedBox(
                  maxHeight: size.height / 2,
                  child: Consumer<AnecdotalStaffProviders>(
                    builder: (context, category, child) => category.loading
                        ? spinkitLoader()
                        : ListView.builder(
                      shrinkWrap: true,
                      itemCount: category.subjectList.isEmpty
                          ? 0
                          : category.subjectList.length,
                      itemBuilder: (context, index) {
                        return Table(
                          border: TableBorder.all(
                              color: const Color.fromARGB(255, 255, 255, 255)),
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(4),
                            2: FlexColumnWidth(1.2),
                          },
                          children: [
                            TableRow(
                                decoration: const BoxDecoration(
                                  color:
                                  Color.fromARGB(255, 247, 247, 247),
                                ),
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        category.subjectList[index]
                                            .sortOrder ==
                                            null
                                            ? '0'
                                            : category
                                            .subjectList[index]
                                            .sortOrder
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        category.subjectList[index]
                                            .name ??
                                            '--',
                                        maxLines: 2,

                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        category.subjectList[index]
                                            .sortOrder ==
                                            null
                                            ? '0'
                                            : category
                                            .subjectList[index]
                                            .sortOrder
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      String eventid = category
                                          .subjectList[index].id ??
                                          '--';
                                      await category.anecDotalSubjectDelete(
                                          eventid, context);
                                      await category
                                          .clearListsubjectListt();
                                      await category.getsubjectList();
                                    },
                                    child: Container(
                                      width: 15,
                                      color: Colors.transparent,
                                      height: 30,
                                      child: const Center(
                                          child: Icon(
                                            Icons.delete_outline_outlined,
                                            color: Colors.red,
                                          )),
                                    ),
                                  ),
                                ]),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
