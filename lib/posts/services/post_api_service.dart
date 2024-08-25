import 'package:campus_connect_frontend/posts/posts.dart';
import 'package:campus_connect_frontend/utilities/services/hide_and_reportable_api_model_service.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

abstract class PostAPIService<T extends Post>
    extends HideAndReportableAPIModelService<T> implements PostService<T> {

  Future<Map<String, dynamic>?> _favorite({required ItemParameters post}) async {
    return await api.actionAndGetResponseItems(
        url: "https://api.campusconnect.yuiozasx.com/likes/",
        authService: authService,
        body: {
          'item': post.id,
          'type': 'Post'
        },
        action: APIAction.post);
  }

  @override
  Future<bool?> favorite({required ItemParameters post}) async {
    return (await _favorite(post: post)) != null;
  }
}
