import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieapp/models/movies_details_model.dart';
import 'package:movieapp/models/movies_model.dart';

import 'api_constatnts.dart';

class ApiManger {
  static Future<MovieModel?> getPopularMovies() async {
    Uri url = Uri.https(ApiConstatnts.baseUrl, ApiConstatnts.popularMoviesUrl,
        {'api_key': ApiConstatnts.apiKey});
    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieModel?> getUpcomingMovies() async {
    Uri url = Uri.https(ApiConstatnts.baseUrl, ApiConstatnts.upcomingMoviesUrl,
        {'api_key': ApiConstatnts.apiKey});
    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieModel?> getTopRatedMovies() async {
    Uri url = Uri.https(ApiConstatnts.baseUrl, ApiConstatnts.topRatedMoviesUrl,
        {'api_key': ApiConstatnts.apiKey});
    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

/*=======================================================================================*/
  static Future<MoviesDetailsModel?> getMovieDetails(int id) async {
    // Replace the movie_id part in the path, not in the query parameters
    Uri url = Uri.https(ApiConstatnts.baseUrl, '3/movie/$id', {
      'api_key': ApiConstatnts.apiKey,
    });

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return MoviesDetailsModel.fromJson(jsonDecode(response.body));
      } else {
        // Handle invalid status codes
        print("Failed to load movie details: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  /*-------------------------------------------------------------------*/
  /*
  https://api.themoviedb.org/3/movie/{movie_id}/similar
   */
  static Future<List<MoviesDetailsModel>> getSimilarMovies(int id) async {
    Uri url = Uri.https(ApiConstatnts.baseUrl, '3/movie/$id/similar', {
      'api_key': ApiConstatnts.apiKey,
    });

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];
        return results
            .map((movie) => MoviesDetailsModel.fromJson(movie))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

//---------------------------------------------
  final String apiKey =
      'f7474590cf96104300cb755512a6f060'; // Replace with your TMDb API key
  final String baseUrl = 'https://api.themoviedb.org/3';

//-------------------------------------------------------------
  Future<List<dynamic>> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static const String _apiKey = ApiConstatnts.apiKey;
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<dynamic>> fetchCategories() async {
    final url = '$_baseUrl/genre/movie/list?api_key=$_apiKey&language=en-US';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['genres'];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<dynamic>> fetchMoviesByGenre(int genreId) async {
    final url =
        '$_baseUrl/discover/movie?api_key=$_apiKey&with_genres=$genreId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<String> fetchCategoryImage(int genreId) async {
    final url =
        '$_baseUrl/discover/movie?api_key=$_apiKey&with_genres=$genreId&sort_by=popularity.desc';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        return '$_imageBaseUrl${data['results'][0]['poster_path']}';
      }
    }
    return '';
  }
}
