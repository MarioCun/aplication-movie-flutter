import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';

class MovieSlider extends StatefulWidget {
  
  final String? title ;
  final List<Movie> movie;
  final Function onNextPage;

  const MovieSlider({Key? key, 
  this.title,
  required this.movie,
  required this.onNextPage
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController =  ScrollController();

   @override
   void initState() {
     super.initState();
  
  scrollController.addListener(() {
    if( scrollController.position.pixels >=  scrollController.position.maxScrollExtent - 400 ){
      widget.onNextPage();
    }

  });


   }
   @override
  void dispose() {
    
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 270,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        
        if(widget.title != null)
         Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Text(widget.title!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        const SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movie.length,
              itemBuilder: (_, int index) =>  _MoviePoster(widget.movie[index],'${widget.title}-$index-${ widget.movie[index].id}')
              ),
        )
      ]),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  
final Movie movie;
final String? heroId;
  
  
  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {

  movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
         GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: movie),
              child: Hero(
                tag: movie.heroId!,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:  FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(movie.fullPosterImg),
                      width: 130,
                      height: 190,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
