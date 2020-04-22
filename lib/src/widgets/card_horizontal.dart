import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class CardHorizontal extends StatelessWidget {
  final List<Movie> movies;

  CardHorizontal({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
          pageSnapping: false,
          controller: PageController(initialPage: 1, viewportFraction: 0.3),
          children: _cards(context)),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage(movie.getAssetImage()),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: 137,
              ),
            ),
            SizedBox(height: 5,),
            Text(movie.title, overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.caption,)
          ],
        ),
      );
    }).toList();
  }
}
