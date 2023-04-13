import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/admin/add_admin.dart';
import 'package:flutter_firebase_test/admin/datetimepicker.dart';
import 'package:flutter_firebase_test/admin/fileuploader.dart';
import 'package:flutter_firebase_test/admin/selectEvent.dart';
import 'package:flutter_firebase_test/admin/updateEvent.dart';
import 'package:flutter_firebase_test/admin/update_notice.dart';
import 'package:flutter_firebase_test/dashboard.dart';
import 'package:flutter_firebase_test/misc/colors.dart';
import 'package:flutter_firebase_test/pages/notice_page.dart';
import 'package:flutter_firebase_test/widgets/app_large_text.dart';
import 'package:flutter_firebase_test/widgets/app_text.dart';
import 'package:flutter_firebase_test/widgets/eventbrowser.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'detail_page.dart';
import 'detail_page2.dart';
//lib

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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

  //map ekak use krnw: to get different images
  var images = {
    "faculty.png": "Faculty",
    "notices.png": "Notices",
    "timetable.png": "Timetables",
    "updates.png": "Updates",
    "user.png": "Dashboard",
  };
  var images2 = {
    "1_1.png",
    "2_1.png",
    //"welcome-two.png",
  };
  @override
  Widget build(BuildContext context) {
    //the reason for putting TabControler is without it the tabs won't work unless an error will show
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: Column(
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
                color: const Color.fromRGBO(76, 175, 80, 1).withOpacity(0.5),
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
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
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
          height: 15,
        ),

        //categories icons
        Container(
          height: 100,
          margin: const EdgeInsets.only(left: 20),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
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
                                          const RegisterAdmin(),
                                    ),
                                  );
                                }
                                if (index == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Material(child: NoticesListWidget()),
                                    ),
                                  );
                                }
                                if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DetailPage2(),
                                    ),
                                  );
                                }
                                if (index == 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EventBrowser(),
                                    ),
                                  );
                                }
                                if (index == 4) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
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
                                  text: images.values.elementAt(index),
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              //text logic begin

                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DetailPage(),
                                    ),
                                  );
                                }
                                if (index == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DetailPage(),
                                    ),
                                  );
                                }
                                if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DetailPage2(),
                                    ),
                                  );
                                }
                                if (index == 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
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
          height: 10,
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
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator:
                    CircleTabIndicator(color: AppColors.mainColor, radius: 4),
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
        //events bar
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: 300,
          width: double.maxFinite,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailPage2(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, top: 10),
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(
                            "img/${images2.elementAt(index)}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  // navigate to another page here
                },
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                        child: const QRViewExample(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //SizedBox(height: 30,),
      ],
    ));
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
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 4 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
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
