import 'package:timeago/timeago.dart' as timeago;

String calculateTimeAgo(DateTime postedTime) {
  // final parsedTime = DateTime.parse(postedTime).toLocal();
  // final now = DateTime.now();
  // final difference = now.difference(parsedTime);
  // return timeago.format(now.subtract(difference));
  return timeago.format(postedTime);
}
