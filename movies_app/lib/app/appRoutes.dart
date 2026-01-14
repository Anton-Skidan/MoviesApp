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

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case movieDetails:
        final Object? args = settings.arguments;

        if (args is Movie) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => MovieDetailsScreen(movie: args),
          );
        }

        return _errorRoute('Invalid arguments for $movieDetails');

      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Navigation error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
