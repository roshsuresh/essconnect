import 'package:essconnect/Constants.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';



class AdminLinks extends StatelessWidget {
  const AdminLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final linkController = TextEditingController();
   String url="https://www.facebook.com/";

    return Scaffold(

      body: Column(
        children: [
          kheight20,
          kheight10,
          GestureDetector(
            onTap: () => _launchURL(url),
            child: Text(
              "linkText",
              style: TextStyle(
                color: Colors.blue, // Change color to indicate it's a link
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),

    );
  }
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}