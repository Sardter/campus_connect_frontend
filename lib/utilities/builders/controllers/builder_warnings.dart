import 'package:campus_connect_frontend/utilities/builders/builders.dart';

class BuilderWarningsController {
  List<BuilderWarning> warnings = [];
  void Function(String errorMessage)? onError;
}
