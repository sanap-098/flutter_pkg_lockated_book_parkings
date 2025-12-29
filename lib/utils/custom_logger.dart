import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

void logDebug({
  required dynamic msg,
}) {
  logger.d(msg);
}

void logInfo({
  required dynamic msg,
}) {
  logger.i(msg);
}

void logError({
  required dynamic msg,
}) {
  logger.e(msg);
}

Future<void> logEvents({
  required String name,
  Map<String, dynamic>? parameters,
}) async {
  await FirebaseAnalytics.instance.logEvent(
    name: name,
    parameters: {
      'user_id': Prefs.getUserId() ?? '',
      'email': Prefs.getEmailAddress() ?? '',
      ...parameters ?? {},
    },
  );
}
