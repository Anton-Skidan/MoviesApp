import 'package:flutter/material.dart';
import 'package:movies_app/common_models/common_models.dart';
import 'package:movies_app/features/movies_list_screen/repository/movies_repository.dart';

class MoviesProvider extends ChangeNotifier {
  final MoviesRepository _repository;

  MoviesProvider(this._repository);

  List<Movie> _movies = <Movie>[];
  bool _isLoading = false;
  String? _errorMessage;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMoviesByQuery(String searchQuery) async {
    final normalizedQuery = searchQuery.trim();
    if (normalizedQuery.isEmpty) return;

    _clearStateForNewSearch();

    try {
      final List<Movie> fetchedMovies =
          await _repository.searchMovies(normalizedQuery);

      _movies = fetchedMovies;
    } catch (exception, stackTrace) {
      _errorMessage = 'Failed to load movies';
      debugPrintStack(label: exception.toString(), stackTrace: stackTrace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _clearStateForNewSearch() {
    _movies = <Movie>[];
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
  }
}