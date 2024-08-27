import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/api/api_manager.dart';
import 'package:movieapp/models/genres.dart';
import 'package:movieapp/screens/browse_screen/movies_list.dart';
import 'package:movieapp/style/app_colors.dart';
import 'package:movieapp/style/theme_app.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = "Categories_screen";

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Genre>> genres;

  @override
  void initState() {
    super.initState();
    genres = _fetchGenres();
  }

  Future<List<Genre>> _fetchGenres() async {
    ApiManger apiService = ApiManger();
    final List<dynamic> genresJson = await apiService.fetchCategories();
    List<Genre> genres = [];

    for (var genreJson in genresJson) {
      String imageUrl = await apiService.fetchCategoryImage(genreJson['id']);
      genres.add(Genre.fromJson(genreJson, imageUrl));
    }

    return genres;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Browse Category",
          style: AppTheme.mainTheme.textTheme.titleLarge,
        ),
      ),
      body: FutureBuilder<List<Genre>>(
        future: genres,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories found.'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final genre = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieListScreen(
                          genreId: genre.id,
                          genreName: genre.name,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.darkGrayColor,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: genre.imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.yellowColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => Center(
                                child: Icon(
                              Icons.error,
                              color: AppColors.yellowColor,
                              size: 56,
                            )),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.infinity,
                          color: AppColors.blackColor.withOpacity(0.3),
                        ),
                        Center(
                          child: Text(
                            genre.name!,
                            style: AppTheme.mainTheme.textTheme.titleLarge,
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
