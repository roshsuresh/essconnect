import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_dropdown_with_select_all/multiselect_dropdown_with_select_all.dart';
import 'package:provider/provider.dart';
import '../../Application/AdminProviders/FeedbackProvider.dart';
import '../../utils/TextWrap(moreOption).dart';
import '../../utils/constants.dart';
import '../../utils/spinkit.dart';

class FeedbackList3 extends StatefulWidget {
  const FeedbackList3({Key? key}) : super(key: key);

  @override
  State<FeedbackList3> createState() => _FeedbackList3State();
}

class _FeedbackList3State extends State<FeedbackList3> {
  List<String> selectedCategoryIds = [];
  bool show = false;
  int? selectedRadio; // Variable to store the selected radio button value
  late String showreport;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FbProvider>(context, listen: false).fetchCategories();
    });
    selectedRadio =
        1; // Set the default selected radio button to the first option
  }

  void fetchFeedback(BuildContext context) {
    if (selectedCategoryIds.isNotEmpty) {
      if (selectedRadio == 1) {
        showreport = "category";
      } else {
        showreport = "date";
      }
      String categoryIds = selectedCategoryIds.join(',');
      Provider.of<FbProvider>(context, listen: false)
          .fetchFeedbackDetails(categoryIds, showreport);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fbProvider = Provider.of<FbProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback List'),
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
      body: fbProvider.isLoading
          ? Center(child: spinkitLoader())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 325,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MultiSelectDropdown(
                            items: fbProvider.categories
                                .map((category) => MultiSelectItem(
                                    category.value!, category.text!))
                                .toList(),
                            initialSelectedValues: selectedCategoryIds,
                            hint: 'Category',
                            isMultiSelect: true,
                            selectAllflag: true,
                            colorHeading: Color.fromARGB(255, 7, 68, 126),
                            colorPlaceholder: Colors.grey,
                            colorDropdownIcon: Color.fromARGB(255, 7, 68, 126),
                            radius: 10,
                            scrollbar: true,
                            borderColor: Color.fromARGB(255, 7, 68, 126),
                            onChanged: (values) {
                              setState(() {
                                show = false;
                                selectedCategoryIds = values;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // New Row with RadioButtons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio<int>(
                          value: 1,
                          activeColor: Color.fromARGB(255, 7, 68, 126),
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              show = false;
                              selectedRadio = value;
                            });
                          },
                        ),
                        const Text(
                          'Category-wise',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(
                          value: 2,
                          activeColor: Color.fromARGB(255, 7, 68, 126),
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              show = false;
                              selectedRadio = value;
                            });
                          },
                        ),
                        const Text(
                          'Date-wise',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: size.width * .22,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 7, 68, 126)),
                          ),
                          onPressed: () {
                            show = true;
                            fetchFeedback(context);
                          },
                          child: const Text(
                            'View',
                            style: TextStyle(fontSize: 12),
                          ),
                        )),
                    SizedBox(
                      width: size.width * .23,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 7, 68, 126)),
                        ),
                        onPressed: () {
                          setState(() {
                            show = false;
                            selectedCategoryIds = [];
                          });
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),

                show == true
                    ? Expanded(
                        child: Consumer<FbProvider>(
                          builder: (_, value, child) {
                            return fbProvider.isLoading
                                ? Center(child: spinkitLoader())
                                : fbProvider.errorMessage != null
                                    ? Center(
                                        child: Text(fbProvider.errorMessage!))
                                    : ListView.builder(
                                        itemCount: fbProvider
                                            .viewstudentdetails.length,
                                        itemBuilder: (context, categoryIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    showreport == "category"
                                                        ? fbProvider
                                                            .viewstudentdetails[
                                                                categoryIndex]
                                                            .category
                                                            .toString()
                                                        : _formatDate(fbProvider
                                                            .viewstudentdetails[
                                                                categoryIndex]
                                                            .createDate),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black54),
                                                  ),
                                                ),
                                                // SizedBox(height: 10),
                                                AnimationLimiter(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: fbProvider
                                                        .viewstudentdetails[
                                                            categoryIndex]
                                                        .feedbackList!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final feedback = fbProvider
                                                          .viewstudentdetails[
                                                              categoryIndex]
                                                          .feedbackList![index];
                                                      return AnimationConfiguration
                                                          .staggeredList(
                                                        position: index,
                                                        delay: Duration(
                                                            milliseconds: 100),
                                                        child: SlideAnimation(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  2500),
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          child:
                                                              FadeInAnimation(
                                                            curve: Curves
                                                                .fastLinearToSlowEaseIn,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    2500),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  // color: Color.fromARGB(255, 234, 234, 236),
                                                                  border: Border.all(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          7,
                                                                          68,
                                                                          126)),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            20),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          4.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "${fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].slNo}.",
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                          Text(
                                                                            "Adm.No: ${fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].admNo}",
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                          Text(
                                                                            "Div: ${fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].division}",
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              4),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Name      : ",
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                          Text(
                                                                              fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].student.toString(),
                                                                              style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 7, 68, 126), fontWeight: FontWeight.bold)),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              4),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Guardian : ",
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                          Text(
                                                                            fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].guardian.toString(),
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              4),
                                                                      showreport ==
                                                                              'date'
                                                                          ? Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Category : ",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].category.toString(),
                                                                                    style: const TextStyle(
                                                                                      fontSize: 12, // Adjust the font size as needed
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : SizedBox(
                                                                              width: 0,
                                                                              height: 0,
                                                                            ),
                                                                      SizedBox(
                                                                          height:
                                                                              4),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              "Feedback:",
                                                                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                                                                          SizedBox(
                                                                              width: 4),
                                                                          Expanded(
                                                                            child:
                                                                                TextWrapper(
                                                                              text: fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].matter.toString(),
                                                                              fSize: 12,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      showreport ==
                                                                              'category'
                                                                          ? Align(
                                                                              alignment: Alignment.bottomRight,
                                                                              child: Text(
                                                                                _formatDate(fbProvider.viewstudentdetails[categoryIndex].feedbackList![index].createDate),
                                                                                style: TextStyle(fontSize: 12, color: Colors.grey),
                                                                              ),
                                                                            )
                                                                          : SizedBox(
                                                                              width: 0,
                                                                              height: 0,
                                                                            )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                          },
                        ),
                      )
                    : const SizedBox(height: 0, width: 0),
              ],
            ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return "";
    }

    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
