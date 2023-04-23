import 'package:ethicalfitness_2/event.dart';
import 'package:ethicalfitness_2/eventEditingPage.dart';
import 'package:ethicalfitness_2/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ethicalfitness_2/event_provider.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;
  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const CloseButton(),
          actions: buildViewingActions(context, event),
        ),
        body: ListView(
          padding: const EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(event),
            const SizedBox(height: 32),
            Text(
              event.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              event.description,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      );

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        if (!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${Utils.toDate(date)} ${Utils.toTime(date)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => EventEditingPage(event: event),
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.deleteEvent(event);
        },
      ),
    ];
  }
}
