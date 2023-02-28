import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

Future<Uint8List?> getCatData() async {
  http.Response r;
  String url;

  // get url
  r = await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search'));
  if (r.statusCode == 200) {
    url = jsonDecode(r.body)[0]['url'];
  } else {
    return null;
  }

  // get image
  r = await http.get(Uri.parse(url));
  if (r.statusCode == 200) {
    return r.bodyBytes;
  } else {
    return null;
  }
  
}
