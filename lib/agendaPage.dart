import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform(
          transform: Matrix4.skewX(
              -0.2), // skew the text by 0.3 radians (about 17 degrees)
          child: Text(
            'Agenda',
            style: GoogleFonts.anton(
              textStyle: const TextStyle(
                fontSize: 27,
                color: Color.fromARGB(255, 238, 238, 238),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        centerTitle: true,
      ),
      body: SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        todayHighlightColor: const Color.fromARGB(255, 133, 0, 0),
      ),
    );
  }
}
