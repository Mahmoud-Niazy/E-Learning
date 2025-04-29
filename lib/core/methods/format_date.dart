String formatDate(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}