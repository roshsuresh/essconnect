import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Application/StudentProviders/AdminPortalResultprovider.dart';
import '../../utils/constants.dart';

class StudentPortal extends StatefulWidget {
  const StudentPortal({super.key});

  @override
  State<StudentPortal> createState() => _StudentPortal();
}

class _StudentPortal extends State<StudentPortal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var c = Provider.of<StudentPortalProvider>(context, listen: false);
      c.results.clear();
      await c.resultfn(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var c = Provider.of<StudentPortalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("School Portal"),
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: c.results.where((result) => result.active == true).length,
          itemBuilder: (context, index) {
            final activeResults = c.results.where((result) => result.active == true).toList();
            final result = activeResults[index];

            return GestureDetector(
              onTap: () {
                // When tapped, navigate to the next page
                _navigateToMatterPage(context, result.matter, result.title ?? "No Title");
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0), // Increased gap between items
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UIGuide.light_Purple,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  result.title ?? "No Title",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToMatterPage(BuildContext context, String? matter, String title) {
    // Check if matter is a URL
    if (matter != null && Uri.tryParse(matter)?.hasScheme == true) {
      launch(matter);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MatterPage(matter: matter ?? '', title: title),
        ),
      );
    }
  }
}

class MatterPage extends StatelessWidget {
  final String matter;
  final String title; // Title parameter

  const MatterPage({Key? key, required this.matter, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Regular expression to find URLs starting with https
    final RegExp urlRegExp = RegExp(r'(https:\/\/[^\s]+)');
    final Iterable<Match> matches = urlRegExp.allMatches(matter);

    // If a URL is found, launch it
    if (matches.isNotEmpty) {
      final String url = matches.first.group(0)!;
      _launchURL(context, url); // Launch URL and navigate back
      return const SizedBox(); // Return an empty SizedBox while handling redirection
    }

    // If no URL found, show the title and the matter
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'), // Use the title here
        titleSpacing: 0.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        backgroundColor: UIGuide.light_Purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, // Display the title in the body
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10), // Add some space between title and matter
            Text(
              matter,
              style: const TextStyle(fontSize: 13,color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false); // Open in external browser
    } else {
      throw 'Could not launch $url';
    }

    // Navigate back to the previous screen
    Navigator.pop(context);
  }
}
