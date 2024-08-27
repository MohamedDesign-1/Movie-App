import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/screens/movie_details_screen/movie_details_screen.dart';

import '../style/app_colors.dart';
import '../style/theme_app.dart';

class NewReleasesCarousel extends StatefulWidget {
  final String image;
  final String title;
  final String releaseDate;
  final int itemIndex;

  NewReleasesCarousel({
    Key? key,
    required this.image,
    required this.title,
    required this.releaseDate,
    required this.itemIndex,
  }) : super(key: key);

  @override
  _NewReleasesCarouselState createState() => _NewReleasesCarouselState();
}

class _NewReleasesCarouselState extends State<NewReleasesCarousel> {
  late Box<Movie> watchListBox;
  bool isInWatchList = false;

  @override
  void initState() {
    super.initState();
    watchListBox = Hive.box<Movie>('watch_list_movies');
    isInWatchList = watchListBox.containsKey(widget.itemIndex);
  }

  void toggleWatchList(Movie movie) {
    setState(() {
      if (isInWatchList) {
        watchListBox.delete(movie.id);
      } else {
        watchListBox.put(movie.id, movie);
      }
      isInWatchList = !isInWatchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          MovieDetailsScreen.routeName,
          arguments: widget.itemIndex,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.darkGrayColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${widget.image}',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                    onPressed: () {
                      Movie movie = Movie(
                        id: widget.itemIndex,
                        title: widget.title,
                        posterPath: widget.image,
                        overview:
                            'Movie Name : ${widget.title} \n Release Date ${widget.releaseDate}',
                      );
                      toggleWatchList(movie);
                    },
                    icon: Icon(
                      isInWatchList ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              widget.title,
              style: AppTheme.mainTheme.textTheme.titleMedium!
                  .copyWith(color: AppColors.lightGrayColor, fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.001),
            Text(widget.releaseDate,
                style: AppTheme.mainTheme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

