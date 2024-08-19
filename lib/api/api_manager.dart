import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/movies_model.dart';
import 'api_constatnts.dart';

class ApiManger {

static Future<MovieModel?> getPopularMovies() async {
    Uri url = Uri.https(ApiConstatnts.baseUrl, ApiConstatnts.popularMoviesUrl, {'api_key': ApiConstatnts.apiKey});
    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

static Future<MovieModel?> getUpcomingMovies() async {
    Uri url = Uri.https(ApiConstatnts.baseUrl, ApiConstatnts.upcomingMoviesUrl, {'api_key': ApiConstatnts.apiKey});
    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

static Future<MovieModel?> getTopRatedMovies() async {
    Uri url = Uri.https(ApiConstatnts.baseUrl, ApiConstatnts.topRatedMoviesUrl, {'api_key': ApiConstatnts.apiKey});
    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}