import 'dart:convert';

import 'package:flutter_fibricheck_sdk/report.dart';
import 'package:http/http.dart';

import 'api/httpclient.dart';
import 'measurement.dart';

class Page {
  late int total;
  late int offset;
  late int limit;
}

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
    var measurements = resultObj["data"];

    var page = Page();
    page.limit = resultObj["page"]["limit"];
    page.offset = resultObj["page"]["offset"];
    page.total = resultObj["page"]["total"];

    List<Measurement> measurementList = <Measurement>[];
    for (var m in measurements) {
      measurementList.add(Measurement.fromJson(m));
    }

    result = measurementList;
    this.page = page;
  }
}

class PagedPeriodicReportsResult {
  late List<PeriodicReport> result;
  late Page page;
  final OAuth1Client _client;
  final bool newestFirst;
  final String userId;

  PagedPeriodicReportsResult({
    required this.result,
    required this.page,
    required OAuth1Client client,
    required this.newestFirst,
    required this.userId,
  }) : _client = client;

  Future<PagedPeriodicReportsResult> getNextPagedPeriodicReportsResult() async {
    var res = await _client.getNextPeriodicReports(userId, page, newestFirst);
    _extractObjectData(res);
    return this;
  }

  Future<PagedPeriodicReportsResult> getPreviousPagedPeriodicReportsResult() async {
    var res = await _client.getPreviousPeriodicReports(userId, page, newestFirst);
    _extractObjectData(res);
    return this;
  }

  void _extractObjectData(Response res) {
    Map<String, dynamic> resultObj = jsonDecode(res.body);
    var reports = resultObj["data"];
    List<PeriodicReport> reportsList = <PeriodicReport>[];
    for (var r in reports) {
      reportsList.add(PeriodicReport.fromJson(r));
    }

    var page = Page();
    page.limit = resultObj["page"]["limit"];
    page.offset = resultObj["page"]["offset"];
    page.total = resultObj["page"]["total"];

    result = reportsList;
    this.page = page;
  }
}
