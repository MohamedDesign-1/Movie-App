import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/style/app_colors.dart';

class WatchListScreen extends StatelessWidget {
  static const String routeName = "WatchListScreen";

  @override
  Widget build(BuildContext context) {
    final watchListBox = Hive.box<Movie>('watch_list_movies');
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch List'),
      ),
      body: ValueListenableBuilder(
        valueListenable: watchListBox.listenable(),
        builder: (context, Box<Movie> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('Your Watch List is empty!'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final movie = box.getAt(index);
              return ListTile(
                title: Text(movie?.title ?? ''),
                subtitle: Text(
                  movie?.overview ?? '',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
                leading: SizedBox(
                  width: 50,
                  height: 75,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    movie?.delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
