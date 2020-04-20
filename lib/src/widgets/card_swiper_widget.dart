import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> movies;
  CardSwiper({@required this.movies});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://psmedia.playstation.com/is/image/psmedia/god-of-war-listing-thumb-01-ps4-eu-19jun17',
              fit: BoxFit.cover,
            ),
          );
        },
        //autoplay: true,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.width * 0.5,
        itemCount: movies.length,
        //scrollDirection: Axis.vertical,
        // pagination: SwiperPagination(alignment: Alignment.bottomCenter),
        // control: SwiperControl(),
      ),
    );
  }
}
