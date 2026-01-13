import 'package:flutter/material.dart';
import 'package:movies_app/app/app.dart';
import 'package:movies_app/features/movies_list_screen/feature.dart';
import 'package:provider/provider.dart';

void main() {
  final api = MoviesService.create();
  final repo = MoviesRepository(api);

  runApp(
    ChangeNotifierProvider(
      create: (_) => MoviesProvider(repo),
      child: const MoviesApp(),
    ),
  );
}
