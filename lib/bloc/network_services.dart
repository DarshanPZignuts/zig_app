import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  NetworkService();

  String authToken = '';

  setToken(String token) {
    authToken = token;
  }

  Future<http.Response?> post(
    String endpoint,
    Map<String, dynamic>? body,
    bool isformdata,
  ) async {
    print(endpoint);
    final jsonString = json.encode(body);
    final response = await http.post(Uri.parse(endpoint),
        headers: getHeader(), body: jsonString);
    return response;
  }

  Future<http.Response?> put(
      String endpoint, Map<String, dynamic>? body) async {
    print(endpoint);
    final jsonString = json.encode(body);
    final response = await http
        .put(Uri.parse(endpoint), headers: getHeader(), body: jsonString)
        .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response?> patch(
    String endpoint,
    Map<String, dynamic>? body,
    bool isformdata,
  ) async {
    print(endpoint);
    final jsonString = json.encode(body);
    final response = await http
        .patch(Uri.parse(endpoint), headers: getHeader(), body: jsonString)
        .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response?> get(
    String endpoint,
    Map<String, String>? body,
  ) async {
    String queryString = Uri(queryParameters: body).query;
    final response = await http
        .get(
          Uri.parse(endpoint + "?" + queryString),
          headers: getHeader(),
        )
        .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response?> delete(
    String endpoint,
    Map<String, String>? body,
  ) async {
    print(endpoint);
    String queryString = Uri(queryParameters: body).query;

    final response = await http
        .delete(
          Uri.parse(endpoint + "?" + queryString),
          headers: getHeader(),
        )
        .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response?> deleteWithBody(
    String endpoint,
    Map<String, dynamic>? body,
  ) async {
    print(endpoint);
    final jsonString = json.encode(body);
    final response = await http
        .delete(Uri.parse(endpoint), headers: getHeader(), body: jsonString)
        .timeout(const Duration(seconds: 60));
    return response;
  }

  Future<http.Response?> postWithForm(
    String endpoint,
    Map<String, String>? body,
    bool isformdata,
  ) async {
    print(endpoint);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        endpoint,
      ),
    );
    request.fields.addAll(body!);
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    return response;
  }

  getHeader() {
    var map = <String, String>{};
    map['Content-Type'] = 'application/json';
    if (authToken != null && authToken.isNotEmpty) {
      map['Authorization'] = authToken;
    } else {
      print('Authorization is failed');
    }
    return map;
  }

  getHeaderMultiPart() {
    var map = <String, String>{};
    map['Content-Type'] = 'multipart/form-data';
    return map;
  }
}
