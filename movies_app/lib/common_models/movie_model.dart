class Movie {
  final String title;
  final int year;
  final int rank;
  final String poster;

  Movie({
    required this.title,
    required this.year,
    required this.rank,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['#TITLE'] ?? '',
      year: json['#YEAR'] ?? 0,
      rank: json['#RANK'] ?? 0,
      poster: json['#IMG_POSTER'] ?? '',
    );
  }
}