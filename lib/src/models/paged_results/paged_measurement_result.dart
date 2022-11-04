import 'dart:convert';

import 'package:flutter_fibricheck_sdk/src/constants/keys_fibricheck_sdk.dart';
import 'package:http/http.dart';

import '../../api/httpclient.dart';
import '../measurement/measurement.dart';

import 'paged_results.dart';

class PagedMeasurementResult {
  late List<Measurement> result;
  late Page page;
  final OAuth1Client _client;
  final bool newestFirst;
  final String userId;

  PagedMeasurementResult({
    required this.result,
    required this.page,
    required OAuth1Client client,
    required this.newestFirst,
    required this.userId,
  }) : _client = client;

  Future<PagedMeasurementResult> getNextMeasurements() async {
    var res = await _client.getNextMeasurements(userId, page, newestFirst);
    _extractObjectData(res);
    return this;
  }

  Future<PagedMeasurementResult> getPreviousMeasurements() async {
    var res = await _client.getPreviousMeasurements(userId, page, newestFirst);
    _extractObjectData(res);
    return this;
  }

  void _extractObjectData(Response res) {
    Map<String, dynamic> resultObj = jsonDecode(res.body);
    var measurements = resultObj[KeysFibricheckSDK.data];

    var page = Page();
    page.limit = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.limit];
    page.offset = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.offset];
    page.total = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.total];

    List<Measurement> measurementList = <Measurement>[];
    for (var m in measurements) {
      measurementList.add(Measurement.fromJson(m));
    }

    result = measurementList;
    this.page = page;
  }
}
