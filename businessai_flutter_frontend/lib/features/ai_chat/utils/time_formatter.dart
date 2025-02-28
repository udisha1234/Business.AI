class TimeFormatter {
  static String formatTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  static String formatMessageTime(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();

      if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
        return 'Today';
      } else if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day - 1) {
        return 'Yesterday';
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    } catch (e) {
      return '';
    }
  }
}