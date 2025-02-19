import 'package:essconnect/Constants.dart';
import 'package:essconnect/utils/constants.dart';
import 'package:flutter/material.dart';

import 'Peer_Assessment_Entry.dart';
import 'Peer_Learning_Entry.dart';
import 'Peer_Progress_Entry.dart';
import 'Self_Assessment_Entry.dart';
import 'Self_Learning_Entry.dart';
import 'Self_Progress_Grid_Entry.dart';
import 'Teachers_Feedback_Entry.dart';



class HpcCard extends StatelessWidget {
  final String title;
  final List<Color> gradientColors;
  Widget page;

  HpcCard({
    required this.title,
    required this.gradientColors,
    required this.page
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(_createRoute(page));
      },
      child: Container(
        width: 150,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child:
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,

                      ),
            ),
      ),
    );
  }
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right to left
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class HpcMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:UIGuide.WHITE,
        appBar:  AppBar(
        title: const Text('HPC'),
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
      body: Column(
        children: [
          kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: HpcCard(
                  title: "Teacher's Feedback Entry",
                  gradientColors: [Color(0xFFB2FEFA), Color(0xFF0ED2F7)],
                  page: HpcEntry(),

          ),
              ),
              SizedBox(width: 20),
              SizedBox(
                height: 150,
                child: HpcCard(
                  title: 'Self Assessment Entry',
                  gradientColors: [Color(0xFFFFE29F), Color(0xFFFFA6B7)],
                  page: SelfAssessmentEntry(),

                ),
              ),
            ],
          ),
         kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: HpcCard(
                  title: 'Peer Assessment Entry',
                  gradientColors: [Color(0xFFA8E6CF), Color(0xFFDCE775)],
                  page: PeerAssessmentEntry(),

                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                height: 150,
                child: HpcCard(
                  title: 'Self Progress Grid Entry',
                  gradientColors: [Color(0xFF96E6A1), Color(0xFFD4FC79)],
                  page: SelfProgressGridEntry(),

                ),
              ),
            ],
          ),
          kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: HpcCard(
                  title: 'Peer Progress Grid Entry',
                  gradientColors: [Color(0xFFFDEB71), Color(0xFFFFC3A0)],
                  page: PeerProgressGridEntry(),

                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                height: 150,
                child: HpcCard(
                  title: 'Self Learning Entry',
                  gradientColors: [Color(0xFFB9C4C9), Color(0xFF8FB0D6)],
                  page: SelfLearningEntry(),

                ),
              ),
            ],
          ),
          kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: HpcCard(
                  title: 'Peer Learning Entry',
                  gradientColors: [Color(0xFFE0BBE4), Color(0xFF957DAD)],
                  page: PeerLearningEntry(),

                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}






// class HPCMain extends StatelessWidget {
//   final List<String> captions = [
//     'Teachers Feedback Entry',
//     'Self Assessment Entry',
//     'Peer Assessment Entry',
//     'Self Progress Grid Entry',
//     'Peer Progress Grid Entry',
//     'Self Learning Entry',
//     'Peer Learning Entry',
//   ];
//
//   // Navigate to different pages based on index
//   void _navigateToPage(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HpcEntry()));
//         break;
//       case 1:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => SelfAssessmentEntry()));
//         break;
//       case 2:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => PeerAssessmentEntry()));
//         break;
//       case 3:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => SelfProgressGridEntry()));
//         break;
//       case 4:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => PeerProgressGridEntry()));
//         break;
//       case 5:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => SelfLearningEntry()));
//         break;
//       case 6:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => PeerLearningEntry()));
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: UIGuide.light_Purple,
//         centerTitle: true,
//         title: Text(
//           "HPC",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(25),
//               bottomLeft: Radius.circular(25)),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: captions.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(15.0),
//             child: ListTile(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0), // Rounded corners
//               ),
//               title: Center(child: Text(captions[index],style: TextStyle(
//                 fontWeight: FontWeight.w500
//               ),)),
//
//               onTap: () {
//                 _navigateToPage(context, index); // Navigate to different pages
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

