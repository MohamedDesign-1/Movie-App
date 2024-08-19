import 'package:flutter/material.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "MovieDetailsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inception',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Image
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(
                'https://i.ebayimg.com/images/g/LTQAAOSw~gxfU1Rd/s-l1600.jpg',
                fit: BoxFit.cover,
              ),
            ),

            /// Space between the top image and content
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Poster on the left
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.16,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.network(
                      'https://i.ebayimg.com/images/g/LTQAAOSw~gxfU1Rd/s-l1600.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  // Movie Details on the right
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie Title
                        Text(
                          'Inception',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        // Rating and Genre
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.004),
                            Text('8.8', style: TextStyle(fontSize: 16)),
                            Spacer(),
                            Flexible(
                              child: Text('Action, Sci-Fi, Thriller',
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        // Release Date and Runtime
                        Text('Release Date: 2010-07-16'),
                        Text('Runtime: 2h 28m'),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        // Overview
                        Text(
                          'Overview',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          'A thief who steals corporate secrets through the use of dream-sharing technology is given '
                          'the inverse task of planting an idea into the mind of a C.E.O., but his tragic past may doom '
                          'the project and his team to disaster.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            // More Like This
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'More Like This',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BuildSimilarMovieCard(
                    title: 'Interstellar',
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
                  ),
                  BuildSimilarMovieCard(
                      title: 'The Dark Knight',
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg'),
                  BuildSimilarMovieCard(
                      title: 'The Matrix',
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg'),
                  BuildSimilarMovieCard(
                      title: 'Shutter Island',
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500/kve20tXwUZpu4GUX8l6X7Z4jmL6.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildSimilarMovieCard extends StatelessWidget {
  String title, imageUrl;

  BuildSimilarMovieCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Image.network(imageUrl, width: 100, height: 150, fit: BoxFit.cover),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
