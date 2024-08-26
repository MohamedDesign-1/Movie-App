import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/style/theme_app.dart';

import '../../api/api_manager.dart';
import '../../style/app_colors.dart';

class BrowseScreen extends StatelessWidget {
  static const String routeName = "BrowseScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Browse Category",
          style: AppTheme.mainTheme.textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiManger.getMovieCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading categories.'),
                  );
                }

                final genres = snapshot.data;

                if (genres == null || genres.isEmpty) {
                  return const Center(
                    child: Text('No categories found.'),
                  );
                }
                return GridView.builder(
                  itemCount: genres.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 16 / 9,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
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
                              imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYxnnMqQyMqz_sWOc-HIaB8QJu9ZeGd0ijnA&s',
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
                              genres[index].name ?? '',
                              style: AppTheme.mainTheme.textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
