//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieapp/screens/browse_screen/browse_screen.dart';
import 'package:movieapp/screens/home_screen/home_screen.dart';
import 'package:movieapp/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movieapp/style/theme_app.dart';
import 'package:movieapp/widgets/bottom_nav_bar.dart';

import 'models/movie.dart'; // تأكد من استيراد الـ BottomNavBar

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('watch_list_movies');

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
