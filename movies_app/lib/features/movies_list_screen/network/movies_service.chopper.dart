// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$MoviesService extends MoviesService {
  _$MoviesService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = MoviesService;

  @override
  Future<Response<Map<String, dynamic>>> searchMovies(String query) {
    final Uri $url = Uri.parse('/search');
    final Map<String, dynamic> $params = <String, dynamic>{'q': query};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );

    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
