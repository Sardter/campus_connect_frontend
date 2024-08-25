import 'dart:typed_data';

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

bool ifNullThenFalseElse(bool? item) {
  return item != null && item;
}

Iterable<T> uniqueBy<T, V>(Iterable<T> items, V Function(T) attr) {
  var uniqueItemsMap = <V, T>{};

  for (var item in items) {
    var value = attr(item); // Extract value of the attribute
    if (!uniqueItemsMap.containsKey(value)) {
      // Check for uniqueness
      uniqueItemsMap[value] = item;
    }
  }

  return uniqueItemsMap.values;
}

String dateTimeToStr(DateTime date) {
  final min =
      '${date.minute}'.length == 1 ? '0${date.minute}' : '${date.minute}';
  final hour = '${date.hour}'.length == 1 ? '0${date.hour}' : '${date.hour}';
  return '${date.day}/${date.month}/${date.year}, $hour:$min';
}

Future<dynamic> launchPage<T>(BuildContext context, Widget page) async {
  try {
    return await Navigator.push<T>(
        context, MaterialPageRoute(builder: (context) => page));
  } catch (e) {
    return null;
  }
}

void closePage(BuildContext context, {dynamic result}) {
  try {
    Navigator.pop(context, result);
  } catch (e) {
    print(e.toString());
  }
}

String getShortNumber(var number) {
  return NumberFormat.compact(locale: "tr_TR").format(number);
}

String getPriceString(Decimal price) {
  return NumberFormat("#,##0.00", "tr_TR").format(price.toDouble());
}

double getResponsiveMarginWidth(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  const width = 500;

  return !kIsWeb ? 10 : screenWidth > width ? (screenWidth - width) / 2 : 0;
}

List<Widget> withDividers<T>(List<T> items, BuildContext context,
    Widget Function(T item, int index) builder) {
  if (items.isEmpty) return [];
  final widgets = List<Widget>.filled((items.length * 2) - 1, const SizedBox());
  final indentation = getResponsiveMarginWidth(context);

  int k = 0;
  for (var i = 0; i < widgets.length; i++) {
    if (i % 2 != 0) {
      widgets[i] = Divider(indent: indentation, endIndent: indentation);
    } else {
      widgets[i] = builder(items[k], k++);
    }
  }

  return widgets;
}

Map<String, String> mimeTypesToExtension = {
  'image/jpeg': '.jpg',
  'image/png': '.png',
};

String? getFileExtension(Uint8List fileData) {
  String? mimeType = lookupMimeType('', headerBytes: fileData);
  return mimeType == null ? null : mimeTypesToExtension[mimeType];
}
