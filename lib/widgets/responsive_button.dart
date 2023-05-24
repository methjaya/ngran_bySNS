import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;
  const ResponsiveButton({Key? key, this.width, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () async {
          const url = 'https://www.google.com';
          if (await canLaunch(url)) {
            print('Launching URL...');
            await launch(url);
            print('URL launched successfully!');
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Container(
          width: width,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(73, 141, 56, 1),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Inquire",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//-------------

// class ResponsiveButton extends StatelessWidget {
//   final bool? isResponsive;
//   final double? width;
//   ResponsiveButton({Key? key,this.width,this.isResponsive=false}) : super(key: key);

//   @override
//   Widget build(BuildContext context){
//     return Flexible(
//       child: GestureDetector(
//         onTap: () {
//           launch('https://www.google.com');
//         },
//         child: Container(
//           width: width,
//           height:60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Color.fromRGBO(73, 141, 56, 1),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AppLargeText(text: "Inquire",color:Colors.white,size:20,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
