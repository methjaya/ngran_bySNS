import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/misc/colors.dart';
import 'package:flutter_firebase_test/widgets/app_large_text.dart';
import 'package:flutter_firebase_test/widgets/app_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'detail_page.dart';
import 'detail_page2.dart';
//lib

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
    var uname = "user";
    var userID;
    final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> userName() async {
    try {
      final userID = auth.currentUser!.uid;
      // print(userID);
      var uname1 = await FirebaseFirestore.instance
          .collection("users")
          .doc(auth.currentUser!.uid)
          .get();
      // print(uname1['firstName']);
      uname = uname1['firstName'].toString();
      print(uname1['firstName'].toString());
      return "null";
    } catch (e) {
      print(e.toString());
      return "null";
    }
  }
  //map ekak use krnw: to get different images
  var images = {
    "faculty.png":"Faculty",
    "notices.png":"Notices",
    "timetable.png":"Timetables",
    "updates.png":"Updates",
    
  };
  var images2 = {
    "1_1.png",
    "2_1.png",
    //"welcome-two.png",
  };
  @override
  Widget build(BuildContext context) {
    //the reason for putting TabControler is without it the tabs won't work unless an error will show
      TabController _tabController =TabController(length: 3, vsync: this);
    return Scaffold(
      
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top:50,left:20),
            child: Row(
              children: [
                Container(
                  
                  margin: const EdgeInsets.only(right:200),
                  width: 50,
                  height:30,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(76, 175, 80, 1).withOpacity(0.5),
                  ),
                ),
                // Icon(Icons.account_circle_rounded,size:40,color:Color.fromRGBO(76, 175, 80, 1).withOpacity(0.7)),
                DropdownButton(
                  underline: SizedBox(),
                  items: [
                    DropdownMenuItem(
                      value: 'logout',
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 8,
                              height: 10,
                            ),
                            Text("Logout")
                          ],
                        ),
                      ),
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == 'logout') {
                      FirebaseAuth.instance.signOut();
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Color.fromARGB(255, 22, 165, 65),
                  ),
                ),
                Expanded(child:Container()),
                
              ]),
              
                
              
          ),
          Row(
                children: [
                  //blank Space
                SizedBox(height: 50,),
                //Greeting Text
                Container(
                  margin:const EdgeInsets.only(left:20),
                  child: AppLargeText(text: "Welcome $uname,"),
                ),
                
                ],),
                SizedBox(height: 20,),
                //Categories begin
                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    AppLargeText(text: "Categories", size: 22,),
                    //AppText(text: "See all",color: AppColors.textColor1,)

                  ],
                )
              ),
              //Categories ends
              SizedBox(height: 15,),

              //categories icons
              Container(
                height: 100,
                width:double.maxFinite,
                margin: const EdgeInsets.only(left:20),
                child: ListView.builder(

                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(_,index){
                      return Container(
                        margin:const EdgeInsets.only(right: 35) ,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                                //margin: const EdgeInsets.only(right: 50),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image:DecorationImage(
                                    image:AssetImage(
                                      "img/"+images.keys.elementAt(index) //methana uda index eken ganne
                                  ),
                                    fit:BoxFit.scaleDown,
                                  )
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
                              },
                          ),
                           
                            SizedBox(height:5,),
                            InkWell(
                              child: Container(
                                child: AppText(
                                  
                                  text:images.values.elementAt(index),
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage2()));
                    })
                        ],
                      ),
                    );
                  },
               )
             ),

                 SizedBox(height: 10,),

                //tabbar
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left:20, right:50),
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(color: AppColors.mainColor,radius: 4),
                  
                      tabs: [
                        Tab(text:"Upcoming Events"),
                        //Tab(text:" "),
                        
                        Tab(text:"QR Code Scanner"),
                      ]),
                  ),
                ),
                 SizedBox(height: 30,),
                //events bar
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      height: 300,
                      width: double.maxFinite,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context,int index){
                              return 
                                Container(
                                  
                                  margin: const EdgeInsets.only(right: 15,top: 10),
                                  width: 200,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image:DecorationImage(
                                      image:AssetImage(
                                       "img/"+images2.elementAt(index)
                                      //  "img/1_1.png"
                                      //  "img/2_1.png"
                                    ),
                                    fit:BoxFit.cover,
                                    )
                                  ),
                                );
                                Container(
                                  
                                  margin: const EdgeInsets.only(right: 15,top: 10),
                                  width: 200,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image:DecorationImage(
                                      image:AssetImage(
                                      "img/"+images2.elementAt(index)
                                      //  "img/1_1.png"
                                      //  "img/2_1.png"
                                    ),
                                    fit:BoxFit.cover,
                                    )
                                  ),
                                );
                            },
                            
                          ),
                          // This contains the QR Code Scanner
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.8, // 80% of the screen width
                            height: MediaQuery.of(context).size.height *
                                0.6, // 60% of the screen height
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.width *
                                      0.6, // 60% of the screen width
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // 60% of the screen width
                                  child: const QRViewExample(),
                                ),
                              ],
                            ),
                          ),
                         
                        ]),
                    ),
                    onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
                              },
                ),
                
                //SizedBox(height: 30,),
                      
          ],
        )
    );
  }
}

//to add the little dot
class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    //TODO: implement createBoxPainter
    return _CirclePainter(color:color,radius:radius);


  }
}

class _CirclePainter extends BoxPainter{
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, 
  ImageConfiguration configuration){
    Paint _paint = Paint();
    _paint.color=color;
    _paint.isAntiAlias=true;
    final Offset circleOffset = Offset(configuration.size!.width/4 -radius/2,configuration.size!.height-radius);

    canvas.drawCircle(offset+circleOffset, radius, _paint);

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
          cutOutSize: scanArea),
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
