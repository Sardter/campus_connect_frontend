import 'package:campus_connect_frontend/items/models/item.dart';
import 'package:campus_connect_frontend/utilities/utilities.dart';

class ItemFactory extends ModelFactory<Item> {
  @override
  Item fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['item']);
  }
}
