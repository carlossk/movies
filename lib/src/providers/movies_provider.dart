import 'dart:async';
import 'dart:convert';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = 'c366243b8764ac03cea01e519d87cd7d';

  String _url = 'api.themoviedb.org';

  String _language = 'es-ES';

  int _popularPage = 0;

  bool _isLoading = false;

  List<Movie> _popular = List();
  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController.close();
  }

  Future<List<Movie>> _ProcessResponse(Uri url) async {
    final request = await http.get(url);

    final decodeData = json.decode(request.body);

    final movies = Movies.fromJsonList(decodeData['results']);
    return movies.items;
  }

  Future<List<Movie>> getInTheaters() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _ProcessResponse(url);
  }
  Future<List<Movie>> findMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query':query
    });

    return await _ProcessResponse(url);
  }

  Future<List<Actor>> getActors(int movie_id) async {
    final url = Uri.https(_url, '3/movie/$movie_id/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final request = await http.get(url);

    final decodeData = json.decode(request.body);

    final actors = Cast.fromJsonList(decodeData['cast']);
    return actors.items;
  }

  Future<List<Movie>> getPopular() async {
    if (_isLoading) return [];

    _isLoading = true;

    _popularPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularPage.toString(),
    });

    final response = await _ProcessResponse(url);
    _popular.addAll(response);
    popularSink(_popular);
    _isLoading = false;
    return response;
  }
}
