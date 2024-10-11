import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/model/MovieDetailedModel.dart';
import 'package:netflix_app/model/movieRecomendationModel.dart';
import 'package:netflix_app/services/api_services.dart';

import '../common/utlis.dart';

class MovieDetailedScreen extends StatefulWidget {
  const MovieDetailedScreen({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailedScreen> createState() => _MovieDetailedScreenState();
}

class _MovieDetailedScreenState extends State<MovieDetailedScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailedModel> movieDetailedModel;
  late Future<MovieRecomendationModel> movieRecommendation;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  void fetchApi() {
    movieDetailedModel = apiServices.getMovieDetailed(widget.movieId);
    movieRecommendation = apiServices.getMovieRecommendations(widget.movieId);
  }

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'N/A';
    }
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<MovieDetailedModel>(
          future: movieDetailedModel,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data != null) {
              final movie = snapshot.data!;
              String genreText =
                  movie.genres.map((genre) => genre.name).join(', ');

              String formattedDate = formatDate(movie.lastAirDate);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: Container(
                            height: size.height * 0.5,
                            width: size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: movie.posterPath != null
                                    ? NetworkImage('$imgUrl${movie.posterPath}')
                                    : const AssetImage('assets/placeholder.png')
                                        as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.originalName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  genreText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.overview,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<MovieRecomendationModel>(
                      future: movieRecommendation,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // You can add this to indicate loading
                        } else if (snapshot.hasData) {
                          final movie = snapshot.data!;
                          return movie.results.isEmpty
                              ? const SizedBox()
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('More like this'),
                                      const SizedBox(height: 8),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: movie.results.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 15,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 12 / 9,
                                          crossAxisCount:
                                              3, // Number of columns
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final recommendation =
                                              movie.results[index];
                                          return CachedNetworkImage(
                                            imageUrl: recommendation
                                                    .posterPath.isNotEmpty
                                                ? '$imgUrl${recommendation.posterPath}'
                                                : 'https://img.pikbest.com/backgrounds/20200428/film-and-television-festival-retro-film-poster_2824252.jpg!sw800',
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        return const Text('No recommendations available');
                      },
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No Data Found'));
            }
          },
        ),
      ),
    );
  }
}
