import 'package:fitbitter/src/data/fitbitActivityTimeseriesData.dart';
import 'package:fitbitter/src/data/fitbitData.dart';
import 'package:fitbitter/src/managers/fitbitDataManager.dart';
import 'package:fitbitter/src/urls/fitbitAPIURL.dart';
import 'package:fitbitter/src/urls/fitbitActivityTimeseriesIntradayAPIURL.dart';
import 'package:logger/logger.dart';

class FitbitActivityTimeseriesIntradayDataManager extends FitbitDataManager {
  FitbitActivityTimeseriesIntradayDataManager(
      {required String clientID, required String clientSecret})
      : super(
          clientID: clientID,
          clientSecret: clientSecret,
        );

  @override
  Future<List<FitbitData>> fetch(FitbitAPIURL fitbitUrl) async {
    final fitbitSpecificUrl =
        fitbitUrl as FitbitActivityTimeseriesIntradayAPIURL;
    final String type = fitbitSpecificUrl.resourceString;

    final response = await getResponse(fitbitUrl);

    final logger = Logger();
    logger.i('$response');

    List<FitbitData> ret = _extractFitbitActivityTimeseriesIntradayData(
        response, fitbitUrl.fitbitCredentials!.userID, type);
    return ret;
  } // fetch

  List<FitbitActivityTimeseriesData>
      _extractFitbitActivityTimeseriesIntradayData(
          dynamic response, String? userID, String type) {
    final daySummaryData = response['activities-$type'];
    final intradayData = response['activities-$type-intraday']['dataset'];

    List<FitbitActivityTimeseriesData> atDatapoints =
        List<FitbitActivityTimeseriesData>.empty(growable: true);

    if (daySummaryData[0] == null) {
      return atDatapoints;
    }

    final dayDate = DateTime.parse(daySummaryData[0]['dateTime']);

    for (var record = 0; record < intradayData.length; record++) {
      final dateWithTime = dayDate.add(Duration(
          hours: int.parse(intradayData[record]['time'].substring(0, 2)),
          minutes: int.parse(intradayData[record]['time'].substring(3, 5)),
          seconds: int.parse(intradayData[record]['time'].substring(6, 8))));

      atDatapoints.add(FitbitActivityTimeseriesData(
        userID: userID,
        dateOfMonitoring: dateWithTime,
        type: type,
        value: double.parse(intradayData[record]['value'].toString()),
      ));
    }

    return atDatapoints;
  }
}
