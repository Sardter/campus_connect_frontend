import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class FileService {
  static Future<void> postFile(String url, Uint8List file, String type,
      String extention, Map<String, dynamic> fields) async {
    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..fields.addAll(fields.cast<String, String>())
      ..files.add(http.MultipartFile.fromBytes('file', file,
          filename: 'önemsiz', contentType: MediaType(type, extention)));

    // Send the HTTP request
    final response = await request.send();
    print("file response: $response");
    print("file uploaded: ${response.statusCode}");
  }

  static Future<Uint8List?> getFileContent(String? url) async {
    if (url == null) return null;
    return (await http.get(Uri.parse(url))).bodyBytes;
  }
}
