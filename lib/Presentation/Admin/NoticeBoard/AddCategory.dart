import 'package:essconnect/Application/AdminProviders/NoticeBoardadmin.dart';
import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:essconnect/utils/spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final addCategoryController = TextEditingController();

  final sortController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var p = Provider.of<NoticeBoardAdminProvider>(context, listen: false);
      await p.clearListcategoryListt();
      await p.categoryList();
      sortController.text = "${p.categoryListt.length + 1}".toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
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
      body: Consumer<NoticeBoardAdminProvider>(
        builder: (context, value, child) {
          return ListView(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 8, top: 8),
                child: TextFormField(
                  controller: addCategoryController,
                  minLines: 1,
                  inputFormatters: [LengthLimitingTextInputFormatter(15)],
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      labelText: 'Category*',
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 8, top: 8),
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
                        if (addCategoryController.text.isNotEmpty &&
                            sortController.text.isNotEmpty) {
                          await Provider.of<NoticeBoardAdminProvider>(context,
                                  listen: false)
                              .categorySave(
                                  context,
                                  addCategoryController.text.toString(),
                                  sortController.text.toString());
                          await Provider.of<NoticeBoardAdminProvider>(context,
                                  listen: false)
                              .clearListcategoryListt();
                          await Provider.of<NoticeBoardAdminProvider>(context,
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
                  child: Consumer<NoticeBoardAdminProvider>(
                    builder: (context, category, child) => category.loaddg
                        ? spinkitLoader()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: category.categoryListt.isEmpty
                                ? 0
                                : category.categoryListt.length,
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
                                        SizedBox(
                                          height: 30,
                                          child: Center(
                                              child: Text(
                                            category.categoryListt[index]
                                                    .name ??
                                                '--',
                                          )),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            String eventid = category
                                                    .categoryListt[index].id ??
                                                '--';
                                            await category.categoryDelete(
                                                eventid, context);
                                            await category
                                                .clearListcategoryListt();
                                            await category.categoryList();
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
