import 'package:flutter/material.dart';
import 'package:movies_app/common_models/common_models.dart';
import 'package:movies_app/features/movies_list_screen/repository/movies_repository.dart';
import 'package:movies_app/features/movies_list_screen/repository/movies_repository_result.dart';

class MoviesProvider extends ChangeNotifier {
  final MoviesRepository _repository;

  MoviesProvider(this._repository);

  List<Movie> _movies = <Movie>[];
  bool _isLoading = false;
  String? _errorMessage;
  int _requestId = 0;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMoviesByQuery(String query) async {
    final String normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) return;

    final int currentRequest = ++_requestId;

    _setLoadingState();

    try {
      final MoviesRepositoryResult<List<Movie>> result = await _repository
          .searchMovies(normalizedQuery);

      if (!result.isSuccess) {
        _errorMessage = result.errorMessage;
        _movies = <Movie>[];
        return;
      }

      _movies = result.data!;
      _errorMessage = null;
    } catch (exception, stackTrace) {
      if (currentRequest != _requestId) return;

      _errorMessage = 'Failed to load movies';
      debugPrintStack(label: exception.toString(), stackTrace: stackTrace);
    } finally {
      if (currentRequest == _requestId) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void _setLoadingState() {
    _movies = <Movie>[];
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
  }
}
