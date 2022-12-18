
import 'package:flutter/material.dart';

import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:peliculas_app/search/search_delegate.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PeliadiAPP',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          CardSwipeScreen(movies: moviesProvider.onDisplayMovies, ),
          MovieSlider(movie: moviesProvider.onPopularMovies, title: 'Estrenos', onNextPage: () => moviesProvider.getPopularMovies()),
          const SizedBox(height: 5),
          MovieSlider(movie: moviesProvider.onTopMovies, title: 'Top',onNextPage: () => moviesProvider.getTopMovies()),
          const SizedBox(height: 5),
          MovieSlider(movie: moviesProvider.onUpcomingMovies, title: 'Proximamente',onNextPage: () => moviesProvider.getUpComingMovies()),
        ],),)
    );
  }
}
