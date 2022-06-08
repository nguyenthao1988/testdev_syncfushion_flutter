import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool isViewMonth = true;
  CalendarController _controller = CalendarController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduler Test'),
        actions: [
          IconButton(
              onPressed: () {
                if (_controller.view == CalendarView.month) {
                  _controller.view = CalendarView.schedule;
                } else {
                  _controller.view = CalendarView.month;
                }
              },
              icon: Icon(Icons.compare_arrows_rounded))
        ],
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    return SfCalendar(
      controller: _controller,
      headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          backgroundColor: Colors.purple,
          textStyle: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              letterSpacing: 0,
              color: Color(0xFFff5eaea),
              fontWeight: FontWeight.w500)),
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      showDatePickerButton: true,
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: true,
        showTrailingAndLeadingDates: true,
      ),
      // backgroundColor: Colors.blueAccent.withOpacity(0.3),
      showWeekNumber: true,
      firstDayOfWeek: 1,
      showCurrentTimeIndicator: true,
      onSelectionChanged: (data) {
        var b = data;
      },
      onTap: (value) {
        if (value.appointments == null) return;
        if (value.appointments!.toList(growable: true).isNotEmpty) {
          try {
            var c = value.appointments![0] as Meeting;

            var snackBar = SnackBar(
              content: Text(c.eventName.toString()),
              backgroundColor: c.background,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } catch (ex) {}
        }
      },
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, 1);
  for (int i = 0; i < 30; i++) {
    final DateTime startTime = DateTime(today.year, today.month, today.day + i, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    if (startTime.weekday == 6) {
      meetings.add(Meeting('Đi nhậu 5C', startTime, endTime, const Color(0xFF0F8644), false));
    } else if (startTime.weekday == 7) {
      meetings.add(Meeting('Họp tú dê', startTime, endTime, Colors.blueAccent, false));
      meetings.add(Meeting('Karaoke Thùy Dương', endTime.add(Duration(hours: 4)),
          endTime.add(Duration(hours: 6)), Colors.deepPurple, false));
      meetings.add(Meeting('Karaoke Thùy Dương', endTime.add(Duration(hours: 4)),
          endTime.add(Duration(hours: 6)), Colors.deepPurple, false));
      meetings.add(Meeting('Karaoke Thùy Dương', endTime.add(Duration(hours: 4)),
          endTime.add(Duration(hours: 6)), Colors.deepPurple, false));
      meetings.add(Meeting('Karaoke Thùy Dương', endTime.add(Duration(hours: 4)),
          endTime.add(Duration(hours: 6)), Colors.deepPurple, false));
      meetings.add(Meeting('Karaoke Thùy Dương', endTime.add(Duration(hours: 4)),
          endTime.add(Duration(hours: 6)), Colors.deepPurple, false));
      meetings.add(Meeting('Karaoke Thùy Dương', endTime.add(Duration(hours: 4)),
          endTime.add(Duration(hours: 6)), Colors.deepPurple, false));
      meetings.add(Meeting('Karaoke Thùy Dương', endTime.add(Duration(hours: 4)),
          endTime.add(Duration(hours: 6)), Colors.deepPurple, false));
    } else {
      meetings.add(Meeting('Đi Hồ Đá', endTime, endTime.add(Duration(hours: 2)), Colors.pink, false));
    }
    // meetings.add(Meeting(
    //     'Đi karaoke', endTime.add(Duration(hours: 4)), endTime.add(Duration(hours: 6)), Colors.red, false));
    // meetings.add(Meeting('Đi nhậu', startTime, endTime, const Color(0xFF0F8644), false));
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
