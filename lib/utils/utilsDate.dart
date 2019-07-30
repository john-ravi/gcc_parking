String validateDate(DateTime date) {
  try {
    print('printing Date  $date');
//      DateFormat.yMd().add_jm().parse(strEndDate);

    DateTime.parse(date.toIso8601String());
    return null;
  } catch (e) {
    print(e);
    return 'Select Date Time';
  }
}
