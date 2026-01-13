import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/common_models/common_models.dart';

class MovieListItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieListItem({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: CachedNetworkImage(
          imageUrl: movie.poster,
          fit: BoxFit.cover,
          placeholder: (_, __) => const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (_, __, ___) => const Icon(Icons.broken_image, size: 32),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text('${movie.year} • Rank ${movie.rank}'),
    );
  }
}
