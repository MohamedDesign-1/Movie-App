import 'package:flutter/material.dart';
import 'package:movieapp/screens/browse_screen/browse_screen.dart';
import 'package:movieapp/screens/home_screen/home_screen.dart';
import 'package:movieapp/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movieapp/style/theme_app.dart';
import 'package:movieapp/widgets/bottom_nav_bar.dart'; // تأكد من استيراد الـ BottomNavBar

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName : (context) => MainPage(),
        HomeScreen.routeName : (context) => HomeScreen(),
        BrowseScreen.routeName : (context) => BrowseScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
      },
      theme: AppTheme.mainTheme,
    );
  }
}
