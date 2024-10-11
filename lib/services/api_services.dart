import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/model/MovieDetailedModel.dart';
import 'package:netflix_app/model/Top_Rated_Series_Model.dart';
import 'package:netflix_app/model/popular_series_model.dart';
import '../model/movieModel.dart';
import '../model/movieRecomendationModel.dart';
import '../model/search_Movie_Model.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
late String endPoint;
var key = '?api_key=$apiKey';

class ApiServices {
  Future<MovieModel> getUpcomingMovie() async {
    const endPoint = 'movie/upcoming';
    late String url = '$baseUrl$endPoint$key';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Upcoming Movies Fetch Success: ${response.statusCode}');
        return MovieModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load upcoming movies, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching upcoming movies: $e');
    }
  }

  Future<MovieModel> getPopularMovie() async {
    const endPoint = 'movie/popular';
    late String url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Popular Movies Fetch Success: ${response.statusCode}');
        return MovieModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load popular movies, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  Future<PopularSeriesMovie> getPopularSeries() async {
    const endPoint = 'movie/popular';
    late String url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Popular Series Fetch Success: ${response.statusCode}');
        return PopularSeriesMovie.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load Popular Series, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Popular Series: $e');
    }
  }

  Future<TopRatedSeries> getTopRatedSeries() async {
    const endPoint = 'tv/top_rated';
    late String url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Popular Movies Fetch Success: ${response.statusCode}');
        return TopRatedSeries.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load Top Rated Series movies, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Top Rated Series movies: $e');
    }
  }

  Future<SearchMovieModel> getSearchMovie(String search) async {
    endPoint = 'search/tv?query=$search';
    late String url = '$baseUrl$endPoint';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc',
      });

      if (response.statusCode == 200) {
        print('Search Movies Fetch Success: ${response.statusCode}');
        return SearchMovieModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load Searching movies, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Searching movies: $e');
    }
  }

  Future<MovieDetailedModel> getMovieDetailed(int movieId) async {
    endPoint = 'movie/$movieId';
    late String url = '$baseUrl$endPoint$key';
    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        print('Search Movies Fetch Success: ${response.statusCode}');
        return MovieDetailedModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load Searching movies, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Searching movies: $e');
    }
  }

  Future<MovieRecomendationModel> getMovieRecommendations(int movieId) async {
    endPoint = 'movie/$movieId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieRecomendationModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  movie details');
  }
}
