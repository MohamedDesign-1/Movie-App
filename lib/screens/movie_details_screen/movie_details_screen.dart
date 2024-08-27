import 'package:flutter/material.dart';
import 'package:movieapp/api/api_manager.dart';
import 'package:movieapp/models/movies_details_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "MovieDetailsScreen";

  Future<MoviesDetailsModel> fetchMovieDetails(int movieId) async {
    try {
      final details = await ApiManger.getMovieDetails(movieId);
      if (details != null) {
        return details;
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error loading movie details');
    }
  }

  Future<List<MoviesDetailsModel>> fetchSimilarMovies(int movieId) async {
    try {
      final similarMovies = await ApiManger.getSimilarMovies(movieId);
      if (similarMovies != null) {
        return similarMovies;
      } else {
        throw Exception('Failed to load similar movies');
      }
    } catch (e) {
      throw Exception('Error loading similar movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<MoviesDetailsModel>(
        future: fetchMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No movie details available'));
          }

          final movieDetails = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Image

                Column(
                  children: [
                    Container(
                  width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}',
                    fit: BoxFit.cover,
                  ),
                ),

                /// Space between the top image and content
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Poster on the left
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.16,
                        height: MediaQuery.of(context).size.height * 0.3,
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      // Movie Details on the right
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Movie Title
                            Text(
                              '${movieDetails.title}',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            // Rating and Genre
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.004),
                                Text(
                                  movieDetails.voteAverage!.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Flexible(
                                  child: Text(
                                    movieDetails.genres!
                                        .map((genre) => genre.name)
                                            .join(' ,\n '),
                                        style: TextStyle(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                        0.03),
                                // Release Date and Runtime
                            Text('Release Date: ${movieDetails.releaseDate}'),
                            Text('Runtime: ${movieDetails.runtime} min'),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            // Overview
                            Text(
                              'Overview',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                                Text(maxLines: 5, '${movieDetails.overview}'),
                              ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // More Like This
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'More Like This',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    /// Similar Movies
                FutureBuilder<List<MoviesDetailsModel>>(
                  future: fetchSimilarMovies(movieId),
                  builder: (context, similarMoviesSnapshot) {
                    if (similarMoviesSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (similarMoviesSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${similarMoviesSnapshot.error}'));
                    } else if (!similarMoviesSnapshot.hasData) {
                      return Center(child: Text('No similar movies available'));
                    }

                    final similarMovies = similarMoviesSnapshot.data!;

                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: similarMovies.length,
                        itemBuilder: (context, index) {
                          final similarMovie = similarMovies[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          MovieDetailsScreen.routeName,
                                          arguments: similarMovie.id,
                                        );
                                      },
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w500${similarMovie.posterPath}',
                                        width: 100,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                Text(
                                  '${similarMovie.title}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
                ),
              ]));
        },
      ),
    );
  }
}
