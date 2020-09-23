import 'package:flutter/material.dart';
import 'package:movie_app_new/custom/itemRatingMovie.dart';
import 'package:movie_app_new/custom/itemTab.dart';
import 'package:movie_app_new/custom/posterMovie.dart';

import 'package:movie_app_new/models/movie.dart';
import 'package:movie_app_new/screen/movieDetail.dart';
import 'package:movie_app_new/services/servicesMovie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  int _selectPage = 0;
  List<Movie> list = [];
  bool cekData = false;
  @override
  void initState() {
    ServicesMovie.getNowPlaying().then((value) {
      setState(() {
        list = value;
        if (list.length > 0) {
          cekData = true;
        } else {
          cekData = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
          )),
          child: TabBarView(
            children: [
              cekData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: PageView.builder(
                              onPageChanged: (a) {
                                setState(() {
                                  _selectPage = a;
                                });
                              },
                              controller: pageController,
                              itemCount: list.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieDetail(
                                                  index: i,
                                                  models: list[i],
                                                )));
                                  },
                                  child: PosterMovie(
                                    selectPage: _selectPage,
                                    index: i,
                                    imgUrl:
                                        "https://image.tmdb.org/t/p/w220_and_h330_face${list[i].posterPath}",
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Text(
                          "${list[_selectPage].originalTitle}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Category Movie | 2 Hours",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ItemRating(
                              rating: "${list[_selectPage].popularity}",
                              titleRating: "Popularity",
                            ),
                            ItemRating(
                              rating: "${list[_selectPage].voteCount}",
                              titleRating: "Vote Count",
                            ),
                            ItemRating(
                              rating: "${list[_selectPage].voteAverage}",
                              titleRating: "Vote Avarage",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          padding: EdgeInsets.symmetric(vertical: 16),
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
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    )
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              Container(
                child: Center(
                  child: Text("Popular"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Top Rated"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Coming Soon"),
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(),
        // NAVIGASI ATAS
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
              color: Colors.white,
              width: 0.5,
            )),
            isScrollable: true,
            tabs: [
              ItemTabs(
                icon: Icons.home,
                title: "Now Playing",
              ),
              ItemTabs(
                icon: Icons.favorite,
                title: "Popular",
              ),
              ItemTabs(
                icon: Icons.feedback,
                title: "Top Rated",
              ),
              ItemTabs(
                title: "Coming Soon",
                icon: Icons.history,
              ),
              // Tab(
              //   icon: Icon(Icons.home),
              //   text: "Popular",
              // ),
              // Tab(
              //   icon: Icon(Icons.home),
              //   text: "Top Rated",
              // ),
              // Tab(
              //   icon: Icon(Icons.home),
              //   text: "Coming Soon",
              // ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Movies"),
          centerTitle: true,
          // MENU SEBELAH KANAN ATAS
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
