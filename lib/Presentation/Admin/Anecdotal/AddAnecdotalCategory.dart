import 'package:essconnect/Application/Staff_Providers/Anecdotal/AncedotalStaffProvider.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddanecDotalCategory extends StatefulWidget {
  AddanecDotalCategory({Key? key}) : super(key: key);

  @override
  State<AddanecDotalCategory> createState() => _AddanecDotalCategoryState();
}

class _AddanecDotalCategoryState extends State<AddanecDotalCategory> {
  final addCategoryController = TextEditingController();
  int? last;
  final sortController = TextEditingController();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<AnecdotalStaffProviders>(context, listen: false);
      await p.clearListcategoryListt();
      await p.categoryList();

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
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: const Text('Remarks Category'),
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
       sortController.text=value.lastNo.toString();
          return Column(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: addCategoryController,
                        minLines: 1,
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText: 'Remarks Category*',
                            labelStyle: const TextStyle(color: UIGuide.light_Purple),
                            hintText: 'Add Category',
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
                      //initialValue:value.lastNo.toString(),
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
                      child: Text(
                        'Save',
                        style: TextStyle(color: UIGuide.WHITE, fontSize: 18),
                      ),
                      // minWidth: size.width - 150,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      color: UIGuide.light_Purple,
                      onPressed: () async {
                        if (addCategoryController.text.isNotEmpty &&
                            sortController.text.isNotEmpty) {
                          await Provider.of<AnecdotalStaffProviders>(context,
                                  listen: false)
                              .anecdotalCategorySave(
                                  context,
                                  addCategoryController.text.toString(),
                                  sortController.text.toString());
                                   addCategoryController.clear();



                          await Provider.of<AnecdotalStaffProviders>(context,
                                  listen: false)
                              .clearListcategoryListt();
                          await Provider.of<AnecdotalStaffProviders>(context,
                                  listen: false)
                              .categoryList();
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
                      }),
                ),
              ),
              kheight20,
              Table(
                border:
                    TableBorder.all(color: Color.fromARGB(255, 255, 255, 255)),
                columnWidths: const {
                  0: FlexColumnWidth(0.8),
                  1: FlexColumnWidth(3.4),
                  2: FlexColumnWidth(0.8),
                  3: FlexColumnWidth(1),
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
                              'Sl No',
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
                              'Order',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
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
              Expanded(
                child: Consumer<AnecdotalStaffProviders>(
                  builder: (context, category, child) => category.loading
                      ? spinkitLoader()
                      : ListView.builder(

                          shrinkWrap: true,
                          itemCount: category.categoryListt.isEmpty
                              ? 0
                              : category.categoryListt.length,
                          itemBuilder: (context, index) {
                            return Table(
                              border: TableBorder.all(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              columnWidths: const {
                                0: FlexColumnWidth(0.8),
                                1: FlexColumnWidth(3.4),
                                2: FlexColumnWidth(0.8),
                                3: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color:
                                          Color.fromARGB(255, 247, 247, 247),
                                    ),
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                           "${index+1}"

                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        height: 35,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            category.categoryListt[index]
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
                                            category.categoryListt[index]
                                                .sortOrder ==
                                                null
                                                ? '0'
                                                : category
                                                .categoryListt[index]
                                                .sortOrder
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          String eventid = await category
                                                  .categoryListt[index].id ??
                                              '--';
                                          await category.anecDotalcategoryDelete(
                                              eventid, context);
                                          await category
                                              .clearListcategoryListt();
                                          await category.categoryList();
                                        },
                                        child: Container(
                                          width: 15,
                                          color: Colors.transparent,
                                          height: 30,
                                          child: Center(
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
              )
            ],
          );
        },
      ),
    );
  }
}
