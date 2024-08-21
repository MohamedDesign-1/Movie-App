import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movieapp/style/app_colors.dart';

import '../style/theme_app.dart';

class RecomendedCarousel extends StatelessWidget {
  String title;
  String image;
  String releaseDate;
  String voteAverage;

  int itemIndex;

  RecomendedCarousel(
      {super.key,
      required this.title,
      required this.image,
      required this.releaseDate,
      required this.voteAverage,
      /*required this.snapshot,*/ required this.itemIndex});

  //final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            MovieDetailsScreen.routeName,
            arguments: itemIndex,
          );

          /*
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(
                      movie: snapshot.data[itemIndex],
          ),
          ),
          );

           */
          /*
          ///go to details screen
          Navigator.of(context).pushNamed(MovieDetailsScreen.routeName);
          */
          /*
          Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(),
             //builder: (context) => MovieDetailsScreen(movie: selectedMovie)
            ),
          );

           */
/*
          Navigator.pushNamed(
            context,
            MovieDetailsScreen.routeName,
            //arguments: selectedMovie,
          );
*/
        },
        child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.darkGrayColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children:[
                ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500$image',
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border, color: AppColors.whiteColor,))
                ),
              ],
            ),
            const SizedBox(height: 8,),
            Text(title, style: AppTheme.mainTheme.textTheme.titleLarge!.copyWith(fontSize: 18), overflow: TextOverflow.ellipsis, maxLines: 2,),
            Row(
              children: [
                Text(releaseDate, style: AppTheme.mainTheme.textTheme.bodySmall,),
                const Spacer(),
                Text(voteAverage, style: AppTheme.mainTheme.textTheme.bodySmall,),
                Icon(Icons.star, color: AppColors.yellowColor,),

              ],
            )
          ],

        ),
      )
    );
  }
}