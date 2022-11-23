import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:intl/intl.dart';

class WeekPickerDegree extends StatefulWidget {
  const WeekPickerDegree({
    required this.currentDateTimeRange,
    required this.onTapBackDateRange,
    required this.onTapForwardDateRange,
    super.key,
  });

  final DateTimeRange currentDateTimeRange;
  final VoidCallback onTapBackDateRange;
  final VoidCallback onTapForwardDateRange;

  @override
  State<WeekPickerDegree> createState() => _WeekPickerDegreeState();
}

class _WeekPickerDegreeState extends State<WeekPickerDegree> {
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
                child: Text(
                  '''${DateFormat.d().format(widget.currentDateTimeRange.start)} ${DateFormat.MMMM().format(widget.currentDateTimeRange.start)} - ${DateFormat.d().format(widget.currentDateTimeRange.end)} ${DateFormat.MMMM().format(widget.currentDateTimeRange.end)}''',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
              child: Text(
                '''${DateFormat.d().format(widget.currentDateTimeRange.start)} ${DateFormat.MMMM().format(widget.currentDateTimeRange.start)} - ${DateFormat.d().format(widget.currentDateTimeRange.end)} ${DateFormat.MMMM().format(widget.currentDateTimeRange.end)}''',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
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
