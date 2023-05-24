import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_firebase_test/config/size_config.dart';
import 'package:flutter_firebase_test/style/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key ?key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(color: AppColors.secondaryBg),
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Container(
               height: 100,
               alignment: Alignment.topCenter,
               width: double.infinity,
               padding: const EdgeInsets.only(top: 20),
               child: SizedBox(
                    width: 35,
                    height: 20,
                    child: SvgPicture.asset('assets/mac-action.svg'),
                  ),
             ),
            
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/pie-chart.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/clipboard.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/credit-card.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/trophy.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                    'assets/invoice.svg',
                    color: AppColors.iconGray,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}