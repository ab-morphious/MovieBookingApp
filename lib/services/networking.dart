import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});
  String url;

  Future getMovies() async {
    var response = await http.get(Uri.encodeFull(url), headers: {
      "Accept": "application/json",
    });

    var moviesResult = json.decode(response.body);
    List movieList = moviesResult['Search'];
    return movieList;
  }

  Future getMovie() async {
    var response = await http.get(Uri.encodeFull(url), headers: {
      "Accept": "application/json",
    });

      var selectedMovie = json.decode(response.body);

    return (selectedMovie);
  }
}
