

import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon( Icons.clear),
        onPressed: () =>  query = "",
         )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return 
    IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        close(context, null);
      } , 
      );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResult');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    if (query.isEmpty) {
      return _IconWigets();
    }

    final movieProvider = Provider.of<MoviesProvider>(context, listen:  false);

    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {

        if ( !snapshot.hasData ) return _IconWigets(); 
        
        final movie = snapshot.data!; 

        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: (_, int index) => _MovieItem(movie[index])
        );
      },
    );

  }

}

class _MovieItem extends StatelessWidget {
  
  final Movie movie;

  const _MovieItem(this.movie);
  
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg', ), 
        image: NetworkImage(movie.fullPosterImg),
        width: 100,
        fit: BoxFit.contain,
        ),
        title: Text(
          movie.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis
        ),
        subtitle: Text(
          movie.originalTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis
        ),
         onTap: () => Navigator.pushNamed(context, 'details',
                arguments: movie),
    );
  }
}

class _IconWigets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.movie_creation_outlined, color: Colors.black45, size: 100,),
    );
  }
}