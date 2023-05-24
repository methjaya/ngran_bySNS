import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase_test/misc/colors.dart';
import 'package:flutter_firebase_test/pages/fac.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';
import 'package:flutter_firebase_test/widgets/app_large_text.dart';
import 'package:flutter_firebase_test/widgets/app_text.dart';
import 'package:flutter_firebase_test/widgets/responsive_button.dart';

class Hall2_202 extends StatefulWidget {
  const Hall2_202({Key? key}) : super(key: key);

  @override
  State<Hall2_202> createState() => _Hall2_202();
}

class _Hall2_202 extends State<Hall2_202> with TickerProviderStateMixin {
  //In case if we need to map images 
  //var images = {
  //   "faculty.png": "Faculty",
  //   "notices.png": "Notices",
  //   "timetable.png": "Timetables",
  //   "updates.png": "Updates",
  // };


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
                    height: 570,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("img/2-202.png"),
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
                                builder: (context) => Fac(),
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios_new),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        )
                      ],
                    )),
                Positioned(
                    top: 550,
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
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppLargeText(
                                  text: "Place No: 202",
                                  //size:25,
                                  color: Colors.black.withOpacity(0.8)),
                              AppLargeText(
                                text: "\Second Floor",
                                color: AppColors.starColor,
                                size: 20,
                              )
                            ],
                          ),
                          SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                  // \n for line break
                  AppText(text: "Hall 202 is an Lecture Hall \n which is located on the RIGHT SIDE \nwhen enter to the First Floor using the \nmain entrance.",color: AppColors.mainTextColor,),
                  
                          
                          
                         
                        
                        ],
                        
                      ),
              ]),),
                // Positioned(
                //     bottom: 20,
                //     left: 20,
                //     right: 20,
                //     child: Row(
                //       children: [
                //         ResponsiveButton(
                //           isResponsive: true,
                //         )
                //       ],
                //     ))
            ),],
            )));
  }
}
