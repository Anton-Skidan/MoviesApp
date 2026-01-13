import 'package:flutter/material.dart';
import 'package:movies_app/common_models/common_models.dart';
import 'package:movies_app/features/movie_details_screen/feature.dart';
import 'package:movies_app/features/movies_list_screen/feature.dart';

class AppRoutes {
  static const String movies = '/';
  static const String movieDetails = '/movie-details';

  static final Map<String, WidgetBuilder> routes = {
    movies: (_) => const MoviesListScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == movieDetails) {
      final Movie movie = settings.arguments as Movie;

      return MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(movie: movie),
      );
    }

    return null;
  }
}
