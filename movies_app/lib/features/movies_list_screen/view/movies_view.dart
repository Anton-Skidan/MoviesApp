import 'package:flutter/material.dart';
import 'package:movies_app/features/movies_list_screen/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoviesProvider provider = context.watch<MoviesProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.read<MoviesProvider>().fetchMoviesByQuery(
                          _searchController.text,
                        );
                  },
                ),
              ),
            ),
          ),

          if (provider.isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),

          if (provider.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(provider.errorMessage!),
            ),

          Expanded(
            child: ListView.separated(
              itemCount: provider.movies.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, int index) {
                final movie = provider.movies[index];
                return ListTile(
                  leading: Image.network(
                    movie.poster,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text('${movie.year} • Rank ${movie.rank}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}