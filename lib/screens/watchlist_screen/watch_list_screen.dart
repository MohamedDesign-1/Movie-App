import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/style/app_colors.dart';
import 'package:movieapp/style/theme_app.dart';

class WatchListScreen extends StatelessWidget {
  static const String routeName = "WatchListScreen";
  final df = new DateFormat('y');
  @override
  Widget build(BuildContext context) {
    final watchListBox = Hive.box<Movie>('watch_list_movies');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch List',
          style: AppTheme.mainTheme.textTheme.titleLarge!
              .copyWith(color: AppColors.lightGrayColor),
        ),
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
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.144,
                      width: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ClipRRect(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            maxLines: 1,
                            movie?.title ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.mediumGrayColor),
                          ),
                          Text(
                            maxLines: 3,
                            movie?.overview ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              movie?.delete();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              //   ListTile(
              //   title: Text(movie?.title ?? '',
              //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
              //     color: AppColors.grayColor
              //   ),
              //   ),
              //   subtitle: Text(
              //     movie?.overview ?? '',
              //     style: TextStyle(color: AppColors.whiteColor),
              //   ),
              //   leading: SizedBox(
              //     width: 50,
              //     height: 75,
              //     child: Image.network(
              //       'https://image.tmdb.org/t/p/w500${movie?.posterPath}',
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   trailing: IconButton(
              //     icon: Icon(Icons.delete),
              //     onPressed: () {
              //       movie?.delete();
              //     },
              //   ),
              // );

              );
        },
      ),
    );
  }
}
