import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Movies '),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        body: Container(child: Column(children: <Widget>[_swipperCard()])));
  }

  Widget _swipperCard() {
    return Container(
      width: double.infinity,
      height: 200,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://psmedia.playstation.com/is/image/psmedia/god-of-war-listing-thumb-01-ps4-eu-19jun17',
            fit: BoxFit.fill,
          );
        },
        //autoplay: true,
        itemCount: 2,
        itemWidth: 200,
        //scrollDirection: Axis.vertical,
       // pagination: SwiperPagination(alignment: Alignment.bottomCenter),
       // control: SwiperControl(),
      ),
    );
  }
}
