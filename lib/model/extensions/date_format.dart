import '../consts/availability_values.dart';

extension DateFormat on DateTime {
  String format1() {
    String _dayWord = dayWord(this.weekday);
    String _monthWord = monthWord(this.month);
    String day = this.day.toString();
    String year = this.year.toString();
    final fo='$day $_monthWord $year, $_dayWord';

    return fo;
  }
  String format2() {
    String _dayWord = dayWord(this.weekday);
    String _monthWord = monthWord(this.month);
    String day = this.day.toString();
    String year = this.year.toString();
    final fo='$_monthWord $year';

    return fo;
  }

  String monthWord(int index) => months[index - 1];
  String dayWord(int index) => days[index - 1];
}
