import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieResult {
  final String id;
  final String title;
  final String year;

  MovieResult({required this.id, required this.title, required this.year});

  factory MovieResult.fromJson(Map<String, dynamic> json) {
    return MovieResult(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      year: json['year'] ?? '',
    );
  }
}

Future<List<MovieResult>> searchMovies(String query) async {
  final url = Uri.parse('https://imdb.iamidiotareyoutoo.com/search?q=$query');
  final response = await http.get(url);

  print('STATUS: ${response.statusCode}');
  print('BODY RAW:');
  print(response.body.substring(0, response.body.length > 500 ? 500 : response.body.length));

  if (response.statusCode != 200) {
    throw Exception('Ошибка загрузки: ${response.statusCode}');
  }

  final data = jsonDecode(response.body);

  print('DECODED JSON:');
  print(data);

  final List items = data['results'] ?? [];
  print('ITEMS COUNT: ${items.length}');

  return items.map((e) => MovieResult.fromJson(e)).toList();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<MovieResult>? _movies;

  void _search() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return;
    final list = await searchMovies(q);
    setState(() => _movies = list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _search,
                ),
                hintText: 'Search movies',
              ),
            ),
          ),
          if (_movies != null)
            Expanded(
              child: ListView.builder(
                itemCount: _movies!.length,
                itemBuilder: (context, i) {
                  final m = _movies![i];
                  return ListTile(
                    title: Text(m.title),
                    subtitle: Text(m.year),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}