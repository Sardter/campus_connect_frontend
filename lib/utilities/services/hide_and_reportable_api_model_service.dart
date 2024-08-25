import 'package:campus_connect_frontend/utilities/utilities.dart';

abstract class HideAndReportableAPIModelService<T extends Model>
    extends APIModelService<T> {
  Future<Map<String, dynamic>?> _hideItem({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: "https://api.campusconnect.yuiozasx.com/hides/",
        authService: authService,
        body: {
          'item': itemParameters.id,
          'type': modelType
        },
        action: APIAction.post);
  }

  Future<Map?> _reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return await api.actionAndGetResponseItems(
        url: "https://api.campusconnect.yuiozasx.com/reports/",
        authService: authService,
        body: {
          'item': itemParameters.id,
          'type': modelType,
          'content': reason
        },
        action: APIAction.post);
  }

  @override
  Future<bool?> hideItem({required ItemParameters itemParameters}) async {
    return (await _hideItem(itemParameters: itemParameters)) != null;
  }

  @override
  Future<bool?> reportItem(
      {required ItemParameters itemParameters, required String reason}) async {
    return (await _reportItem(
        itemParameters: itemParameters, reason: reason)) != null;
  }
}
