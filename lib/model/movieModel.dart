import 'dart:convert';
import 'package:http/http.dart' as http;

// MovieModel class representing the structure of the movie data
class MovieModel {
  Dates? dates; // Optional, as it's only available in UpcomingMovie
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  MovieModel({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  MovieModel copyWith({
    Dates? dates,
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      MovieModel(
        dates: dates ?? this.dates,
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory MovieModel.fromRawJson(String str) =>
      MovieModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

// Dates class representing the available dates
class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  Dates copyWith({
    DateTime? maximum,
    DateTime? minimum,
  }) =>
      Dates(
        maximum: maximum ?? this.maximum,
        minimum: minimum ?? this.minimum,
      );

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum": maximum.toIso8601String(),
    "minimum": minimum.toIso8601String(),
  };
}

// Result class representing individual movie results
class Result {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage? originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Result copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    OriginalLanguage? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      Result(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    originalLanguage: json["original_language"] != null
        ? originalLanguageValues.map[json["original_language"]]
        : null,
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] != null
        ? DateTime.parse(json["release_date"])
        : null,
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage != null
        ? originalLanguageValues.reverse[originalLanguage]
        : null,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity.toInt(),
    "poster_path": posterPath,
    "release_date": releaseDate != null
        ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
        : null,
    "title": title,
    "video": video,
    "vote_average": voteAverage.toInt(),
    "vote_count": voteCount,
  };
}

// Enum for original languages
enum OriginalLanguage { EN, ES, KO, CN, ZH }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ko": OriginalLanguage.KO,
  "cn": OriginalLanguage.CN,
  "zh": OriginalLanguage.ZH,
});

// Helper class for enum mapping
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// Function to fetch movies from the API
Future<MovieModel> fetchMovies() async {
  const String apiKey = 'YOUR_API_KEY'; // Replace with your API key
  const String apiUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US&page=1'; // Replace with your endpoint

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    return MovieModel.fromRawJson(response.body);
  } else {
    print('Failed to load movies: ${response.statusCode}');
    throw Exception('Failed to load movies');
  }
}

// Example usage of fetchMovies function
void main() async {
  try {
    MovieModel movieModel = await fetchMovies();
    print('Fetched ${movieModel.results.length} movies.');
  } catch (e) {
    print(e);
  }
}
