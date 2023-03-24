import 'package:flutter/cupertino.dart';
import 'package:ngram/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ngram/misc/colors.dart';
import 'package:ngram/widgets/app_large_text.dart';
import 'package:ngram/widgets/app_text.dart';
import 'package:ngram/widgets/responsive_button.dart';

class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;
  ResponsiveButton({Key? key,this.width,this.isResponsive=false}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Flexible(
      child: Container(
        width: width,
        height:60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(73, 141, 56, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            AppLargeText(text: "Inquire",color:Colors.white,size:20,),
          ],
        ),
      ),
    );
  }
}