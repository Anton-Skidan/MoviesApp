class Movie {
  final String title;
  final int year;
  final int rank;
  final String poster;
  final String actors;
  final String aka;

  Movie({
    required this.title,
    required this.year,
    required this.rank,
    required this.poster,
    required this.actors,
    required this.aka,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['#TITLE'] ?? '',
      year: json['#YEAR'] ?? 0,
      rank: json['#RANK'] ?? 0,
      poster: json['#IMG_POSTER'] ?? '',
      actors: json['#ACTORS'] ?? '',
      aka: json['#AKA'] ?? '',
    );
  }
}
