import 'package:flutter/material.dart';
import 'package:memoir_mu/model/event.dart';
import 'package:memoir_mu/services/crud.dart';
import 'package:memoir_mu/views/detail_view.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
  }

class _CalendarViewState extends State<CalendarView> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.date.year, event.date.month, event.date.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text(
            "Calendar",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            "View",
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[700]
            ),
          ),
          SizedBox(width: 50,)
        ],),
      ),
      body: StreamBuilder<List<EventModel>>(
        stream: eventDBS.streamList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<EventModel> allEvents = snapshot.data;
            if (allEvents.isNotEmpty) {
              _events = _groupEvents(allEvents);
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TableCalendar(
                  events: _events,
                  calendarStyle: CalendarStyle(
                    markersColor: Colors.white
                  ),
                  onDaySelected: (date, events) {
                    setState(() {
                      _selectedEvents = events;
                    });
                  },
                  calendarController: _controller,
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                ... _selectedEvents.map((event) => ListTile(
                  title: Text(event.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMemoirView(authorName: event.authorName, description: event.description, cover: event.imgURL, title: event.title)
                      )
                    );
                  }
                ))
              ]
            )
          );
        }
      )
    );
  }
}