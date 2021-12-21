// import 'dart:async';
// import 'dart:convert' show json;
// import 'dart:developer';
//
// import 'package:followyou_test/app/libraries/connectivity.dart';
// import 'package:http/http.dart' as http;
//
// class Network {
//   /// Fetch generic data through REST API
//   static Future<Response> execute(Request request) async {
//     log('Call to ${request.url}');
//
//     // Start timer
//     Timer timer = Timer(
//       const Duration(seconds: 10),
//       () => throw 'NetworkException: time out',
//     );
//
//     // Check internet connection
//     if (!Connectivity.instance.isConnected) {
//       timer.cancel();
//       throw 'NetworkException: no connection';
//     }
//
//     late final http.Response response;
//     switch (request.method) {
//       case 'POST':
//         response = await http.post(request.url,
//             headers: request.headers, body: request.body);
//         break;
//       case 'GET':
//         response = await http.get(request.url, headers: request.headers);
//         break;
//       case 'DELETE':
//         response = await http.delete(request.url, headers: request.headers);
//         break;
//       case 'PATCH':
//         response = await http.patch(request.url,
//             headers: request.headers, body: request.body);
//         break;
//       default:
//         throw 'NetworkException: unrecognized request method \'${request.method}\'';
//     }
//
//     // Stop timer
//     timer.cancel();
//
//     // Check response
//     if (response.statusCode != 200)
//       throw 'NetworkException: bad response\n$response';
//
//     return Response(
//         code: response.statusCode,
//         headers: response.headers,
//         body: json.decode(response.body));
//   }
// }
//
// class Request {
//   final String method;
//   final Uri url;
//
//   Map<String, String>? headers;
//   final Map<String, dynamic>? body;
//
//   Request.get({required this.url, String? query, this.headers})
//       : method = 'GET',
//         body = null;
//
//   Request.post({required this.url, this.headers, this.body}) : method = 'POST' {
//     if (body != null) {
//       headers ??= {};
//       headers!['Content-Type'] = 'application/json; charset=UTF-8';
//     }
//   }
//
//   Request.patch({required this.url, this.headers, this.body})
//       : method = 'PATCH';
//
//   Request.delete({required this.url, this.headers, this.body})
//       : method = 'DELETE';
// }
//
// class Response {
//   final int code;
//
//   final Map<String, String> headers;
//   final Map<String, dynamic>? body;
//
//   Response({required this.code, required this.headers, this.body});
// }
