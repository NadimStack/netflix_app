import 'dart:convert';

class MovieDetailedModel {
  MovieDetailedModel({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    this.nextEpisodeToAir, // Nullable to handle missing data
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath, // Nullable
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String backdropPath;
  List<dynamic> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  List<Genre> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  LastEpisodeToAir lastEpisodeToAir;
  LastEpisodeToAir? nextEpisodeToAir; // Nullable to handle missing data
  List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String? posterPath; // Nullable as it might be null
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  List<Season> seasons;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  factory MovieDetailedModel.fromJson(Map<String, dynamic> json) => MovieDetailedModel(
    adult: json["adult"] ?? false, // Default value
    backdropPath: json["backdrop_path"] ?? "", // Default to empty string
    createdBy: List<dynamic>.from(json["created_by"]?.map((x) => x) ?? []),
    episodeRunTime: List<int>.from(json["episode_run_time"]?.map((x) => x) ?? []),
    firstAirDate: DateTime.tryParse(json["first_air_date"] ?? '') ?? DateTime.now(), // Default to current time
    genres: List<Genre>.from(json["genres"]?.map((x) => Genre.fromJson(x)) ?? []),
    homepage: json["homepage"] ?? "", // Default to empty string
    id: json["id"] ?? 0, // Default to 0
    inProduction: json["in_production"] ?? false, // Default value
    languages: List<String>.from(json["languages"]?.map((x) => x) ?? []),
    lastAirDate: DateTime.tryParse(json["last_air_date"] ?? '') ?? DateTime.now(), // Default to current time
    lastEpisodeToAir: LastEpisodeToAir.fromJson(json["last_episode_to_air"] ?? {}),
    nextEpisodeToAir: json["next_episode_to_air"] != null
        ? LastEpisodeToAir.fromJson(json["next_episode_to_air"])
        : null,
    networks: List<Network>.from(json["networks"]?.map((x) => Network.fromJson(x)) ?? []),
    numberOfEpisodes: json["number_of_episodes"] ?? 0, // Default to 0
    numberOfSeasons: json["number_of_seasons"] ?? 0, // Default to 0
    originCountry: List<String>.from(json["origin_country"]?.map((x) => x) ?? []),
    originalLanguage: json["original_language"] ?? "", // Default to empty string
    originalName: json["original_name"] ?? "", // Default to empty string
    overview: json["overview"] ?? "", // Default to empty string
    popularity: (json["popularity"] ?? 0).toDouble(), // Default to 0
    posterPath: json["poster_path"], // Nullable, no default
    productionCompanies: List<ProductionCompany>.from(
        json["production_companies"]?.map((x) => ProductionCompany.fromJson(x)) ?? []),
    productionCountries: List<ProductionCountry>.from(
        json["production_countries"]?.map((x) => ProductionCountry.fromJson(x)) ?? []),
    seasons: List<Season>.from(json["seasons"]?.map((x) => Season.fromJson(x)) ?? []),
    spokenLanguages: List<SpokenLanguage>.from(
        json["spoken_languages"]?.map((x) => SpokenLanguage.fromJson(x)) ?? []),
    status: json["status"] ?? "", // Default to empty string
    tagline: json["tagline"] ?? "", // Default to empty string
    type: json["type"] ?? "", // Default to empty string
    voteAverage: (json["vote_average"] ?? 0).toDouble(), // Default to 0
    voteCount: json["vote_count"] ?? 0, // Default to 0
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "created_by": List<dynamic>.from(createdBy.map((x) => x)),
    "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
    "first_air_date": firstAirDate.toIso8601String(),
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "last_air_date": lastAirDate.toIso8601String(),
    "last_episode_to_air": lastEpisodeToAir.toJson(),
    "next_episode_to_air": nextEpisodeToAir != null ? nextEpisodeToAir!.toJson() : null,
    "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
    "production_countries": List<dynamic>.from(productionCountries.map((x) => x.toJson())),
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
    "spoken_languages": List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class Genre {
  Genre({required this.id, required this.name});

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Network {
  Network({required this.id, required this.name});

  int id;
  String name;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class ProductionCompany {
  ProductionCompany({required this.id, required this.name});

  int id;
  String name;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class ProductionCountry {
  ProductionCountry({required this.iso31661, required this.name});

  String iso31661;
  String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => ProductionCountry(
    iso31661: json["iso_3166_1"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "iso_3166_1": iso31661,
    "name": name,
  };
}

class Season {
  Season({required this.airDate, required this.episodeCount, required this.name});

  String airDate;
  int episodeCount;
  String name;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
    airDate: json["air_date"] ?? "",
    episodeCount: json["episode_count"] ?? 0,
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate,
    "episode_count": episodeCount,
    "name": name,
  };
}

class SpokenLanguage {
  SpokenLanguage({required this.englishName, required this.iso6391, required this.name});

  String englishName;
  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"] ?? "",
    iso6391: json["iso_639_1"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}

class LastEpisodeToAir {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.showId,
    required this.voteAverage,
    required this.voteCount,
  });

  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  int showId;
  double voteAverage;
  int voteCount;

  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => LastEpisodeToAir(
    airDate: json["air_date"] ?? "",
    episodeNumber: json["episode_number"] ?? 0,
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    overview: json["overview"] ?? "",
    productionCode: json["production_code"] ?? "",
    seasonNumber: json["season_number"] ?? 0,
    showId: json["show_id"] ?? 0,
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "air_date": airDate,
    "episode_number": episodeNumber,
    "id": id,
    "name": name,
    "overview": overview,
    "production_code": productionCode,
    "season_number": seasonNumber,
    "show_id": showId,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

// Example of how to use the MovieDetailedModel
void main() {
  // Example JSON data for testing
  String jsonData = '''
  {
    "adult": false,
    "backdrop_path": "/path/to/backdrop.jpg",
    "created_by": [],
    "episode_run_time": [60],
    "first_air_date": "2023-01-01",
    "genres": [{"id": 1, "name": "Drama"}],
    "homepage": "https://example.com",
    "id": 1,
    "in_production": true,
    "languages": ["en"],
    "last_air_date": "2023-01-10",
    "last_episode_to_air": {
      "air_date": "2023-01-10",
      "episode_number": 10,
      "id": 1,
      "name": "Season Finale",
      "overview": "The final episode.",
      "production_code": "ABC123",
      "season_number": 1,
      "show_id": 1,
      "vote_average": 8.0,
      "vote_count": 100
    },
    "next_episode_to_air": null,
    "networks": [{"id": 1, "name": "Network Name"}],
    "number_of_episodes": 10,
    "number_of_seasons": 1,
    "origin_country": ["US"],
    "original_language": "en",
    "original_name": "Original Name",
    "overview": "This is a description of the series.",
    "popularity": 10.0,
    "poster_path": "/path/to/poster.jpg",
    "production_companies": [{"id": 1, "name": "Production Company"}],
    "production_countries": [{"iso_3166_1": "US", "name": "United States"}],
    "seasons": [],
    "spoken_languages": [{"english_name": "English", "iso_639_1": "en", "name": "English"}],
    "status": "Ended",
    "tagline": "This is a tagline.",
    "type": "scripted",
    "vote_average": 7.0,
    "vote_count": 200
  }
  ''';

  // Parse the JSON data
  MovieDetailedModel movie = MovieDetailedModel.fromJson(json.decode(jsonData));

  // Display some of the parsed data
  print('Movie ID: ${movie.id}');
  print('Title: ${movie.originalName}');
  print('Overview: ${movie.overview}');
  print('Genres: ${movie.genres.map((g) => g.name).join(", ")}');
  print('Last Episode Name: ${movie.lastEpisodeToAir.name}');
}
