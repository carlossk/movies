import 'package:flutter/material.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {
  //MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            _posterTitle(context, movie),
            _description(movie),
            _createCast(movie),
          ]))
        ],
      ),
    );
  }

  _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          placeholder: AssetImage(movie.getAssetImage()),
          image: NetworkImage(movie.getBackgroundImg()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.subhead,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subhead,
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        movie.overview.isEmpty ? 'Sin descripción':movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  _createCast(Movie movie) {
    final movieProvider = MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getActors(movie.id),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return _createActorsPage(snapshot.data);
      },
    );
  }

  _createActorsPage(List<Actor> actors) {
    return SizedBox(
        height: 200,
        child: PageView.builder(
            pageSnapping: false,
            controller: PageController(viewportFraction: 0.3, initialPage: 1),
            itemCount: actors.length,
            itemBuilder: (context, i) {
              return _actorCard(actors[i]);
            }));
  }

  _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.getPosterImg()),
              placeholder: AssetImage(actor.getAssetImage()),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
