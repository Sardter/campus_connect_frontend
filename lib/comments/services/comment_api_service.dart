import 'package:campus_connect_frontend/auth/services/auth.dart';
import 'package:campus_connect_frontend/comments/comments.dart';
import 'package:campus_connect_frontend/config/url_manager.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class CommentAPIService extends HideAndReportableAPIModelService<Comment>
    implements CommentService {
  Future<Map<String, dynamic>?> _favorite({required ItemParameters itemParameters}) async {
    return await api.actionAndGetResponseItems(
        url: "https://api.campusconnect.yuiozasx.com/likes/",
        authService: authService,
        body: {
          'item': itemParameters.id,
          'type': 'Comment'
        },
        action: APIAction.post);
  }

  @override
  APIService get api => APIServiceFactory.SERVICE;

  @override
  AuthService get authService => APIAuthServiceFactory.SERVICE;

  @override
  ModelFactory<Comment> get modelFactory => CommentFactory();

  @override
  String get modelType => "comment";

  @override
  String get url => URLManager.comments;

  @override
  Future<bool?> favorite({required ItemParameters itemParameters}) async {
    return (await _favorite(itemParameters: itemParameters)) != null;
  }
}
