import 'package:cinema/components/seat_column_label.dart';
import 'package:cinema/components/seat_row_label.dart';
import 'package:cinema/screens/confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class SeatSelector extends StatefulWidget {
  SeatSelector({this.selectedMovieTitle, this.selectedDate, this.selectedTime});
  final String selectedMovieTitle;
  final String selectedDate;
  final String selectedTime;
  List _selectedSeats = List();
  @override
  _SeatSelectorState createState() => _SeatSelectorState();
}

class _SeatSelectorState extends State<SeatSelector> {
  List seatList = List();
  int dropdownValue = 1;
  Color seatColor;
  List<Color> seatColors = List();
  int price = 45;

  @override
  void initState() {
    super.initState();
    this.getSeatInfo();
    for (int j = 0; j < seatList.length; j++) {
      initializeSeats(j);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Selector'),
      ),
      body: Builder(
        builder: (context) => ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 20.0),
              child: Text(
                widget.selectedMovieTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32.0),
              ),
            ),
            Text(
              'Schedule Selected',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Friday,12 ' + '|' + ' 09:30AM',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
            ),
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 32.0, 32.0, 20.0),
              color: Colors.grey[200],
              child: Column(
                children: [
                  Text(
                    'Hall 1 : Block A',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Text('Tap on your preferred seat.'),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SeatColLabel(label: 'I'),
                            SeatColLabel(label: 'H'),
                            SeatColLabel(label: 'G'),
                            SeatColLabel(label: 'F'),
                            SeatColLabel(label: 'E'),
                            SeatColLabel(label: 'D'),
                            SeatColLabel(label: 'C'),
                            SeatColLabel(label: 'B'),
                            SeatColLabel(label: 'A')
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: GridView.builder(
                            itemCount: seatList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 11),
                            itemBuilder: (BuildContext context, int index) {
                              initializeSeats(index);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if(seatColors[index] != Colors.grey){
                                    seatColors[index] = Colors.blue[400];
                                    widget._selectedSeats.add(index);
                                    }else{
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('This seat is reserved/blocked, please try selecting another')));
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: seatColors[index],
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0)),
                                    ),
                                    child: Center(child: Text('   ')),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SeatRowLabel(label: ' '),
                      SeatRowLabel(label: '1'),
                      SeatRowLabel(label: '2'),
                      SeatRowLabel(label: '3'),
                      SeatRowLabel(label: '4'),
                      SeatRowLabel(label: '5'),
                      SeatRowLabel(label: '6'),
                      SeatRowLabel(label: '7'),
                      SeatRowLabel(label: '8'),
                      SeatRowLabel(label: '9'),
                      SeatRowLabel(label: '10'),
                      SeatRowLabel(label: '11')
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Row(
                        children: [
                          Text('Ticket QTY. '),
                          SizedBox(width: 10.0),
                          DropdownButton<int>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 30,
                            elevation: 16,
                            style: TextStyle(color: Colors.teal),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (int newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                price = dropdownValue * 45;
                              });
                            },
                            items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        children: [
                          Text('Total Payable'),
                          SizedBox(width: 10.0),
                          Text(
                            '$price',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => {
                if (widget._selectedSeats.length != 0)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                          selectedMovieTitle: widget.selectedMovieTitle,
                          selectedDate: widget.selectedDate,
                          selectedTime: widget.selectedTime,
                          selectedSeats: widget._selectedSeats,
                        ),
                      ),
                    ),
                  }
                else
                  {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('You must select seat!')))
                  }
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
                      'Continue to confirmation page',
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
            SizedBox(
              height: 40.0,
            )
          ],
        ),
      ),
    );
  }

  void getSeatInfo() async {
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/seat_info.xml');
    final document = XmlDocument.parse(data);
    var showTime = document.findAllElements('seat');
    var seatInfoList = showTime
        .map(((element) => element
            .findElements('seatnumber')
            .map((e) => e.findAllElements('available').single.text)
            .toList()))
        .toList();
    print(seatInfoList.runtimeType);

    seatInfoList.forEach((element) {
      setState(() {
        seatList = element;
      });
    });
  }

  void initializeSeats(int index) {
    if (seatList[index] == 'true') {
      seatColors.add(Colors.transparent);
    } else {
      seatColors.add(Colors.grey);
    }
  }
}
