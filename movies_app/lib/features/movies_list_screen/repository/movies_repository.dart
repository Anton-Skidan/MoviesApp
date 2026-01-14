import 'package:chopper/chopper.dart';
import 'package:movies_app/common_models/common_models.dart';
import 'package:movies_app/features/movies_list_screen/network/movies_service.dart';
import 'package:movies_app/features/movies_list_screen/repository/movies_repository_result.dart';

class MoviesRepository {
  final MoviesService _moviesService;

  MoviesRepository(this._moviesService);

  Future<MoviesRepositoryResult<List<Movie>>> searchMovies(String searchQuery) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _moviesService.searchMovies(searchQuery);

      if (!response.isSuccessful) {
        return MoviesRepositoryResult.failure(
          'Network error: ${response.statusCode}',
        );
      }

      final Map<String, dynamic>? responseBody = response.body;
      if (responseBody == null) {
        return const MoviesRepositoryResult.failure('Empty server response');
      }

      final Object? descriptionField = responseBody['description'];
      if (descriptionField is! List<dynamic>) {
        return const MoviesRepositoryResult.failure('Invalid response format');
      }

      final List<Movie> movies = <Movie>[];

      for (final dynamic item in descriptionField) {
        if (item is Map<String, dynamic>) {
          movies.add(Movie.fromJson(item));
        }
      }

      return MoviesRepositoryResult.success(movies);
    } catch (exception) {
      return const MoviesRepositoryResult.failure('Connection error');
    }
  }
}