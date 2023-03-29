import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase_test/misc/colors.dart';
import 'package:flutter_firebase_test/widgets/app_large_text.dart';
import 'package:flutter_firebase_test/widgets/app_text.dart';
import 'package:flutter_firebase_test/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
  
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin{
   
   var images = {
    "faculty.png":"Faculty",
    "notices.png":"Notices",
    "timetable.png":"Timetables",
    "updates.png":"Updates",
    
  };

   var images2 = {
    "1_1.png",
    "2_1.png",
    "1_1.png",
    //"welcome-two.png",
  };
  @override
  Widget build(BuildContext context) {
    TabController _tabController =TabController(length: 3, vsync:this);
    return Scaffold(
      
      body: Container(
        
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(//
                left:0, 
                right:0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    image:DecorationImage(
                      image: AssetImage("img/cover1.png"),
                      fit: BoxFit.cover,

                    )
                  ),
                ),
                    //
            ),
            Positioned(
              left: 20,
              top:70,
              
              child: Row(    
              children: [
                IconButton(onPressed: (){
                  
                }, icon: Icon(Icons.arrow_back_ios_new),
                color: Color.fromRGBO(73, 141, 56, 1),
              )
              ],
             )
            ),
            Positioned(
              top:280,
              child: Container(
                padding: const EdgeInsets.only(left:20,right: 20,top: 30,),
                width:MediaQuery.of(context).size.width,
                height:500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(text: "SNS Hackathon",color:Colors.black.withOpacity(0.8)),
                      AppLargeText(text: "\01st June",color:AppColors.starColor,size: 20,)
                    ],
                    )
                ,
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.location_on,color: Color.fromRGBO(73, 141, 56, 1),),
                    SizedBox(width: 15,),
                    AppText(text: "C2004,Faculty of Computing",color: Color.fromRGBO(73, 141, 56, 0.8),),
                    SizedBox(height: 20,),
                    SizedBox(height: 20,),
                    //AppLargeText(text: "Description",color:Colors.black.withOpacity(0.8),size:20,),

                  ],
                ),SizedBox(height: 10,),
                Row(
                  children:[
                  SizedBox(height: 8,),
                  
                  AppLargeText(text: "Description",color:Colors.black.withOpacity(0.8),size:20,),
                  SizedBox(height: 10,),
                  //AppText(text: "SNS Cyber Hackthon is one of the best Hackathons organized in Sri Lanka. This Hackathon was named after the 3 great Computer Geniuses Sahansa, Nethun & Sujeewa (SNS).",color: AppColors.mainTextColor,),
                ]),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                  
                  AppText(text: "This Hackathon was named after the 3 Great \nComputer Geniuses Sahansa, Nethun & \nSujeewa (SNS).",color: AppColors.mainTextColor,),
                  
                SizedBox(height: 10,),
                ]),
                
                  Row(children: [
                    
                  ],),
                SizedBox(height: 30,),
                  //2
                SizedBox(height: 10,),
                    AppLargeText(text: "Quick Naigation Panel",color:Colors.black.withOpacity(0.5),size:16,),    
                    SizedBox(height: 20,),
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
                          Container(
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
                           
                            SizedBox(height:5,),
                            Container(
                              child: AppText(
                                
                                text:images.values.elementAt(index),
                                color: AppColors.mainTextColor,
                              ),
                            )
                        ],
                      ),
                    );
                  },
               )
             ),

                ],

          
                
                ),
                
              )),
                Positioned(
                  bottom: 20,
                  left:20,
                  right:20,
                  child: Row(
                    children: [
                      ResponsiveButton(
                        isResponsive: true,

                      )
                    ],))

          ],
        )
     )
    );
  }
}
      


