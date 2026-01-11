import 'package:flutter/material.dart';
import 'package:movies_app/common_models/common_models.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: SizedBox(
          width: 64,
          height: 64,
          child: Image.network(
            movie.poster,
            fit: BoxFit.cover,
            loadingBuilder: (
              BuildContext context,
              Widget child,
              ImageChunkEvent? loadingProgress,
            ) {
              if (loadingProgress == null) return child;

              return const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 32),
          ),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text('${movie.year} • Rank ${movie.rank}'),
    );
  }
}