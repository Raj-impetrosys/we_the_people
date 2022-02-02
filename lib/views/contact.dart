import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wethepeople/globals/app_constants.dart';
import 'package:wethepeople/globals/functions/on_back_button_pressed.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  void initState() {
    super.initState();
    // firebase(context);
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: newBody(context),
    );
  }
}

Widget newBody(context) {
  Color fontColor = Colors.black;
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.04,
          ),
          Image.asset('assets/images/contact_us.png'),
          SizedBox(
            height: height * 0.04,
          ),
          Text(
            'In order to resolve a complaint regarding the App or to receive further information regarding use of the App, please contact us at: ${Constants.projectName}',
            style: TextStyle(fontSize: 16, color: fontColor
                //fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          SizedBox(
              width: width * 0.5,
              child: Text(
                'Antigua',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: fontColor),
              )),
          SizedBox(
            height: height * 0.03,
          ),
          // GestureDetector(
          //   onTap: () async {
          //     await EmailLauncher.launch(Email(
          //       to: ['http://www.timelessgospel.com'],
          //     ));
          //   },
          //   child: Text(
          //     'http://www.timelessgospel.com',
          //     style: TextStyle(
          //         fontSize: 18, fontWeight: FontWeight.w600),
          //   ),
          // ),
          // SizedBox(
          //   height: height * 0.03,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // await EmailLauncher.launch(Email(
                      //   to: ['oswaldgreen70@gmail.com'],
                      // ));
                    },
                    child: Text(
                      'info@wtpantigua.com',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: fontColor),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await launch('tel:+1 (347)-756-8776');
                    },
                    child: Text(
                      '+1 347-756-8776',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: fontColor),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     launch('https://www.facebook.com/oarichards');
                  //   },
                  //   child: SizedBox(
                  //     height: height * 0.05,
                  //     child: Image.asset(
                  //       'assets/images/facebook.png',
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: width * 0.02,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     launch('https://www.instagram.com/djrichtime/');
                  //   },
                  //   child: SizedBox(
                  //       height: height * 0.05,
                  //       child: Image.asset(
                  //         'assets/images/insta.png',
                  //         fit: BoxFit.fill,
                  //       )),
                  // ),
                  // SizedBox(
                  //   width: width * 0.02,
                  // ),
                  GestureDetector(
                    onTap: () {
                      launch('https://wtpantigua.com');
                    },
                    child: SizedBox(
                        height: height * 0.05,
                        child: Image.asset(
                          'assets/images/website.png',
                          fit: BoxFit.fill,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
