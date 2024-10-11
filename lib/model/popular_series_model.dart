import 'dart:convert';

class PopularSeriesMovie {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  PopularSeriesMovie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  PopularSeriesMovie copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      PopularSeriesMovie(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory PopularSeriesMovie.fromRawJson(String str) =>
      PopularSeriesMovie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PopularSeriesMovie.fromJson(Map<String, dynamic> json) =>
      PopularSeriesMovie(
        page: json["page"] ?? 0,
        results: json["results"] != null
            ? List<Result>.from(
            json["results"].map((x) => Result.fromJson(x)))
            : null,
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results != null
        ? List<dynamic>.from(results!.map((x) => x.toJson()))
        : null,
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
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
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] != null
        ? List<int>.from(json["genre_ids"].map((x) => x))
        : null,
    id: json["id"] ?? 0,
    originalLanguage: json["original_language"] != null
        ? originalLanguageValues.map[json["original_language"]]
        : null,
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"] != null
        ? json["popularity"].toDouble()
        : null,
    posterPath: json["poster_path"],
    releaseDate: json["release_date"] != null
        ? DateTime.parse(json["release_date"])
        : null,
    title: json["title"],
    video: json["video"] ?? false,
    voteAverage: json["vote_average"] != null
        ? json["vote_average"].toDouble()
        : null,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids":
    genreIds != null ? List<dynamic>.from(genreIds!.map((x) => x)) : null,
    "id": id,
    "original_language": originalLanguage != null
        ? originalLanguageValues.reverse[originalLanguage]
        : null,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate != null
        ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}"
        : null,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

enum OriginalLanguage { EN, KO, TH, TL }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ko": OriginalLanguage.KO,
  "th": OriginalLanguage.TH,
  "tl": OriginalLanguage.TL,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
