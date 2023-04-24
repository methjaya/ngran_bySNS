import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/dashboard.dart';
import 'package:flutter_firebase_test/misc/colors.dart';
import 'package:flutter_firebase_test/pages/hall001.dart';
import 'package:flutter_firebase_test/pages/hall002.dart';
import 'package:flutter_firebase_test/pages/hall003.dart';
import 'package:flutter_firebase_test/pages/hall004.dart';
import 'package:flutter_firebase_test/pages/hall005.dart';
import 'package:flutter_firebase_test/pages/hall006.dart';
import 'package:flutter_firebase_test/pages/hall007.dart';
import 'package:flutter_firebase_test/pages/hall008.dart';
import 'package:flutter_firebase_test/pages/hall009.dart';
import 'package:flutter_firebase_test/pages/hall010.dart';
import 'package:flutter_firebase_test/pages/hallL101.dart';
import 'package:flutter_firebase_test/pages/hallL102.dart';
import 'package:flutter_firebase_test/pages/hallL103.dart';
import 'package:flutter_firebase_test/pages/hallL104.dart';
import 'package:flutter_firebase_test/pages/hallL105.dart';
import 'package:flutter_firebase_test/pages/hallL106.dart';
import 'package:flutter_firebase_test/pages/hallL107.dart';
import 'package:flutter_firebase_test/pages/hallL108_A.dart';
import 'package:flutter_firebase_test/pages/hallL108_B.dart';
import 'package:flutter_firebase_test/pages/hallL108_C.dart';
import 'package:flutter_firebase_test/pages/hallL109.dart';
import 'package:flutter_firebase_test/pages/hallL110.dart';
import 'package:flutter_firebase_test/pages/hallL111.dart';
import 'package:flutter_firebase_test/pages/hallL112.dart';
import 'package:flutter_firebase_test/pages/hallL113.dart';
import 'package:flutter_firebase_test/pages/hallL114.dart';
import 'package:flutter_firebase_test/pages/hallL201.dart';
import 'package:flutter_firebase_test/pages/hallL202.dart';
import 'package:flutter_firebase_test/pages/hallL203.dart';
import 'package:flutter_firebase_test/pages/hallL204.dart';
import 'package:flutter_firebase_test/pages/hallL205.dart';
import 'package:flutter_firebase_test/pages/hallL206.dart';
import 'package:flutter_firebase_test/pages/hallL301.dart';
import 'package:flutter_firebase_test/pages/hallL302_A.dart';
import 'package:flutter_firebase_test/pages/hallL302_B.dart';
import 'package:flutter_firebase_test/pages/hallL302_C.dart';
import 'package:flutter_firebase_test/pages/hallL302_D.dart';
import 'package:flutter_firebase_test/pages/hallL303.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';
import 'package:flutter_firebase_test/widgets/app_large_text.dart';
import 'package:flutter_firebase_test/widgets/app_text.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'detail_page.dart';
import 'detail_page2.dart';
//lib

class Fac extends StatefulWidget {
  const Fac({Key? key}) : super(key: key);

  @override
  State<Fac> createState() => _FacState();
}

class _FacState extends State<Fac> with TickerProviderStateMixin {
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
    "001.png": "001",
    "002.png": "002",
    "003.png": "003",
    "004.png": "004",
    "005.png": "005",
    "006.png": "006",
    "007.png": "007",
    "008.png": "008",
    "009.png": "009",
    "010.png": "010",
  };

  var im3 = {
    "L101.png": "L101",
    "L102.png": "L102",
    "L103.png": "L103",
    "L104.png": "L104",
    "L105.png": "L105",
    "L106.png": "L106",
    "L107.png": "L107",
    "L108-A.png": "L108-A",
    "L108-B.png": "L108-B",
    "L108C.png": "L108-C",
    "L109.png": "L109",
    "L110.png": "L110",
    "L111.png": "L111",
    "L112.png": "L112",
    "L113.png": "L113",
    "L114.png": "L114",
  };

  var im4 = {
    "L201.png": "L201",
    "L202.png": "L202",
    "L203.png": "L203",
    "L204.png": "L204",
    "L205.png": "L205",
    "L206.png": "L206",
  };

  var im5 = {
    "L301.png": "L301",
    "L302-A.png": "L302-A",
    "L302-B.png": "L302-B",
    "L302-C.png": "L302-C",
    "L302-D.png": "L302-D",
    "L303.png": "L303",
  };

  @override
  Widget build(BuildContext context) {
    //the reason for putting TabControler is without it the tabs won't work unless an error will show
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Row(children: [
              GestureDetector(
          onTap: () {
            // Navigate to the intended page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          //
          child: Container(
            margin: const EdgeInsets.only(right: 200),
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(76, 175, 80, 1).withOpacity(0.5),
            ),
            child: Center(
              child: Text(
          '<',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
              ),
          ),
         ),
        ),
              // Container(
              //   margin: const EdgeInsets.only(right: 200),
              //   width: 50,
              //   height: 30,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     color: const Color.fromRGBO(76, 175, 80, 1).withOpacity(0.5),
              //   ),
              // ),
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
                child: AppLargeText(text: "Faculty Navigation"),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        
        
          const SizedBox(
            height: 10,
          ),
          //Categories begin
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(
                    text: "001 - 010 (G)",
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
              builder: (BuildContext context, BoxConstraints constraints) {
                double spacing = constraints.maxWidth /
                    10; // Set the spacing to be 1/10 of the screen width
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int index = 0; index < 10; index++)
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
                                        builder: (context) => const Hall001(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Hall002(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Hall003(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Hall004(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall005(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall006(),
                                      ),
                                    );
                                  }
                                  if (index == 6) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall007(),
                                      ),
                                    );
                                  }
                                  if (index == 7) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall008(),
                                      ),
                                    );
                                  }
                                  if (index == 8) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall009(),
                                      ),
                                    );
                                  }
                                  if (index == 9) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall010(),
                                      ),
                                    );
                                  }
                                  //check this
                                  if (index == 10) {
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
                                        builder: (context) => const Hall001(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Hall002(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Hall003(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Hall004(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall005(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall006(),
                                      ),
                                    );
                                  }
                                  if (index == 6) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall007(),
                                      ),
                                    );
                                  }
                                  if (index == 7) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall008(),
                                      ),
                                    );
                                  }
                                  if (index == 8) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall009(),
                                      ),
                                    );
                                  }
                                  if (index == 9) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Hall010(),
                                      ),
                                    );
                                  }
                                  //check this
                                  if (index == 10) {
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
        
          //2nd START
        
          const SizedBox(
            height: 05,
          ),
          //Categories begin
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(
                    text: "L101 - L114 (B1)",
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
              builder: (BuildContext context, BoxConstraints constraints) {
                double spacing = constraints.maxWidth /
                    10; // Set the spacing to be 1/10 of the screen width
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int index = 0; index < 16; index++)
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
                                          "img/${im3.keys.elementAt(index)}"),
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
                                        builder: (context) => const HallL101(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL102(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL103(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL104(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL105(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL106(),
                                      ),
                                    );
                                  }
                                  if (index == 6) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL107(),
                                      ),
                                    );
                                  }
                                  if (index == 7) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL108_A(),
                                      ),
                                    );
                                  }
                                  if (index == 8) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL108_B(),
                                      ),
                                    );
                                  }
                                  if (index == 9) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL108_C(),
                                      ),
                                    );
                                  }
                                  if (index == 10) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL109(),
                                      ),
                                    );
                                  }
                                  if (index == 11) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL110(),
                                      ),
                                    );
                                  }
                                  if (index == 12) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL111(),
                                      ),
                                    );
                                  }
                                  if (index == 13) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL112(),
                                      ),
                                    );
                                  }
                                  if (index == 14) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL113(),
                                      ),
                                    );
                                  }
                                  if (index == 15) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL114(),
                                      ),
                                    );
                                  }
                                  if (index == 16) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL114(),
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
                                    text: im3.values.elementAt(index),
                                    color: AppColors.mainTextColor,
                                  ),
                                ),
                                //text logic begin
        
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL101(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL102(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL103(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL104(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL105(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL106(),
                                      ),
                                    );
                                  }
                                  if (index == 6) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL107(),
                                      ),
                                    );
                                  }
                                  if (index == 7) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL108_A(),
                                      ),
                                    );
                                  }
                                  if (index == 8) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL108_B(),
                                      ),
                                    );
                                  }
                                  if (index == 9) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL108_C(),
                                      ),
                                    );
                                  }
                                  if (index == 10) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL109(),
                                      ),
                                    );
                                  }
                                  if (index == 11) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL110(),
                                      ),
                                    );
                                  }
                                  if (index == 12) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL111(),
                                      ),
                                    );
                                  }
                                  if (index == 13) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL112(),
                                      ),
                                    );
                                  }
                                  if (index == 14) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL113(),
                                      ),
                                    );
                                  }
                                  if (index == 15) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL114(),
                                      ),
                                    );
                                  }
                                  if (index == 16) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL114(),
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
        
          //2ND END
          //3RD START
        
          const SizedBox(
            height: 5,
          ),
          //Categories begin
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(
                    text: "L201 - L206 (B2)",
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
              builder: (BuildContext context, BoxConstraints constraints) {
                double spacing = constraints.maxWidth /
                    10; // Set the spacing to be 1/10 of the screen width
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int index = 0; index < 6; index++)
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
                                          "img/${im4.keys.elementAt(index)}"),
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
                                        builder: (context) => const HallL201(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL202(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL203(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL204(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL205(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL206(),
                                      ),
                                    );
                                  }
                                  //checl this also
                                  if (index == 6) {
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
                                    text: im3.values.elementAt(index),
                                    color: AppColors.mainTextColor,
                                  ),
                                ),
                                //text logic begin
        
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL201(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL202(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL203(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL204(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL205(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL206(),
                                      ),
                                    );
                                  }
                                  //checl this also
                                  if (index == 6) {
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
          
          //3RD END
        
          //4TH START
        
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
                    text: "L301 - L303 (B3)",
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
              builder: (BuildContext context, BoxConstraints constraints) {
                double spacing = constraints.maxWidth /
                    10; // Set the spacing to be 1/10 of the screen width
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int index = 0; index < 6; index++)
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
                                          "img/${im5.keys.elementAt(index)}"),
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
                                        builder: (context) => const HallL301(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL302_A(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL302_B(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL302_C(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL302_D(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL303(),
                                      ),
                                    );
                                  }
                                  //check this too too
                                  if (index == 6) {
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
                                    text: im3.values.elementAt(index),
                                    color: AppColors.mainTextColor,
                                  ),
                                ),
                                //text logic begin
        
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL301(),
                                      ),
                                    );
                                  }
                                  if (index == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL302_A(),
                                      ),
                                    );
                                  }
                                  if (index == 2) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL302_B(),
                                      ),
                                    );
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HallL302_C(),
                                      ),
                                    );
                                  }
                                  if (index == 4) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL302_D(),
                                      ),
                                    );
                                  }
                                  if (index == 5) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HallL303(),
                                      ),
                                    );
                                  }
                                  //check this too too
                                  if (index == 6) {
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
        
          //4TH END
        
          
       
          const SizedBox(
            height: 10,
          ),
        
          //SizedBox(height: 30,),
           ],
              ),
        )
        );
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
