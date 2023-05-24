import 'package:flutter/material.dart';
import 'package:flutter_firebase_test/pages/nav_pages/search_page.dart';
import 'package:flutter_firebase_test/pages/home_page.dart';
//import 'package:ngram/pages/nav_pages/my_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages= [
    const HomePage(),
    
    const SearchPage(),

  ];
  int currentIndex=0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }

  //footer navigational panel eka methana
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //if we ever wanted to change the entire BG color guys
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar:BottomNavigationBar(
        // .fixed nathuwa .shifting dammoth shift wenawa 
        //but colors maru karanna onenam fixed dnna wenw, so shifting animation eka nathuwa yanawa
        //type:BottomNavigationBarType.fixed,
        //backgroundColor: Colors.white,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,

        items: const [
      
          BottomNavigationBarItem(label:"Home",icon: Icon(Icons.apps)),
          //BottomNavigationBarItem(label:"Bar",icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(label:"Search",icon: Icon(Icons.search)),
          //BottomNavigationBarItem(label:"My",icon: Icon(Icons.person)),
          
        ],
      ),
    );
  }
}