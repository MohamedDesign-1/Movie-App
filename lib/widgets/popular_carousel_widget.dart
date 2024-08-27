import 'package:flutter/material.dart';
import 'package:movieapp/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movieapp/style/app_colors.dart';
import 'package:movieapp/style/theme_app.dart';

class PopularCarouselWidget extends StatelessWidget {
  String image;
  String title;
  String releaseDate;

  int itemIndex;

  PopularCarouselWidget(
      {required this.title,
      required this.image,
      required this.releaseDate,
      required this.itemIndex});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          MovieDetailsScreen.routeName,
          arguments: itemIndex,
        );

      },
      child: Stack(
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${image}',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            color: AppColors.blackColor.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: AppTheme.mainTheme.textTheme.titleLarge,
                ),
                Text(
                  releaseDate,
                  style: AppTheme.mainTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
