import 'package:flutter/material.dart';
import 'package:movies_app/common_models/common_models.dart';
import 'views/views.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          BackgroundPoster(imageUrl: movie.poster),
          const BottomGradient(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MovieBackButton(),
                const Spacer(),
                MovieInfo(movie: movie),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
