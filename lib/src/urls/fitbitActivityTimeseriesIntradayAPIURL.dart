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

    String detailLevelStr;

    switch (detailLevel) {
      case IntradayDetailLevel.ONE_SECOND:
        detailLevelStr = '1min';
        break;
      case IntradayDetailLevel.ONE_MINUTE:
        detailLevelStr = '1min';
        break;
      case IntradayDetailLevel.FIVE_MINUTES:
        detailLevelStr = '5min';
        break;
      case IntradayDetailLevel.FIFTEEN_MINUTES:
        detailLevelStr = '15min';
        break;
    }

    return FitbitActivityTimeseriesIntradayAPIURL(
      url:
          '${_getBaseURL(fitbitCredentials.userID)}/${resourceToString[resource]}/date/$dateStr/1d/$detailLevelStr.json',
      resourceString: resourceToString[resource]!,
      fitbitCredentials: fitbitCredentials,
    );
  }

  static String _getBaseURL(String? userID) {
    return 'https://api.fitbit.com/1/user/$userID/activities';
  }
}
