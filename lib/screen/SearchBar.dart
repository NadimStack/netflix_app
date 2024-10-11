import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/screen/movie_detailed_screen.dart';
import 'package:netflix_app/services/api_services.dart';

import '../model/popular_series_model.dart';
import '../model/search_Movie_Model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  late Future<PopularSeriesMovie> popularSeriesMovie;
  SearchMovieModel? searchMovieModel;

  @override
  void initState() {
    super.initState();
    popularSeriesMovie = apiServices.getPopularSeries();
  }

  void search(String query) {
    apiServices.getSearchMovie(query).then((results) {
      setState(() {
        searchMovieModel = results;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                CupertinoSearchTextField(
                  controller: searchController,
                  padding: const EdgeInsets.all(10.0),
                  prefixIcon:
                      const Icon(CupertinoIcons.search, color: Colors.grey),
                  suffixIcon: const Icon(CupertinoIcons.clear_circled,
                      color: Colors.grey),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      search(value);
                    }
                  },
                ),
                const SizedBox(height: 24),
                searchController.text.isEmpty
                    ? FutureBuilder<PopularSeriesMovie>(
                        future: popularSeriesMovie,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data?.results != null) {
                            var data = snapshot.data!.results;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final movie = data?[index];
                                    if (movie == null) {
                                      return const SizedBox
                                          .shrink(); // Skip null entries
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (movie.id != null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (builder) =>
                                                        MovieDetailedScreen(
                                                            movieId: movie.id!),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              height: 140,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  imageUrl: movie.posterPath !=
                                                          null
                                                      ? '$imgUrl${movie.posterPath}'
                                                      : 'fallback_image_url',
                                                  fit: BoxFit.fitHeight,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    print(
                                                        'Failed to load image for movie ID: ${movie.id}');
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Flexible(
                                            child: Text(
                                              movie.title ??
                                                  'No title available',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      )
                    : searchMovieModel == null
                        ? const SizedBox.shrink()
                        : GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: searchMovieModel?.results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.2 / 2,
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                MovieDetailedScreen(
                                                    movieId: searchMovieModel!
                                                        .results[index].id),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: 120,
                                          imageUrl:
                                              '$imgUrl${searchMovieModel?.results[index].backdropPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      maxLines: 2,
                                      '${searchMovieModel?.results[index].originalName}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
