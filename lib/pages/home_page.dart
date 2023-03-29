import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ngram/misc/colors.dart';
import 'package:ngram/widgets/app_large_text.dart';
import 'package:ngram/widgets/app_text.dart';

import 'detail_page.dart';
import 'detail_page2.dart';
//lib

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
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
    "1_1.png",
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
                  
                  margin: const EdgeInsets.only(right:270),
                  width: 50,
                  height:30,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromRGBO(76, 175, 80, 1).withOpacity(0.5),
                  ),
                ),
                Icon(Icons.account_circle_rounded,size:40,color:Color.fromRGBO(76, 175, 80, 1).withOpacity(0.7)),
                
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
                  child: AppLargeText(text: "Welcome Sahansa,"),
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
                          Text("QR eka NEthun Methanata link karamu"),
                         
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