import 'package:flutter/material.dart';
import 'package:movie_app_new/models/movie.dart';
import 'package:movie_app_new/custom/itemRatingMovie.dart';

class MovieDetail extends StatefulWidget {
  final int index;
  final Movie models;

  const MovieDetail({Key key, this.index, this.models}) : super(key: key);
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[300],
              Colors.indigo[800],
            ],
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: 300,
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rectangle) {
                      return LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(Rect.fromLTRB(
                          0, 0, rectangle.height, rectangle.width));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      height: 190,
                      width: double.infinity,
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w220_and_h330_face${widget.models.backdropPath}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    top: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 150,
                              width: 100,
                              child: Hero(
                                tag: "${widget.index}",
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w220_and_h330_face${widget.models.posterPath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "${widget.models.originalTitle}",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Category movie | 2 hours',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ItemRating(
                                            rating:
                                                "${widget.models.voteAverage}",
                                            titleRating: "Vote Avarage",
                                          ),
                                          ItemRating(
                                            rating:
                                                "${widget.models.popularity}",
                                            titleRating: "Popularity",
                                          ),
                                          ItemRating(
                                            rating:
                                                "${widget.models.voteCount}",
                                            titleRating: "Vote Count",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      centerTitle: true,
                      // MENU SEBELAH KANAN ATAS
                      actions: [
                        IconButton(
                          icon: Icon(Icons.bookmark_border),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(
                    "${widget.models.overview}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "Read More",
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        )),
                    child: Text(
                      "Buy Tickets",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
