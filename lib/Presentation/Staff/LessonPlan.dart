

import 'package:essconnect/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../utils/constants.dart';
class LessonPlan extends StatefulWidget {
  const LessonPlan({super.key});

  @override
  State<LessonPlan> createState() => _LessonPlanState();
}

class _LessonPlanState extends State<LessonPlan> {
  final courseController = TextEditingController();
  final subjectController = TextEditingController();
  final chapterController = TextEditingController();
  final objectiveController = TextEditingController();
  final materialController = TextEditingController();
  final selfevaluationController = TextEditingController();
  final learningController = TextEditingController();
  final referenceController = TextEditingController();

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    PdfGrid grid = PdfGrid();

//Add columns to grid
    grid.columns.add(count: 3);

//Add headers to grid
    PdfGridRow header = grid.headers.add(1)[0];
    header.cells[0].value = 'Employee ID';
    header.cells[1].value = 'Employee Name';
    header.cells[2].value = 'Salary';

//Add the styles to specific cell
    header.cells[0].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.bottom,
        wordSpacing: 10);
    header.cells[1].style.textPen = PdfPens.mediumVioletRed;
    header.cells[2].style.backgroundBrush = PdfBrushes.yellow;
    header.cells[2].style.textBrush = PdfBrushes.darkOrange;

//Add rows to grid
    PdfGridRow row1 = grid.rows.add();
    row1.cells[0].value = 'E01';
    row1.cells[1].value = 'Clay';
    row1.cells[2].value = '\$10,000';

//Apply the cell style to specific row cells
    row1.cells[0].style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.lightYellow,
      cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
      font: PdfStandardFont(PdfFontFamily.timesRoman, 17),
      textBrush: PdfBrushes.white,
      textPen: PdfPens.orange,
    );

    PdfGridRow row2 = grid.rows.add();
    row2.cells[0].value = 'E02';
    row2.cells[1].value = 'Simon';
    row2.cells[2].value = '\$12,000';

//Add the style to specific cell
    row2.cells[2].style.borders = PdfBorders(
        left: PdfPen(PdfColor(240, 0, 0), width: 2),
        top: PdfPen(PdfColor(0, 240, 0), width: 3),
        bottom: PdfPen(PdfColor(0, 0, 240), width: 4),
        right: PdfPen(PdfColor(240, 100, 240), width: 5));

//Draw the grid in PDF document page
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));


  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            const Text(
              'Lesson Planning',
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LessonPlan()));
                },
                icon: const Icon(Icons.refresh_outlined))
          ],
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
       body:ListView(
         children: [
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: SizedBox(
               height: 40,
               child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     elevation: 3,
                     foregroundColor: UIGuide.BLACK,
                     backgroundColor: UIGuide.ButtonBlue,
                     padding: const EdgeInsets.all(0),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                         side: const BorderSide(
                           color: UIGuide.light_black,
                         )),
                   ),
                   onPressed: () {
                     showDialog(
                         context: context,
                         builder: (context) {
                           return Dialog(
                               shape: RoundedRectangleBorder(
                                   borderRadius:
                                   BorderRadius.circular(15)),
                               child: LimitedBox(
                                 maxHeight: size.height / 1.3,
                                 // child: ListView.builder(
                                 //     shrinkWrap: true,
                                 //     itemCount:
                                 //     value.remarksCategoryList.length,
                                 //     itemBuilder: (context, index) {
                                 //       return ListTile(
                                 //         onTap: () async {
                                 //           Navigator.of(context).pop();
                                 //
                                 //           categoryController.text = value
                                 //               .remarksCategoryList[
                                 //           index]
                                 //               .text ??
                                 //               '--';
                                 //           categoryIDController
                                 //               .text = value
                                 //               .remarksCategoryList[
                                 //           index]
                                 //               .value ??
                                 //               '--';
                                 //         },
                                 //         title: Text(
                                 //           value.remarksCategoryList[index]
                                 //               .text ??
                                 //               '--',
                                 //           textAlign: TextAlign.start,
                                 //         ),
                                 //       );
                                     //}
                                     ),

                           );
                         });
                   },
                   child: TextField(
                     style: const TextStyle(
                         fontSize: 14,
                         fontWeight: FontWeight.w500,
                         color: UIGuide.BLACK,
                         overflow: TextOverflow.clip),
                     // textAlign: TextAlign.center,
                     controller: courseController,
                     decoration: const InputDecoration(
                         contentPadding: EdgeInsets.only(left: 5, top: 0),
                         floatingLabelBehavior:
                         FloatingLabelBehavior.never,
                         filled: true,
                         fillColor: Colors.transparent,
                         border: OutlineInputBorder(
                           borderSide: BorderSide(
                               style: BorderStyle.none, width: 0),
                         ),
                         labelText: "  Select Course *",
                         labelStyle: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w500,
                           color: UIGuide.BLACK,
                         )),
                     enabled: false,
                   )),
             ),
           ),
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: SizedBox(
               height: 40,
               child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     elevation: 3,
                     foregroundColor: UIGuide.BLACK,
                     backgroundColor: UIGuide.ButtonBlue,
                     padding: const EdgeInsets.all(0),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                         side: const BorderSide(
                           color: UIGuide.light_black,
                         )),
                   ),
                   onPressed: () {
                     showDialog(
                         context: context,
                         builder: (context) {
                           return Dialog(
                             shape: RoundedRectangleBorder(
                                 borderRadius:
                                 BorderRadius.circular(15)),
                             child: LimitedBox(
                               maxHeight: size.height / 1.3,
                               // child: ListView.builder(
                               //     shrinkWrap: true,
                               //     itemCount:
                               //     value.remarksCategoryList.length,
                               //     itemBuilder: (context, index) {
                               //       return ListTile(
                               //         onTap: () async {
                               //           Navigator.of(context).pop();
                               //
                               //           categoryController.text = value
                               //               .remarksCategoryList[
                               //           index]
                               //               .text ??
                               //               '--';
                               //           categoryIDController
                               //               .text = value
                               //               .remarksCategoryList[
                               //           index]
                               //               .value ??
                               //               '--';
                               //         },
                               //         title: Text(
                               //           value.remarksCategoryList[index]
                               //               .text ??
                               //               '--',
                               //           textAlign: TextAlign.start,
                               //         ),
                               //       );
                               //}
                             ),

                           );
                         });
                   },
                   child: TextField(
                     style: const TextStyle(
                         fontSize: 14,
                         fontWeight: FontWeight.w500,
                         color: UIGuide.BLACK,
                         overflow: TextOverflow.clip),
                     // textAlign: TextAlign.center,
                     controller: subjectController,
                     decoration: const InputDecoration(
                         contentPadding: EdgeInsets.only(left: 5, top: 0),
                         floatingLabelBehavior:
                         FloatingLabelBehavior.never,
                         filled: true,
                         fillColor: Colors.transparent,
                         border: OutlineInputBorder(
                           borderSide: BorderSide(
                               style: BorderStyle.none, width: 0),
                         ),
                         labelText: "  Select Subject *",
                         labelStyle: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w500,
                           color: UIGuide.BLACK,
                         )),
                     enabled: false,
                   )),
             ),
           ),
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: LimitedBox(
               maxHeight: 180,
               child: TextFormField(
                 inputFormatters: [LengthLimitingTextInputFormatter(200),
                   FilteringTextInputFormatter.deny(RegExp(r'^\s')),

                 ],
                 controller: chapterController,
                 minLines: 1,
                 maxLines: 15,
                 keyboardType: TextInputType.multiline,
                 decoration: const InputDecoration(
                   labelText: 'Chapter *',
                   hintText: 'Chapter Covered *',
                   labelStyle: TextStyle(color: UIGuide.light_Purple),
                   hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                         color: UIGuide.light_Purple, width: 1.0),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                 ),
               ),
             ),
           ),
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: LimitedBox(
               maxHeight: 180,
               child: TextFormField(
                 inputFormatters: [LengthLimitingTextInputFormatter(200),
                   FilteringTextInputFormatter.deny(RegExp(r'^\s')),

                 ],
                 controller: objectiveController,
                 minLines: 1,
                 maxLines: 15,
                 keyboardType: TextInputType.multiline,
                 decoration: const InputDecoration(
                   labelText: 'Objectives *',
                   hintText: 'Objectives *',
                   labelStyle: TextStyle(color: UIGuide.light_Purple),
                   hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                         color: UIGuide.light_Purple, width: 1.0),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                 ),
               ),
             ),
           ),
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: LimitedBox(
               maxHeight: 180,
               child: TextFormField(
                 inputFormatters: [LengthLimitingTextInputFormatter(200),
                   FilteringTextInputFormatter.deny(RegExp(r'^\s')),

                 ],
                 controller: materialController,
                 minLines: 1,
                 maxLines: 15,
                 keyboardType: TextInputType.multiline,
                 decoration: const InputDecoration(
                   labelText: 'Material Required *',
                   hintText: 'Material  *',
                   labelStyle: TextStyle(color: UIGuide.light_Purple),
                   hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                         color: UIGuide.light_Purple, width: 1.0),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                 ),
               ),
             ),
           ),
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: LimitedBox(
               maxHeight: 180,
               child: TextFormField(
                 inputFormatters: [LengthLimitingTextInputFormatter(200),
                   FilteringTextInputFormatter.deny(RegExp(r'^\s')),

                 ],
                 controller: learningController,
                 minLines: 1,
                 maxLines: 15,
                 keyboardType: TextInputType.multiline,
                 decoration: const InputDecoration(
                   labelText: 'Learning Outcome *',
                   hintText: 'Learning Outcome  *',
                   labelStyle: TextStyle(color: UIGuide.light_Purple),
                   hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                         color: UIGuide.light_Purple, width: 1.0),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                 ),
               ),
             ),
           ),
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: LimitedBox(
               maxHeight: 180,
               child: TextFormField(
                 inputFormatters: [LengthLimitingTextInputFormatter(200),
                   FilteringTextInputFormatter.deny(RegExp(r'^\s')),

                 ],
                 controller: selfevaluationController,
                 minLines: 1,
                 maxLines: 15,
                 keyboardType: TextInputType.multiline,
                 decoration: const InputDecoration(
                   labelText: 'Self Evaluation *',
                   hintText: 'Self Evaluation  *',
                   labelStyle: TextStyle(color: UIGuide.light_Purple),
                   hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                         color: UIGuide.light_Purple, width: 1.0),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                 ),
               ),
             ),
           ),
           kheight10,
           Padding(
             padding: const EdgeInsets.all(4.0),
             child: LimitedBox(
               maxHeight: 80,
               child: TextFormField(
                 inputFormatters: [LengthLimitingTextInputFormatter(200),
                   FilteringTextInputFormatter.deny(RegExp(r'^\s')),

                 ],
                 controller: referenceController,
                 minLines: 1,
                 maxLines: 15,
                 keyboardType: TextInputType.multiline,
                 decoration: const InputDecoration(
                   labelText: 'References *',
                   hintText: 'References  *',
                   labelStyle: TextStyle(color: UIGuide.light_Purple),
                   hintStyle: TextStyle(color: Colors.grey),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                         color: UIGuide.light_Purple, width: 1.0),
                     borderRadius: BorderRadius.all(Radius.circular(10)),
                   ),
                 ),
               ),
             ),
           ),
           kheight10,
         ],
       ) ,
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10, right: 10, top: 5, bottom: 5),
          child: SizedBox(
            height: 40,
            child:

            // Text("Net Total: ${snap.netAmount}")
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                foregroundColor: UIGuide.WHITE,
                backgroundColor: UIGuide.light_Purple,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: UIGuide.light_black,
                    )),
              ),
              onPressed: () async {
         _createPDF();
              },
              child:  Text(
               "Save"
              ),
            ),
          ),
        ),
      ),
    );
  }
}
