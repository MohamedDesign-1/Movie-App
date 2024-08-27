import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/api/api_manager.dart';
import 'package:movieapp/models/movies.dart';
import 'package:movieapp/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movieapp/style/app_colors.dart';
import 'package:movieapp/style/theme_app.dart';

class MovieListScreen extends StatefulWidget {
  final int genreId;
  final String genreName;

  const MovieListScreen({required this.genreId, required this.genreName});

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = _fetchMoviesByGenre(widget.genreId);
  }

  Future<List<Movie>> _fetchMoviesByGenre(int genreId) async {
    ApiManger apiService = ApiManger();
    final List<dynamic> moviesJson =
        await apiService.fetchMoviesByGenre(genreId);
    return moviesJson.map((json) => Movie.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: AppColors.lightGrayColor,
        ),
        title: Text(
          '${widget.genreName} Movies',
          style: AppTheme.mainTheme.textTheme.titleLarge,
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      MovieDetailsScreen.routeName,
                      arguments: movie.id,
                    );
                  },
                  child: Card(
                    color: AppColors.grayColor,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: movie.posterUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.yellowColor,
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            movie.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.lightGrayColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
