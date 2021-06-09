import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/screens/movies_detail_screen.dart';
import 'package:sizer/sizer.dart';

class MoviesListStack extends StatefulWidget {
  final List<Movie> movies;
  MoviesListStack(this.movies);

  @override
  _MoviesListStackState createState() => _MoviesListStackState();
}

class _MoviesListStackState extends State<MoviesListStack> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.height * 0.6),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height * 0.6),
              decoration: BoxDecoration(
                image: DecorationImage(
                  onError: (exception, _) {
                    return AssetImage('assets/images/placeholder.png');
                  },
                  image: CachedNetworkImageProvider(
                      'https://image.tmdb.org/t/p/w342${widget.movies[_currentIndex].posterImage}'),
                  fit: BoxFit.fill,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.2)),
                ),
              ),
            ),
            Positioned(
              top: AppBar().preferredSize.height + 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    // height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 0.6,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlayAnimationDuration: Duration(milliseconds: 1200),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 1.75,
                    onPageChanged: (index, reason) {
                      setState(() {
                        if (_currentIndex == widget.movies.length - 1) {
                          setState(() {
                            _currentIndex = 0;
                          });
                        } else {
                          setState(() {
                            _currentIndex = index;
                          });
                        }
                      });
                    },
                  ),
                  items: widget.movies.map((movie) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pushNamed(
                            context, MoviesDetailScreen.routeName,
                            arguments: movie);
                      },
                      child: Card(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              onError: (exception, _) {
                                return AssetImage(
                                    'assets/images/placeholder.png');
                              },
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                'https://image.tmdb.org/t/p/w342${movie.posterImage}',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black54),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      FittedBox(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            widget.movies[_currentIndex].title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        widget.movies[_currentIndex].overview,
                        style: TextStyle(color: Colors.white, fontSize: 9.sp),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
