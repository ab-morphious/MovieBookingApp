import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class ConfirmationPage extends StatefulWidget {
  ConfirmationPage(
      {@required this.selectedMovieTitle,
      @required this.selectedSeats,
      @required this.selectedDate,
      @required this.selectedTime});
  final selectedMovieTitle;
  final selectedSeats;
  final selectedDate;
  final selectedTime;
  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  //A screenshot package
  //initialization
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      'Cinema Ticket',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        width: 150.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      widget.selectedMovieTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 30.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                        width: 350.0,
                        height: 350.0,
                        child: Image.asset('assets/images/dummy_qr.png')),
                    SizedBox(height: 15.0),
                    SizedBox(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        height: 1,
                        color: Colors.grey,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              SizedBox(height: 10.0),
                              Text(widget.selectedDate.toString())
                            ],
                          )),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                      color: Colors.blue[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                SizedBox(height: 10.0),
                                Text(widget.selectedTime)
                              ]))
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cinema Hall',
                                style: TextStyle(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              SizedBox(height: 10.0),
                              Text('A')
                            ],
                          )),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Text(
                                  'Seat',
                                  style: TextStyle(
                                      color: Colors.blue[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                SizedBox(height: 10.0),
                                Text('${widget.selectedSeats[0]}')
                              ]))
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        height: 1,
                        color: Colors.grey,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notice',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          '1. Keep this reciept safe and private\n 2. Do not share or duplicate this receipt\n 3. The above code is valid only for one use',
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () async {
                       
                           screenshotController.capture().then((File image) async {
                          //print("Capture Done");
                          final result = await ImageGallerySaver.saveImage(
                              image.readAsBytesSync());
                          // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver
                          final snackBar = SnackBar(
                              content: Text('Image saved to gallery!'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        }).catchError((onError) {
                          print(onError);
                        });
                        
                      },
                      child: Container(
                        color: Colors.blue[300],
                        height: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Save as image',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
