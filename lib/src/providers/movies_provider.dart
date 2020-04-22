import 'dart:convert';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = 'c366243b8764ac03cea01e519d87cd7d';

  String _url = 'api.themoviedb.org';

  String _language = 'es-ES';

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

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _ProcessResponse(url);
  }
}
