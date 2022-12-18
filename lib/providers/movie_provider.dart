
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/search_response.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/top_rated_respose.dart';
import 'package:peliculas_app/models/upcoming_response.dart';

class MoviesProvider extends ChangeNotifier {
  
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '368be3361cacedd09eae15d0e606b33a';
  final String _leguage = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  List<Movie> onTopMovies = [];
  List<Movie> onUpcomingMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

 MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
    getTopMovies();
    getUpComingMovies();
  }
  


  Future<String> _getJsonData( String endpoint,[int page = 1] ) async{
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _leguage,
      'page': '$page'
    });
    final response = await http.get(url);
    return response.body;
  }
  
  getOnDisplayMovies() async {
    final jsondata = await _getJsonData('3/movie/now_playing');
    final nowPlayingRespose = NowPlayingRespose.fromJson(jsondata);
    onDisplayMovies = nowPlayingRespose.results;
    notifyListeners();
  }
  
  getPopularMovies() async {
    _popularPage ++;
    final jsondata = await _getJsonData('3/movie/popular', _popularPage);
    final  popularResponse = PopularResponse.fromJson(jsondata);
    onPopularMovies = [...onPopularMovies, ...popularResponse.results];
    notifyListeners();
  }
  
  getTopMovies() async {
    _popularPage ++;
    final jsondata = await _getJsonData('3/movie/top_rated', _popularPage);
    final  topRespose = TopRatedRepose.fromJson(jsondata);
    onTopMovies = [...onTopMovies, ...topRespose.results];
    notifyListeners();
  }
  
  getUpComingMovies() async {
    _popularPage ++;
    final jsondata = await _getJsonData('3/movie/upcoming', _popularPage);
    final upComingResponse = UpcomingRespose.fromJson(jsondata);
    onUpcomingMovies = [...onUpcomingMovies, ...upComingResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> geyMovieCast( int movieId ) async{

    if(moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final jsondata = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsondata);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future<List<Movie>> searchMovie( String query) async{

   final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _leguage,
      'query': query
    });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body) ;
    
    return searchResponse.results;

  }   
}
