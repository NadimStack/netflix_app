import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/screen/movie_detailed_screen.dart';

import '../model/movieModel.dart';

class MovieListWidget extends StatelessWidget {
  final Future<MovieModel> future;
  final String headlineText;

  const MovieListWidget({
    Key? key,
    required this.future,
    required this.headlineText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel>(
      future: future,
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // No data state
        if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return const Center(child: Text('No movies found.'));
        }

        // Success state
        var data = snapshot.data!.results;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headlineText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailedScreen(
                              movieId: data[index].id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '$imgUrl${data[index].posterPath}',
                            fit: BoxFit.fitHeight,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/default_image.png',
                                // Local default image
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
