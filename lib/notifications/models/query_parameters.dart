import 'package:campus_connect_frontend/notifications/models/notification.dart';
import 'package:campus_connect_frontend/utilities/filters/filters.dart';

class NotificationQueryParameters extends QueryParameters<NotificationModel> {
  final bool? seen;
  final String? order;

  const NotificationQueryParameters({
    super.searchQuery,
    this.seen,
    this.order = "-created_at",
    super.sorted = true,
  });

  @override
  List<String?> get fieldsToStr => [
        fieldStringify<bool>(seen, (field) => "read=$field"),
        fieldStringify(order, (field) => "order_by=$field"),
      ];
}
