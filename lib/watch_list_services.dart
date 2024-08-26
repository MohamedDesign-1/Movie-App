import 'package:hive/hive.dart';
import 'package:movieapp/models/movie.dart';

class WatchListService {
  final Box<Movie> _watchListBox = Hive.box<Movie>('watch_list_movies');

  void addToWatchList(Movie movie) {
    _watchListBox.put(movie.id, movie);
  }

  void removeFromWatchList(int movieId) {
    _watchListBox.delete(movieId);
  }

  bool isInWatchList(int movieId) {
    return _watchListBox.containsKey(movieId);
  }

  List<Movie> getWatchList() {
    return _watchListBox.values.toList();
  }
}
