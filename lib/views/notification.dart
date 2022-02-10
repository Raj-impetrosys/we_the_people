import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wethepeople/globals/functions/on_back_button_pressed.dart';
import 'package:wethepeople/services/api/notification_api.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<NotificationListResponse> notificationList;
  @override
  void initState() {
    super.initState();
    notificationList = createNotificationListState(context);
    // firebase(context);
    // createNotificationListState(context).then((value) => print(value.data));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onRefresh(context) async {
    setState(() {
      notificationList = createNotificationListState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    // var notification = context.watch<NotificationListResponse>().data;
    return WillPopScope(
      onWillPop: () {
        return onBackButtonPressed(context);
      },
      child: RefreshIndicator(
        onRefresh: () {
          return onRefresh(context);
        },
        child: Scaffold(
            // backgroundColor: backgroundColor,
            // backgroundColor: Colors.white10,
            // appBar: AppBar(
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
            // drawer: CustomDrawer(),
            body: FutureBuilder(
                future: notificationList,
                builder: (context,
                    AsyncSnapshot<NotificationListResponse> snapshot) {
                  if (snapshot.hasData) {
                    List notification = snapshot.data.data;
                    return ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.005),
                          child: Card(
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
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              tileColor: Colors.transparent,
                              title: Text(
                                notification[index]['title'], maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                // style: Text,
                              ),
                              subtitle: Text(
                                notification[index]['subtitle'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Color(0xff929292),
                                    fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
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
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })),
      ),
    );
  }
}

class NotificationDetail extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String image;

  const NotificationDetail(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.description,
      @required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: backgroundColor,
      // backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text('NOTIFICATION'),
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.01, vertical: height * 0.01),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Title: $title',
                  style: const TextStyle(fontSize: 18),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
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
            Text(
              'Subtitle: $subtitle',
              style: const TextStyle(
                  color: Color(0xff929292),
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 16),
              // style: textStyle,
            ),
            const SizedBox(
              height: 10,
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
