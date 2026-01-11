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
        child: SizedBox(
          width: 64,
          height: 64,
          child: Image.network(movie.poster, fit: BoxFit.cover),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text('${movie.year} • Rank ${movie.rank}'),
    );
  }
}
