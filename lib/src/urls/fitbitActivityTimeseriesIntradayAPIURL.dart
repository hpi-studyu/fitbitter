import 'package:fitbitter/src/fitbitConnector.dart';
import 'package:fitbitter/src/urls/fitbitAPIURL.dart';
import 'package:fitbitter/src/utils/formats.dart';

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

enum Resource {
  activityCalories,

  calories,

  caloriesBMR,
  distance,
  elevation,
  floors,
  minutesSedentary,
  minutesLightlyActive,
  minutesFairlyActive,
  minutesVeryActive,
  steps,
}

Map<Resource, String> resourceToString = {
  Resource.activityCalories: 'activityCalories',
  Resource.calories: 'calories',
  Resource.caloriesBMR: 'caloriesBMR',
  Resource.distance: 'distance',
  Resource.elevation: 'elevation',
  Resource.floors: 'floors',
  Resource.minutesSedentary: 'minutesSedentary',
  Resource.minutesLightlyActive: 'minutesLightlyActive',
  Resource.minutesFairlyActive: 'minutesFairlyActive',
  Resource.minutesVeryActive: 'minutesVeryActive',
  Resource.steps: 'steps',
};
