import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieapp/api/api_manager.dart';
import 'package:movieapp/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movieapp/style/app_colors.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "SearchScreen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final df = new DateFormat('y');
  final TextEditingController _controller = TextEditingController();
  final ApiManger _apiService = ApiManger();
  List<dynamic> _movies = [];
  bool _isLoading = false;

  void _searchMovies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _apiService.searchMovies(_controller.text);
      setState(() {
        _movies = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle the error, e.g., show a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.height * 0.03,
          MediaQuery.of(context).size.height * 0.05,
          MediaQuery.of(context).size.height * 0.03,
          MediaQuery.of(context).size.height * 0.00001,
        ),
        child: TextField(
          controller: _controller,
          onSubmitted: (value) {
            _searchMovies();
          },
          onChanged: (value) {
            _searchMovies();
            setState(() {});
          },
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              filled: true,
              fillColor: AppColors.darkGrayColor,
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.titleMedium,
              suffixIcon: IconButton(
                  onPressed: () {
                    _controller.clear();
                    setState(() {});
                  },
                  icon: Icon(Icons.close)),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 15,
                  ))),
        ),
      ),
      SizedBox(height: 16.0),
      _isLoading
          ? CircularProgressIndicator()
          : _movies.isEmpty
              ? Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.255),
                  child:
                      Center(child: Image.asset('assets/images/not_found.png')),
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: _movies.length,
                  padding: EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    final movie = _movies[index];

                    return Container(
                      width: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.mediumGrayColor))),
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            MovieDetailsScreen.routeName,
                            arguments: movie['id'] as int,
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.133,
                              width: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    movie['title'],
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    df.format(
                                        DateTime.parse(movie['release_date'])),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: AppColors.mediumGrayColor),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.004),
                                      Text(
                                          maxLines: 1,
                                          movie['vote_average'].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                color:
                                                    AppColors.mediumGrayColor,
                                              )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
    ]));
  }
}
