import 'package:fitbitter/src/utils/formats.dart';

import '../../fitbitter.dart';

class FitbitActivityTimeseriesIntradayAPIURL extends FitbitAPIURL {
  final String resourceString;

  FitbitActivityTimeseriesIntradayAPIURL(
      {required FitbitCredentials? fitbitCredentials,
      required String url,
      required this.resourceString})
      : super(fitbitCredentials: fitbitCredentials, url: url);

  factory FitbitActivityTimeseriesIntradayAPIURL.dayWithResource(
      {required FitbitCredentials fitbitCredentials,
      required DateTime date,
      required Resource resource,
      required IntradayDetailLevel detailLevel}) {
    String dateStr = Formats.onlyDayDateFormatTicks.format(date);
    return FitbitActivityTimeseriesIntradayAPIURL(
      url:
          '${_getBaseURL(fitbitCredentials.userID)}/${resourceToString[resource]}/date/$dateStr/1d/$detailLevel.json',
      resourceString: resourceToString[resource]!,
      fitbitCredentials: fitbitCredentials,
    );
  }

  static String _getBaseURL(String? userID) {
    return 'https://api.fitbit.com/1/user/$userID/activities';
  }
}
