import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/admin/addEvent.dart';
import 'package:flutter_firebase_test/admin/add_admin.dart';
import 'package:flutter_firebase_test/admin/add_notice.dart';
import 'package:flutter_firebase_test/admin/updateEvent.dart';
import 'package:flutter_firebase_test/admin/update_notice.dart';
import 'package:flutter_firebase_test/component/appBarActionItems.dart';
import 'package:flutter_firebase_test/component/barChart.dart';
import 'package:flutter_firebase_test/component/header.dart';

import 'package:flutter_firebase_test/component/infoCard.dart';
import 'package:flutter_firebase_test/component/paymentDetailList.dart';
import 'package:flutter_firebase_test/component/sideMenu.dart';
import 'package:flutter_firebase_test/config/responsive.dart';
import 'package:flutter_firebase_test/config/size_config.dart';
import 'package:flutter_firebase_test/pages/detail_page.dart';
import 'package:flutter_firebase_test/pages/detail_page2.dart';
import 'package:flutter_firebase_test/style/colors.dart';
import 'package:flutter_firebase_test/style/style.dart';

class Dashboard extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // key: _drawerKey,
      // drawer: SizedBox(width: 100, child: SideMenu()),
      // appBar: !Responsive.isDesktop(context)
      //     ? AppBar(
      //         elevation: 0,
      //         backgroundColor: AppColors.white,
      //         leading: IconButton(
      //             onPressed: () {
      //               _drawerKey.currentState.openDrawer();
      //             },
      //             icon: Icon(Icons.menu, color: AppColors.black)),
      //         actions: [
      //           AppBarActionItems(),
      //         ],
      //       )

      //     : PreferredSize(
      //         preferredSize: Size.zero,
      //         child: SizedBox(),
      //       ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
                flex: 10,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 4,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddEvent(),
                                    ),
                                  );
                                },
                                child: InfoCard(
                                    icon: 'assets/add.svg',
                                    label: 'Add an \nEvent',
                                    amount: '\Add'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UpdateEvent(),
                                    ),
                                  );
                                },
                                child: InfoCard(
                                    icon: 'assets/edit.svg',
                                    label: 'Edit/Remove \nanEvent',
                                    amount: '\Edit'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddNotice(),
                                    ),
                                  );
                                },
                                child: InfoCard(
                                    icon: 'assets/add2.svg',
                                    label: 'Add Special \nNotices',
                                    amount: '\Add'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UpdateNotice(),
                                    ),
                                  );
                                },
                                child: InfoCard(
                                    icon: 'assets/edit2.svg',
                                    label: 'Edit/Remove \nSpecial Notices',
                                    amount: '\Edit'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterAdmin(),
                                    ),
                                  );
                                },
                                child: InfoCard(
                                    icon: 'assets/timetable2.svg',
                                    label: 'Timetable \nUpdation',
                                    amount: '\Update'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical!,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         PrimaryText(
                        //           text: 'Balance',
                        //           size: 16,
                        //           fontWeight: FontWeight.w400,
                        //           color: AppColors.secondary,
                        //         ),
                        //         PrimaryText(
                        //             text: '\$1500',
                        //             size: 30,
                        //             fontWeight: FontWeight.w800),
                        //       ],
                        //     ),
                        //     PrimaryText(
                        //       text: 'Past 30 DAYS',
                        //       size: 16,
                        //       fontWeight: FontWeight.w400,
                        //       color: AppColors.secondary,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical!,
                        ),
                        // Container(
                        //   height: 180,
                        //   child: BarChartCopmponent(),
                        // ),
                        // SizedBox(
                        //   height: SizeConfig.blockSizeVertical * 5,
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     PrimaryText(
                        //         text: 'History',
                        //         size: 30,
                        //         fontWeight: FontWeight.w800),
                        //     PrimaryText(
                        //       text: 'Transaction of lat 6 month',
                        //       size: 16,
                        //       fontWeight: FontWeight.w400,
                        //       color: AppColors.secondary,
                        //     ),
                        //   ],
                        // ),
                        // r
                      ],
                    ),
                  ),
                )),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(color: AppColors.secondaryBg),
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: const [
                          AppBarActionItems(),
                          // PaymentDetailList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
