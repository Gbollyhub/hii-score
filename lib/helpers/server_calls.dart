import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<dynamic>? send(data, path) async {
  final url = Uri.parse('${dotenv.env['API_URL']!}/$path');
  try {
    final response = await http.post(url,
        body: json.encode(data), headers: {'Content-Type': 'application/json'});
    return response;
  } catch (error) {
    print(error);
    return error;
  }
}
