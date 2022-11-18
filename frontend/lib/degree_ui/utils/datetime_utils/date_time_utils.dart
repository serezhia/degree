extension DateTimeExtension on DateTime {
  String? weekdayName() {
    const weekdayName = <int, String>{
      1: 'Пн',
      2: 'Вт',
      3: 'Ср',
      4: 'Чт',
      5: 'Пт',
      6: 'Сб',
      7: 'Вс'
    };
    return weekdayName[weekday];
  }
}
