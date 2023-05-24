import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/config/responsive.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';
import 'package:flutter_firebase_test/style/colors.dart';
import 'package:flutter_firebase_test/style/style.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: IconButton(
              onPressed: () {
                // Navigate to the intended page
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back),
              color: const Color.fromRGBO(76, 175, 80, 1),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            //width: 20,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    text: 'NGram Dashboard',
                    size: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ]),
          ),

          Spacer(
            flex: 500,
          ),
          SizedBox(width: 15),
          // Expanded(
          //   flex: Responsive.isDesktop(context) ? 1 : 3,
          //   child: TextField(
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: AppColors.white,
          //       contentPadding:
          //           EdgeInsets.only(left: 40.0, right: 5),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(30),
          //         borderSide: BorderSide(color: AppColors.white),
          //       ),
          //        focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(30),
          //         borderSide: BorderSide(color: AppColors.white),
          //       ),
          //       // prefixIcon: Icon(Icons.search, color: AppColors.black),
          //       // hintText: 'Search',
          //       // hintStyle: TextStyle(color: AppColors.secondary, fontSize: 14)
          //     ),
          //   ),
          // ),
        ]);
  }
}
