import 'package:flutter/material.dart';
import 'package:movies_app/features/movies_list_screen/provider/movies_provider.dart';
import 'package:movies_app/features/movies_list_screen/network/network.dart';
import 'package:movies_app/features/movies_list_screen/repository/movies_repository.dart';
import 'package:movies_app/features/movies_list_screen/view/view.dart';
import 'package:provider/provider.dart';

void main() {
  final api = MoviesService.create();
  final repo = MoviesRepository(api);

  runApp(
    ChangeNotifierProvider(
      create: (_) => MoviesProvider(repo),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MoviesListScreen(),
    );
  }
}