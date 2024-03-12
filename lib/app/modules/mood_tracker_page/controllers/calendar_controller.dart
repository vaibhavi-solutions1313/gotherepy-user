import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController{
  final DateTime initialDate = DateTime.now();
  Rx<DateTime> _selectedDate = Rx(DateTime.now());
  DateTime get selectedDate => _selectedDate.value;

  void setSelectedDate(DateTime date){
    _selectedDate.value = date;
    update();
  }

  void goToPreviousMonth(){
    _selectedDate.value = DateTime(
        _selectedDate.value.year, _selectedDate.value.month - 1,1);
    update();
  }

  void goToNextMonth(){
    _selectedDate.value = DateTime(
        _selectedDate.value.year, _selectedDate.value.month + 1,1);
    update();
  }
  
  List<String> get dayInitials => <String>[
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  
  List<List<int>> get calendarDays{
    final currentMonth = _selectedDate.value;
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final firstDayOfWeek = firstDayOfMonth.weekday;
    final daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

    final leadingEmptyDays = firstDayOfWeek - 1;
    final trailingEmptyDays = (7 - (leadingEmptyDays + daysInMonth) %7) %7;

    final days = [
      ...List.generate(
        leadingEmptyDays,
            (_) => 0),
      ...List.generate(
          daysInMonth, 
              (index) => index + 1),
      ...List.generate(
          trailingEmptyDays,
              (_) => 0)
    ];

    return List.generate(
        ((days.length / 7).ceil()),
            (index) => days.sublist(
              index * 7, (index + 1)*7
            ));
  }

  String formatMonthYear(DateTime date){
    final formatter = DateFormat('MMMM yyyy');
    return formatter.format(date);
  }
}
