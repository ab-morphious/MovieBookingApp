import 'package:cinema/screens/movie_detail.dart';
import 'package:cinema/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "http://www.omdbapi.com/?s=War&page=1&apikey=f705e1a9";
  var movieList;

  @override
  void initState() {
    super.initState();
    this.getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Now Showing')),
      body: GridView.builder(
          itemCount: 5,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2.2 / 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Expanded(
                    flex: 16,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                          child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        child: Image.network(movieList[index]['Poster'],
                            fit: BoxFit.cover),
                      )),
                    ),
                  ),
                  Expanded(flex: 1,
                                      child: SizedBox(
                      height: 8.0,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      movieList[index]['Title'],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0,),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Expanded(flex: 1,
                                      child: Text(
                      movieList[index]['Year'],
                       textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetail(movieList[index])));
              },
            );
          }),
    );
  }

  void getMovieList() async {
    NetworkHelper networkHelper = NetworkHelper(url: url);
    movieList = await networkHelper.getMovies();
    setState(() {
      movieList = movieList;
    });
  }
}
