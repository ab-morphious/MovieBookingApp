import 'dart:io';
import 'dart:math';
import 'package:cinema/components/rounded_time_button.dart';
import 'package:cinema/components/text_icon_horizontal.dart';
import 'package:cinema/screens/seat_selector_page.dart';
import 'package:cinema/services/networking.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

class MovieDetail extends StatefulWidget {
  final movie;
  MovieDetail(this.movie);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var roundedTimeButtonColor1,
      roundedTimeButtonColor2,
      roundedTimeButtonColor3,
      roundedTimeButtonColor4;

  _MovieDetailState();

  String movieUrl;
  var selectedMovie;
  String movieId;
  var _selectedDate;
  List<String> showTimeList;
  String selectedTime;

  @override
  void initState() {
    super.initState();
    this.getMovieShowTime();
    movieId = widget.movie['imdbID'];
    movieUrl = "http://www.omdbapi.com/?i=${movieId}&apikey=f705e1a9";
    this.getMovie();
    _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedMovie['Title'])),
      body: Builder(
        builder: (context) => Container(
          child: ListView(
            padding: EdgeInsets.all(32.0),
            shrinkWrap: true,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child: AspectRatio(
                      aspectRatio: 4 / 5,
                      child: Image.network(widget.movie['Poster'],
                          fit: BoxFit.fill)),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.topCenter,
                      child: Text(
                        selectedMovie['Title'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 32.0),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconTextHorizontal(
                            icon: Icons.timer, text: selectedMovie['Runtime']),
                        SizedBox(width: 30.0),
                        IconTextHorizontal(
                            icon: Icons.timer, text: selectedMovie['Runtime']),
                        SizedBox(width: 30.0),
                        IconTextHorizontal(
                            icon: Icons.timer, text: selectedMovie['Runtime'])
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 1,
                child: Container(
                  color: Colors.grey[350],
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Synopsis',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  getGenreList(selectedMovie['Genre'].split(',')),
                ],
              ),
              SizedBox(height: 15.0),
              Text(selectedMovie['Plot'], textAlign: TextAlign.justify),
              SizedBox(height: 25.0),
              Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.blue[300],
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedDate = DateFormat('yyyy-MM-dd').format(date);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Text('Time', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 25.0),
              RoundedTimeButton(
                time: (showTimeList == null)
                    ? 'loading'
                    : showTimeList[0].toString(),
                availability: true,
                color: roundedTimeButtonColor1,
                onPressed: () => setRoundedTimeBotonColor(1),
              ),
              SizedBox(height: 5.0),
              RoundedTimeButton(
                  time: (showTimeList == null)
                      ? 'loading'
                      : showTimeList[1].toString(),
                  availability: true,
                  color: roundedTimeButtonColor2,
                  onPressed: () => setRoundedTimeBotonColor(2)),
              SizedBox(height: 5.0),
              RoundedTimeButton(
                  time: (showTimeList == null)
                      ? 'loading'
                      : showTimeList[2].toString(),
                  availability: true,
                  color: roundedTimeButtonColor3,
                  onPressed: () => setRoundedTimeBotonColor(3)),
              SizedBox(height: 5.0),
              RoundedTimeButton(
                  time: (showTimeList == null)
                      ? 'loading'
                      : showTimeList[3].toString(),
                  availability: true,
                  color: roundedTimeButtonColor4,
                  onPressed: () => setRoundedTimeBotonColor(4)),
              SizedBox(height: 25.0),
              GestureDetector(
                onTap: () {
                  if (selectedTime != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SeatSelector(
                                selectedMovieTitle: selectedMovie['Title'],
                                selectedDate: _selectedDate,
                                selectedTime: selectedTime)));
                  } else {
                    final snackBar =
                        SnackBar(content: Text('You must select time!'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
                child: Container(
                  color: Colors.blue[300],
                  height: 50.0,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Continue to seat selector',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getGenreList(var genres) {
    List<Widget> genreList = List<Widget>();

    for (var selMovie in genres) {
      genreList.add(
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.grey[300],
                child: Text(selMovie),
              ),
            ),
            SizedBox(width: 5.0)
          ],
        ),
      );
    }
    return Row(mainAxisSize: MainAxisSize.max, children: genreList);
  }

  void getMovie() async {
    NetworkHelper networkHelper = NetworkHelper(url: movieUrl);
    selectedMovie = await networkHelper.getMovie();
    setState(() {
      selectedMovie = selectedMovie;
    });
  }

  void getMovieShowTime() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/movie_time.xml');
    final document = XmlDocument.parse(data);
    var showTime = document.findAllElements('showtime');
    Iterable<List<String>> showTimeListFromXML = showTime.map(
        (element) => element.findElements('hour').map((e) => e.text).toList());

    showTimeList = List();

    showTimeListFromXML.forEach((element) {
      setState(() {
        showTimeList = element;
      });
    });
  }

  void setRoundedTimeBotonColor(int i) {
    setState(() {
      //Users selected time will be stored
      selectedTime = showTimeList[i - 1].toString();

      //Making selected button blue colored and unselected ones transparent
      if (i == 1) {
        roundedTimeButtonColor1 = Colors.blue[400];
        roundedTimeButtonColor2 = Colors.transparent;
        roundedTimeButtonColor3 = Colors.transparent;
        roundedTimeButtonColor4 = Colors.transparent;
      } else if (i == 2) {
        roundedTimeButtonColor2 = Colors.blue[400];
        roundedTimeButtonColor1 = Colors.transparent;
        roundedTimeButtonColor3 = Colors.transparent;
        roundedTimeButtonColor4 = Colors.transparent;
      } else if (i == 3) {
        roundedTimeButtonColor3 = Colors.blue[400];
        roundedTimeButtonColor1 = Colors.transparent;
        roundedTimeButtonColor2 = Colors.transparent;
        roundedTimeButtonColor4 = Colors.transparent;
      } else if (i == 4) {
        roundedTimeButtonColor4 = Colors.blue[400];
        roundedTimeButtonColor1 = Colors.transparent;
        roundedTimeButtonColor2 = Colors.transparent;
        roundedTimeButtonColor3 = Colors.transparent;
      }
    });
  }
}
