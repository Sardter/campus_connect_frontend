abstract class Model {
  final dynamic id;

  const Model({required this.id});

  @override
  bool operator ==(Object other) => other is Model && id == other.id;

  Map<String, dynamic> toJson();

  @override
  int get hashCode => id.runtimeType == int
      ? id * runtimeType.hashCode
      : (id as String) * runtimeType.hashCode;
}

abstract class ModelFactory<T extends Model> {
  T fromJson(Map<String, dynamic> json);
}
