import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/theme_app.dart';

class NewReleasesCarousel extends StatelessWidget {
  String image;
  String title;
  String releaseDate;

  NewReleasesCarousel({
    required this.image,
    required this.title,
    required this.releaseDate,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              children: [
                ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${image}',
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(color: AppColors.whiteColor,)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [ Colors.transparent, Colors.black.withOpacity(0.9),],
                    ),
                  ),
                ),
                Positioned(
                    top: 1,
                    right: 1,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border, color: AppColors.whiteColor,))
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            Text(title, style: AppTheme.mainTheme.textTheme.titleLarge!.copyWith(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.001,),
            Text(releaseDate, style: AppTheme.mainTheme.textTheme.bodySmall,),
          ],
        ),
      ),
    );
  }
}
