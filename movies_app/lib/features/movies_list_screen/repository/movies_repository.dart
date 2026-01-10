import 'package:movies_app/common_models/common_models.dart';
import 'package:movies_app/features/movies_list_screen/network/movies_service.dart';

class MoviesRepository {
  final MoviesService _moviesService;

  MoviesRepository(this._moviesService);

  Future<List<Movie>> searchMovies(String searchQuery) async {
    final response = await _moviesService.searchMovies(searchQuery);

    final Map<String, dynamic>? responseBody = response.body;

    if (responseBody == null || responseBody['description'] is! List) {
      throw Exception('Invalid API response format');
    }

    final List<dynamic> items = responseBody['description'] as List<dynamic>;

    return items
        .map<Movie>(
          (dynamic item) =>
              Movie.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}