String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays >= 365) {
    final years = (difference.inDays / 365).floor();
    return '${years == 1 ? '1 year' : '$years years'} ago';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '${months == 1 ? '1 month' : '$months months'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays == 1 ? '1 day' : '${difference.inDays} days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours == 1 ? '1 hour' : '${difference.inHours} hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes == 1 ? '1 minute' : '${difference.inMinutes} minutes'} ago';
  } else {
    return '${difference.inSeconds == 1 ? '1 second' : '${difference.inSeconds} seconds'} ago';
  }
}
