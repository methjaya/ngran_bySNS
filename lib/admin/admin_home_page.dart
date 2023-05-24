import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/admin/edit_admin_details.dart';
import 'package:flutter_firebase_test/dashboard.dart';
import 'package:flutter_firebase_test/misc/colors.dart';
import 'package:flutter_firebase_test/pages/detail_page.dart';
import 'package:flutter_firebase_test/pages/detail_page3.dart';
import 'package:flutter_firebase_test/pages/fac.dart';
import 'package:flutter_firebase_test/pages/nav_pages/time_table_view.dart';
import 'package:flutter_firebase_test/pages/notice_page.dart';
import 'package:flutter_firebase_test/widgets/app_large_text.dart';
import 'package:flutter_firebase_test/widgets/app_text.dart';
import 'package:flutter_firebase_test/widgets/eventbrowser.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../pages/detail_page2.dart';

//lib

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin>
    with TickerProviderStateMixin {
  var uname = "user";
  var userID;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    userName(); // Call the method to fetch the user name on initialization
  }

  Future<String> userName() async {
    try {
      final userID = auth.currentUser!.uid;
      var uname1 = await FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .get();
      setState(() {
        // Use setState to update the value of uname
        uname = uname1['firstName'].toString();
      });
      return "null";
    } catch (e) {
      return "null";
    }
  }

  List<Map<String, dynamic>> imagesAndTexts = [
    {
      "imagePath": "img/1_1.png",
      "lowerText": "SNS \nHackathon",
      "upperText": "FOC",
      "dotColor": Colors.green,
    },
    {
      "imagePath": "img/2_1.png",
      "lowerText": "Green Buz \n'23'",
      "upperText": "FOB",
      "dotColor": Colors.blue,
      // "loweText": "Green Buz \n'23",
      // "upperText": "FOB",
    },
    {
      "imagePath": "img/1_1.png",
      "lowerText": "Dart \nWorkshop",
      "upperText": "FOC",
      "dotColor": Colors.green,
    },
  ];

  //map ekak use krnw: to get different images
  var images = {
    "faculty.png": "Faculty",
    "notices.png": "Notices",
    "timetable.png": "Timetables",
    "updates.png": "Events",
    "user.png": "Dashboard",
  };
  var images2 = {
    "1_1.png",
    "2_1.png",
    //"welcome-two.png",
    //
  };
  @override
  Widget build(BuildContext context) {
    //the reason for putting TabControler is without it the tabs won't work unless an error will show
    TabController tabController = TabController(length: 3, vsync: this);
    return FutureBuilder(
        future: userName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 50, left: 20),
                      child: Row(children: [
                        Container(
                          margin: const EdgeInsets.only(right: 200),
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromRGBO(76, 175, 80, 1)
                                .withOpacity(0.5),
                          ),
                        ),
                        // Icon(Icons.account_circle_rounded,size:40,color:Color.fromRGBO(76, 175, 80, 1).withOpacity(0.7)),
                        DropdownButton(
                          underline: const SizedBox(),
                          items: [
                            DropdownMenuItem(
                              value: 'logout',
                              child: Row(
                                children: const <Widget>[
                                  Icon(Icons.exit_to_app),
                                  SizedBox(
                                    width: 8,
                                    height: 10,
                                  ),
                                  Text("Logout")
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'editDetails',
                              child: Row(
                                children: const <Widget>[
                                  Icon(Icons.edit_document),
                                  SizedBox(
                                    width: 8,
                                    height: 10,
                                  ),
                                  Text("Profile")
                                ],
                              ),
                            ),
                          ],
                          onChanged: (itemIdentifier) {
                            if (itemIdentifier == 'logout') {
                              FirebaseAuth.instance.signOut();
                            }
                            if (itemIdentifier == 'editDetails') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditAdminDetails()),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Color.fromARGB(255, 22, 165, 65),
                          ),
                        ),
                        Expanded(child: Container()),
                      ]),
                    ),
                    Row(
                      children: [
                        //blank Space
                        const SizedBox(
                          height: 50,
                        ),
                        //Greeting Text
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: AppLargeText(text: "Welcome $uname,"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Categories begin
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(
                              text: "Categories",
                              size: 22,
                            ),
                            //AppText(text: "See all",color: AppColors.textColor1,)
                          ],
                        )),
                    //Categories ends
                    const SizedBox(
                      height: 20,
                    ),

                    //categories icons
                    Container(
                      height: 100,
                      margin: const EdgeInsets.only(left: 20),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          double spacing = constraints.maxWidth /
                              10; // Set the spacing to be 1/10 of the screen width
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (int index = 0; index < 5; index++)
                                  Container(
                                    margin: EdgeInsets.only(right: spacing),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "img/${images.keys.elementAt(index)}"),
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                          // onTap: () {
                                          //   Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(builder: (context) => const DetailPage()),
                                          //   );
                                          // },

                                          //logic start

                                          onTap: () {
                                            if (index == 0) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Fac(),
                                                ),
                                              );
                                            }
                                            if (index == 1) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NoticesListWidget(),
                                                ),
                                              );
                                            }
                                            if (index == 2) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TimeTable(),
                                                ),
                                              );
                                            }
                                            if (index == 3) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EventBrowser(),
                                                ),
                                              );
                                            }
                                            if (index == 4) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Dashboard(),
                                                ),
                                              );
                                            }
                                          },

                                          //logic end
                                        ),
                                        const SizedBox(height: 5),
                                        InkWell(
                                          child: Container(
                                            child: AppText(
                                              text: images.values
                                                  .elementAt(index),
                                              color: AppColors.mainTextColor,
                                            ),
                                          ),
                                          //text logic begin

                                          onTap: () {
                                            if (index == 0) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DetailPage(),
                                                ),
                                              );
                                            }
                                            if (index == 1) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DetailPage(),
                                                ),
                                              );
                                            }
                                            if (index == 2) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DetailPage2(),
                                                ),
                                              );
                                            }
                                            if (index == 3) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Dashboard(),
                                                ),
                                              );
                                            }
                                            if (index == 4) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Dashboard(),
                                                ),
                                              );
                                            }
                                          },

                                          //text logic end
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //tabbar
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width -
                                32, // Subtracting the horizontal padding
                          ),
                          child: TabBar(
                            controller: tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: CircleTabIndicator(
                                color: AppColors.mainColor, radius: 4),
                            tabs: const [
                              Tab(
                                text: "Upcoming Events",
                                //icon: Icon(Icons.event),
                              ),
                              Tab(
                                text: "QR Code Scanner",
                                //icon: Icon(Icons.qr_code_scanner),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //T events bar starts

                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 300,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          ListView.builder(
                            itemCount: imagesAndTexts.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  navigateToPage(context, index);
                                  // navigate to the desired page here using Navigator.push or other methods
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 15, top: 10),
                                  width: 200,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        imagesAndTexts[index]["imagePath"] ??
                                            "",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: imagesAndTexts[index]
                                                        ["dotColor"] ??
                                                    Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 0.8),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                imagesAndTexts[index]
                                                        ["upperText"] ??
                                                    "",
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 155, 155, 155),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.8),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            imagesAndTexts[index]
                                                    ["lowerText"] ??
                                                "",
                                            style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          InkWell(
                            onTap: () {},
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: const QRViewExample(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //T events bar ends

                    //SizedBox(height: 30,),

                    // Padding(
                    //   padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    //   child: Container(
                    //     alignment: Alignment.bottomCenter,
                    //     child: Image.asset(
                    //       'img/logo-small.png',
                    //       height: 80,
                    //       alignment: Alignment.center,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Text(
                      "Error Initializing the app, Please try again later or contact an admin"),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}

void navigateToPage(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailPage()),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailPage2()),
      );
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DetailPage3()),
      );
      break;
    default:
      // Handle other cases here
      break;
  }
}

//to add the little dot
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    //TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 4 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, paint);
  }

  //TODO: implement createBoxPainter
}

// QR Code
class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  result != null
                      ? const Text(
                          'Attendance : Marked',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          'Attendance : Un-Marked',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
