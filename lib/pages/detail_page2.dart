import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase_test/misc/colors.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';
import 'package:flutter_firebase_test/widgets/app_large_text.dart';
import 'package:flutter_firebase_test/widgets/app_text.dart';
import 'package:flutter_firebase_test/widgets/responsive_button.dart';

import '../dashboard.dart';
import 'detail_page.dart';
import 'fac.dart';

class DetailPage2 extends StatefulWidget {
  const DetailPage2({Key? key}) : super(key: key);

  @override
  State<DetailPage2> createState() => _DetailPageState2();
}

class _DetailPageState2 extends State<DetailPage2>
    with TickerProviderStateMixin {
  var images = {
    "faculty.png": "Faculty",
    "notices.png": "Notices",
    "timetable.png": "Timetables",
    "updates.png": "Updates",
  };

  var images2 = {
    "1_1.png",
    "2_1.png",
    "1_1.png",
    //"welcome-two.png",
  };
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  //
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("img/cover2.png"),
                      fit: BoxFit.cover,
                    )),
                  ),
                  //
                ),
                Positioned(
                    left: 20,
                    top: 70,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios_new),
                          color: Color.fromRGBO(73, 141, 56, 1),
                        )
                      ],
                    )),
                Positioned(
                  top: 280,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(
                                text: "Green Buz'23",
                                color: Colors.black.withOpacity(0.8)),
                            AppLargeText(
                              text: "\05th June",
                              color: AppColors.starColor,
                              size: 20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color.fromRGBO(73, 141, 56, 1),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            AppText(
                              text: "C2006,Faculty of Business",
                              color: Color.fromRGBO(73, 141, 56, 0.8),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //AppLargeText(text: "Description",color:Colors.black.withOpacity(0.8),size:20,),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          SizedBox(
                            height: 8,
                          ),

                          AppLargeText(
                            text: "Description",
                            color: Colors.black.withOpacity(0.8),
                            size: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //AppText(text: "SNS Cyber Hackthon is one of the best Hackathons organized in Sri Lanka. This Hackathon was named after the 3 great Computer Geniuses Sahansa, Nethun & Sujeewa (SNS).",color: AppColors.mainTextColor,),
                        ]),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Renewing the Touch of Business.\n\nA comprehensive training program designed \nto help individuals and organizations improve \ntheir overall management skills and enhance \ntheir business performance.",
                                color: AppColors.mainTextColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ]),

                        Row(
                          children: [],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //2
                        SizedBox(
                          height: 10,
                        ),
                        AppLargeText(
                          text: "Quick Naigation Panel",
                          color: Colors.black.withOpacity(0.5),
                          size: 16,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //categories icons
                        Container(
                          height: 100,
                          margin: const EdgeInsets.only(left: 20),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              double spacing = constraints.maxWidth /
                                  10; // Set the spacing to be 1/10 of the screen width
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (int index = 0; index <4; index++)
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
                                                          const DetailPage2(),
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
                                                  color:
                                                      AppColors.mainTextColor,
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        ResponsiveButton(
                          isResponsive: true,
                        )
                      ],
                    ))
              ],
            )));
  }
}
