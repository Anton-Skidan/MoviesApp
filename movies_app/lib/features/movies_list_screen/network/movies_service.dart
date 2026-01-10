import 'package:chopper/chopper.dart';

part 'movies_service.chopper.dart';

@ChopperApi()
abstract class MoviesService extends ChopperService {
  @Get(path: '/search')
Future<Response<Map<String, dynamic>>> searchMovies(@Query('q') String query);

  static MoviesService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://imdb.iamidiotareyoutoo.com'),
      services: [
        _$MoviesService(),
      ],
      converter: const JsonConverter(),
    );

    return _$MoviesService(client);
  }
}