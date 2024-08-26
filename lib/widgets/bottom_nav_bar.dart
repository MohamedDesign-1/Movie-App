import 'package:flutter/material.dart';
import 'package:movieapp/screens/browse_screen/catigories_screen.dart';
import 'package:movieapp/screens/home_screen/home_screen.dart';
import 'package:movieapp/screens/search_screen/search_screen/search_screen.dart';
import 'package:movieapp/screens/watchlist_screen/watch_list_screen.dart';

class MainPage extends StatefulWidget {
  static const String routeName = "BottomNavBar";
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> pages = [
  HomeScreen(),
  SearchScreen(),
    CategoriesScreen(),
    WatchListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_album),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Watchlist',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      )
    );
  }
}
