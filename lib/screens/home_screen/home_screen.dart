import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/api/api_manager.dart';
import 'package:movieapp/style/theme_app.dart';
import 'package:movieapp/widgets/new_releases_carousel.dart';
import 'package:movieapp/widgets/popular_carousel_widget.dart';
import 'package:movieapp/widgets/recomended_carousel.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  //Late int itemIndex

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ///popular movies
              FutureBuilder(
                future: ApiManger.getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error'));
                  }
                  return CarouselSlider.builder(
                    itemCount: snapshot.data?.results!.length,
                    itemBuilder: (context, index, realIndex) =>
                        PopularCarouselWidget(
                      title: snapshot.data!.results![index].title!,
                      image: snapshot.data!.results![index].posterPath!,
                      releaseDate: snapshot.data!.results![index].releaseDate!,
                      itemIndex: snapshot.data!.results![index].id as int,
                    ),
                    options: CarouselOptions(
                      scrollPhysics: BouncingScrollPhysics(),
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      // Control speed of the carousel
                      autoPlayCurve: Curves.easeInOutCubicEmphasized,
                      viewportFraction: 1,
                      aspectRatio: 16 / 9,
                    ),
                  );
                },
              ),

              ///sized box
              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///New Releases text
                    Text(
                      'New Releases',
                      style: AppTheme.mainTheme.textTheme.titleSmall!
                          .copyWith(fontSize: 20),
                    ),

                    ///sized box
                    const SizedBox(height: 16),

                    ///New Releases
                    FutureBuilder(
                      future: ApiManger.getUpcomingMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error'));
                        }
                        return CarouselSlider.builder(
                          itemCount: snapshot.data?.results!.length,
                          itemBuilder: (context, index, realIndex) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: NewReleasesCarousel(
                              title: snapshot.data!.results![index].title!,
                              image: snapshot.data!.results![index].posterPath!,
                              releaseDate: snapshot.data!.results![index].releaseDate!,
                              itemIndex: snapshot.data!.results![index].id as int,
                            ),
                          ),
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.4,
                            viewportFraction: 0.5,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      },
                    ),

                    ///sized box
                    const SizedBox(height: 24),

                    ///Recommended text
                    Text(
                      'Recommended',
                      style: AppTheme.mainTheme.textTheme.titleSmall!
                          .copyWith(fontSize: 20),
                    ),

                    ///sized box
                    const SizedBox(height: 16),

                    ///Recommended
                    FutureBuilder(
                      future: ApiManger.getTopRatedMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error'));
                        }
                        return CarouselSlider.builder(
                          itemCount: snapshot.data?.results!.length,
                          itemBuilder: (context, index, realIndex) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RecomendedCarousel(
                              title: snapshot.data!.results![index].title!,
                              image: snapshot.data!.results![index].posterPath!,
                              releaseDate:
                                  snapshot.data!.results![index].releaseDate!,
                              voteAverage: snapshot.data!.results![index].voteAverage.toString(),
                              //snapshot: snapshot,
                              itemIndex: snapshot.data!.results![index].id as int,
                            ),
                          ),
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.4,
                            viewportFraction: 0.5,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
