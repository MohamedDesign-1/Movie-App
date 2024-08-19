import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/api/api_manager.dart';
import 'package:movieapp/style/theme_app.dart';
import 'package:movieapp/widgets/recomended_carousel.dart';
import 'package:movieapp/widgets/new_releases_carousel.dart';
import 'package:movieapp/widgets/popular_carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

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
                          itemBuilder: (context, index, realIndex) => PopularCarouselWidget(
                          title: snapshot.data!.results![index].title!,
                          image: snapshot.data!.results![index].posterPath!,
                          releaseDate: snapshot.data!.results![index].releaseDate!,
                          ),
                          options: CarouselOptions(
                            scrollPhysics: BouncingScrollPhysics(),
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayInterval: const Duration(seconds: 5), // todo: Control in speed of carousel
                            autoPlayCurve: Curves.easeInOutCubicEmphasized,
                            viewportFraction: 1,
                            aspectRatio: 16 / 9,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4,),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('New Releases' , style: AppTheme.mainTheme.textTheme.titleSmall!.copyWith( fontSize: 20),),
                            const SizedBox(height: 16,),
                            FutureBuilder(
                              future: ApiManger.getUpcomingMovies(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
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
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      viewportFraction: 0.5,
                                      scrollDirection: Axis.horizontal,
                                    )
                                );
                              }
                            ),
                            const SizedBox(height: 24,),
                            Text('Recommended' , style: AppTheme.mainTheme.textTheme.titleSmall!.copyWith( fontSize: 20),),
                            const SizedBox(height: 16,),
                            FutureBuilder(
                              future: ApiManger.getTopRatedMovies(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
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
                                        releaseDate: snapshot.data!.results![index].releaseDate!,
                                        voteAverage: snapshot.data!.results![index].voteAverage.toString(),
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      height: MediaQuery.of(context).size.height * 0.4,
                                      viewportFraction: 0.5,
                                      scrollDirection: Axis.horizontal,
                                    )
                                );
                              }
