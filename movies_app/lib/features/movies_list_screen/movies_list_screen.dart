import 'package:flutter/material.dart';
import 'package:movies_app/app/appRoutes.dart';
import 'package:movies_app/features/movies_list_screen/provider/movies_provider.dart';
import 'package:provider/provider.dart';
import 'views/movie_list_item.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({super.key});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoviesProvider provider = context.watch<MoviesProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                textInputAction: TextInputAction.search,
                onEditingComplete: () {
                  context.read<MoviesProvider>().fetchMoviesByQuery(
                    _searchController.text,
                  );
                  _searchFocusNode.unfocus();
                },
                decoration: const InputDecoration(
                  hintText: 'Search movies',
                  suffixIcon: Icon(Icons.search),
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
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: provider.movies.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, int index) {
                  final movie = provider.movies[index];

                  return MovieListItem(
                    movie: movie,
                    onTap: () {
                      _searchFocusNode.unfocus();

                      Navigator.pushNamed(
                        context,
                        AppRoutes.movieDetails,
                        arguments: movie,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
