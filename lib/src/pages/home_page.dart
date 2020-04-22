import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_horizontal.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final movies = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Movies'),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[_swipperCard(), _footer(context)])));
  }

  Widget _swipperCard() {
    return FutureBuilder(
      future: movies.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }

        return CardSwiper(movies: snapshot.data);
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(padding: EdgeInsets.only(left: 20) ,child: Text('Populares', style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 15),
          FutureBuilder(
            future: movies.getPopular(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()));
              }

              return CardHorizontal(movies: snapshot.data);
            },
          ),
        ],
      ),
    );
  }
}
