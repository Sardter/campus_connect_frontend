abstract class BuilderSegmentController<T> {
  bool get isValid => errorMesseges.isEmpty;

  T? get data;

  List<String> get errorMesseges;
}