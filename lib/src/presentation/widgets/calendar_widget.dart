import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key, required this.onDateSelected})
      : super(key: key);
  final void Function(String currentDate) onDateSelected;
  @override
  Widget build(BuildContext context) {
    return CalendarView(
      key: key,
      onDateSelected: onDateSelected,
    );
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key, required this.onDateSelected})
      : super(key: key);
  final Function onDateSelected;

  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  String currentDate = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return CalendarCarousel(
      selectedDateTime: DateTime.parse(currentDate),
      onDayPressed: (date, events) {
        setState(() => currentDate = date.toString());
        widget.onDateSelected(currentDate);
      },
    );
  }
}
