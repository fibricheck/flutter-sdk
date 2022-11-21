import 'dart:convert';

import 'package:http/http.dart';

import '../../api/httpclient.dart';
import '../../constants/keys_fibricheck_sdk.dart';
import '../report/report.dart';
import 'paged_results.dart';

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
    var reports = resultObj[KeysFibricheckSDK.data];
    List<PeriodicReport> reportsList = <PeriodicReport>[];
    for (var r in reports) {
      reportsList.add(PeriodicReport.fromJson(r));
    }

    var page = Page();
    page.limit = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.limit];
    page.offset = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.offset];
    page.total = resultObj[KeysFibricheckSDK.page][KeysFibricheckSDK.total];

    result = reportsList;
    this.page = page;
  }
}
