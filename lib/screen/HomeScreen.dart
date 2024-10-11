import 'package:flutter/material.dart';
import 'package:netflix_app/model/Top_Rated_Series_Model.dart';
import 'package:netflix_app/screen/SearchBar.dart';
import 'package:netflix_app/services/api_services.dart';
import '../model/movieModel.dart';
import '../widget/MovieListWidget.dart';
import '../widget/customCarousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiServices apiServices;
  late Future<MovieModel> upcomingMovieModel;
  late Future<MovieModel> popularMovieModel;
  late Future<TopRatedSeries> getTopRatedSeries;

  @override
  void initState() {
    super.initState();
    apiServices = ApiServices();
    upcomingMovieModel = apiServices.getUpcomingMovie();
    popularMovieModel = apiServices.getPopularMovie();
    getTopRatedSeries = apiServices.getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/logo.png',
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const SearchScreen()));
              },
              child: const Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue,
              height: 25,
              width: 25,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            child: Column(
              children: [
                FutureBuilder(
                  future: getTopRatedSeries,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CustomCarouselSlider(
                        data: snapshot.data!,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Show a loading spinner while waiting for the data
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 220,
                  child: MovieListWidget(
                    future: popularMovieModel,
                    headlineText: 'Now Playing',
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: MovieListWidget(
                    future: upcomingMovieModel,
                    headlineText: 'Upcoming Movies',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
