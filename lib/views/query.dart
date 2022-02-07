import 'package:flutter/material.dart';
import 'package:wethepeople/services/api/notification_api.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<NotificationListResponse>? notificationList;
  @override
  void initState() {
    super.initState();
    notificationList = createNotificationListState(context);
    // firebase(context);
    // setMenuColor();
    // createNotificationListState(context).then((value) => print(value.data));
  }

  // setMenuColor() {
  //   setState(() {
  //     isSelected = isSelected
  //         .asMap()
  //         .entries
  //         .map((entries) => entries.key == 1 ? true : false)
  //         .toList();
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  // onRefresh(context) {}

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    // var notification = context.watch<NotificationListResponse>().data;
    return SafeArea(
      child: Scaffold(
          // backgroundColor: themeColor,
          // backgroundColor: Colors.white10,
          // appBar: AppBar(
          //   backgroundColor: appBarColor,
          //   title: Text('NOTIFICATION'),
          //   centerTitle: true,
          //   actions: [
          //     // IconButton(
          //     //     icon: Icon(Icons.home),
          //     //     onPressed: () {
          //     //       // Navigator.of(context).push(
          //     //       //     MaterialPageRoute(builder: (context) => HomePage()));
          //     //     })
          //   ],
          // ),
          // appBar: AppBar(
          //   automaticallyImplyLeading: true,
          //   backgroundColor: appBarColor,
          //   title: Row(
          //     children: [
          //       Image.asset(
          //         'assets/soundpic.png',
          //         scale: 9.5,
          //       ),
          //       SizedBox(
          //         width: 15,
          //       ),
          //       Text("Notifications",
          //           maxLines: 1,
          //           overflow: TextOverflow.ellipsis,
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 15,
          //           )),
          //     ],
          //   ),
          // ),
          // drawer: CustomDrawer(),
          body: FutureBuilder(
              future: notificationList,
              builder:
                  (context, AsyncSnapshot<NotificationListResponse> snapshot) {
                if (snapshot.hasData) {
                  List notification = snapshot.data!.data;
                  return ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      Color titleFontColor = Colors.white;
                      return Card(
                        color: const Color(0xFF481621),
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height*0.5)),
                        elevation: 5,
                        child: ListTile(
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height*0.5)),
                          leading: Hero(
                            tag: notification[index]['image'],
                            child: SizedBox(
                              width: 80,
                              height: 100,
                              child: Image.network(
                                notification[index]['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          tileColor: Colors.transparent,
                          title: Text(
                            notification[index]['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: titleFontColor),
                          ),
                          subtitle: Text(
                            notification[index]['description'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xff929292),
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NotificationDetail(
                                  title: notification[index]['title'],
                                  subtitle: notification[index]['subtitle'],
                                  description: notification[index]
                                      ['description'],
                                  image: notification[index]['image'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}

class NotificationDetail extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String image;

  const NotificationDetail(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color titleFontColor = Colors.white;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: themeColor,
        // backgroundColor: Colors.black,
        // appBar: AppBar(
        //   title: Text('NOTIFICATION'),
        //   backgroundColor: Color(0xFF481621),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //         icon: Icon(Icons.arrow_back),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         })
        //   ],
        // ),
        // drawer: CustomDrawer(),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.01, vertical: height * 0.01),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 45,
                ),
                Flexible(
                  child: Text(
                    '$title',
                    style: TextStyle(fontSize: 18, color: titleFontColor),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFF481621),
                      // elevation: 4,
                    )),
              ],
            ),
            // Text(
            //   'Title: $title',
            //   style: TextStyle(fontSize: 18),
            // ),
            // SizedBox(
            //   height: height * 0.01,
            // ),
            // Text(
            //   'Subtitle: $subtitle',
            //   style: const TextStyle(
            //       color: Color(0xff929292),
            //       fontWeight: FontWeight.w500,
            //       fontSize: 16),
            // ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              '$description',
              style: TextStyle(fontSize: 14, color: titleFontColor),
              // style: textStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Hero(
                tag: image,
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                )),
          ],
        ),
      ),
    );
  }
}
