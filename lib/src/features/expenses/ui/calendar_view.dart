import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends HookConsumerWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarFormat = useState(CalendarFormat.month);
    final selectedDay = useState(DateTime.now());

    return TableCalendar(
      focusedDay: selectedDay.value,
      firstDay: DateTime(2024, 08, 01),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay.value, day);
      },
      onDaySelected: (newSelectedDay, focusedDay) {
        selectedDay.value = newSelectedDay;
      },
      calendarFormat: calendarFormat.value,
      onFormatChanged: (newCalendarFormat) {
        calendarFormat.value = newCalendarFormat;
      },
      onPageChanged: (focusedDay) {
        selectedDay.value = focusedDay;
      },
    );
  }
}
