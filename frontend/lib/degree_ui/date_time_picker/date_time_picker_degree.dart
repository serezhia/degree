import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/degree_ui/utils/datetime_utils/date_time_utils.dart';

class DateTimePickerDegree extends StatefulWidget {
  const DateTimePickerDegree({
    required this.currentDateTimeRange,
    required this.currentDate,
    required this.onDateChanged,
    required this.onTapBackDateRange,
    required this.onTapForwardDateRange,
    super.key,
  });

  final DateTimeRange currentDateTimeRange;
  final DateTime currentDate;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onTapBackDateRange;
  final VoidCallback onTapForwardDateRange;

  @override
  State<DateTimePickerDegree> createState() => _DateTimePickerDegreeState();
}

class _DateTimePickerDegreeState extends State<DateTimePickerDegree> {
  List<Widget> buildDateTimeTile() {
    final list = <Widget>[];
    for (var i = 0; i < 7; i++) {
      list.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onDateChanged(
                widget.currentDateTimeRange.start.add(Duration(days: i)),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: widget.currentDate
                            .difference(
                              widget.currentDateTimeRange.start
                                  .add(Duration(days: i)),
                            )
                            .inDays ==
                        0
                    ? Colors.black
                    : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.currentDateTimeRange.start
                              .add(Duration(days: i))
                              .weekdayName() ??
                          '',
                      style: TextStyle(
                        color: widget.currentDate
                                    .difference(
                                      widget.currentDateTimeRange.start
                                          .add(Duration(days: i)),
                                    )
                                    .inDays ==
                                0
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.currentDateTimeRange.start
                          .add(Duration(days: i))
                          .day
                          .toString(),
                      style: TextStyle(
                        color: widget.currentDate
                                    .difference(
                                      widget.currentDateTimeRange.start
                                          .add(Duration(days: i)),
                                    )
                                    .inDays ==
                                0
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 700) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: widget.onTapBackDateRange,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_back_ios),
                ),
              ),
              Expanded(
                child: Row(
                  children: buildDateTimeTile(),
                ),
              ),
              GestureDetector(
                onTap: widget.onTapForwardDateRange,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: const BoxConstraints(
          minHeight: 50,
          maxHeight: 50,
          maxWidth: 350,
          minWidth: 300,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: widget.onTapBackDateRange,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            Expanded(
              child: Row(
                children: buildDateTimeTile(),
              ),
            ),
            GestureDetector(
              onTap: widget.onTapForwardDateRange,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      );
    }
  }
}
