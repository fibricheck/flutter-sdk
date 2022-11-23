import '../models/paged_results/paged_results.dart' as paged_result;

class UriUtil {
  final String host;

  UriUtil({required this.host});

  Uri getRegisterUri() {
    return Uri.parse("$host/users/v1/register");
  }

  Uri getOAuth1TokenWithEmailUri() {
    return Uri.parse("$host/auth/v2/oauth1/tokens");
  }

  Uri getGeneralConfigurationUri() {
    return Uri.parse("$host/configurations/v2/general");
  }

  Uri getUserConfigurationUri(String userId) {
    return Uri.parse("$host/configurations/v2/users/$userId");
  }

  Uri getPrescriptionUri(String hash) {
    return Uri.parse("$host/prescriptions/v1/$hash");
  }

  Uri getDocumentsUri(String userId) {
    return Uri.parse("$host/data/v1/feature-algo/documents/?eq(data.userId,$userId)");
  }

  Uri updateUserProfileUri(String userId) {
    return Uri.parse("$host/profiles/v1/?id=$userId");
  }

  Uri postMeasurementsUri() {
    return Uri.parse("$host/data/v1/fibricheck-measurements/documents");
  }

  Uri updateMeasurementContextUri(String measurementId) {
    return Uri.parse("$host/data/v1/fibricheck-measurements/documents/$measurementId");
  }

  Uri getMeasurementsUri(String userId, bool newestFirst) {
    var uriString = "$host/data/v1/fibricheck-measurements/documents?eq(creatorId,$userId)&limit(20,0)";

    if (newestFirst) uriString += "&sort(-id)";

    var uri = Uri.parse(uriString);
    return uri;
  }

  Uri getNextMeasurementsUri(String userId, paged_result.Page page, bool newestFirst) {
    var uriString = "$host/data/v1/fibricheck-measurements/documents/?eq(creatorId,$userId)&limit(20,${page.offset + 20})";

    if (newestFirst) uriString += "&sort(-id)";

    var uri = Uri.parse(uriString);
    return uri;
  }

  Uri getPreviousMeasurementsUri(String userId, paged_result.Page page, bool newestFirst) {
    var uriString = "$host/data/v1/fibricheck-measurements/documents/?eq(creatorId,$userId)&limit(20,${page.offset - 20})";

    if (newestFirst) uriString += "&sort(-id)";

    var uri = Uri.parse(uriString);
    return uri;
  }

  Uri getPeriodicReportPdfUri(String reportId, String language) {
    return Uri.parse("$host/reports/v1/$reportId/pdf/$language");
  }

  Uri getPeriodicReportsUri(String userId, bool newestFirst) {
    var uriString = "$host/reports/v1/?eq(user_id,$userId)&out(trigger,MANUAL)&eq(status,COMPLETE)&limit(20,0)";

    if (newestFirst) uriString += "&sort(-creation_timestamp)";

    var uri = Uri.parse(uriString);
    return uri;
  }

  Uri getNextPeriodicReportsUri(String userId, paged_result.Page page, bool newestFirst) {
    var uriString = "$host/reports/v1/?eq(user_id,$userId)&out(trigger,MANUAL)&eq(status,COMPLETE)&limit(20,${page.offset + 20})";

    if (newestFirst) uriString += "&sort(-creation_timestamp)";

    var uri = Uri.parse(uriString);
    return uri;
  }

  Uri getPreviousPeriodicReportsUri(String userId, paged_result.Page page, bool newestFirst) {
    var uriString = "$host/reports/v1/?eq(user_id,$userId)&out(trigger,MANUAL)&eq(status,COMPLETE)&limit(20,${page.offset - 20})";

    if (newestFirst) uriString += "&sort(-creation_timestamp)";

    var uri = Uri.parse(uriString);
    return uri;
  }

  Uri getMeasurementReportUrlUri(String measurementId) {
    return Uri.parse("$host/data/v1/measurement-reports/documents/?data.measurementId=$measurementId&sort(-id)");
  }

  Uri createMeasurementReportUri(String measurementId) {
    return Uri.parse("$host/data/v1/measurement-reports/documents/?data.measurementId=$measurementId");
  }

  Uri deleteMeasurementReport(String measurementReportId) {
    return Uri.parse("$host/data/v1/measurement-reports/documents/$measurementReportId");
  }

  Uri activatePrescriptionUri(String hash) {
    return Uri.parse("$host/prescriptions/v1/$hash/activate");
  }

  Uri linkPrescriptionUri(String hash) {
    return Uri.parse("$host/prescriptions/v1/$hash/scan");
  }

  Uri getMeUri() {
    return Uri.parse("$host/users/v1/me");
  }

  Uri getGetMeasurementUri(String id) {
    return Uri.parse("$host/data/v1/fibricheck-measurements/documents/?id=$id");
  }

  Uri getFetchMeasurementReportUri(String id) {
    return Uri.parse("$host/data/v1/measurement-reports/documents/?id=$id");
  }
}
