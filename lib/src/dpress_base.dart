import 'dart:io';
import "dart:convert";

class RouteNode {
  // 静的な子ノード
  Map<String, RouteNode> children = {};

  // 動的な子ノード（1つのみ）
  RouteNode? dynamicChild;
  String? dynamicSegmentName;

  // HTTPメソッドに対応する関数
  Map<String, void Function(DpressRequest, DpressResponse)> handlers = {};

  @override
  String toString() {
    return "RouteNode(children: $children, dynamicChild: $dynamicChild, dynamicSegmentName: $dynamicSegmentName, handlers: $handlers)";
  }
}

class DpressRequest {
  final HttpRequest originalRequest;
  final Map<String, String> parameters;

  DpressRequest(this.originalRequest, {this.parameters = const {}});

  Uri get uri => originalRequest.uri;
  String get method => originalRequest.method;
  HttpHeaders get headers => originalRequest.headers;
  Stream<List<int>> get body => originalRequest;

  HttpResponse get response => originalRequest.response;
}

class DpressResponse {
  final HttpResponse _response;

  DpressResponse(this._response);

  void send(Object? obj) {
    _response.write(obj);
    _response.close();
  }

  void json(Map<String, dynamic> obj) {
    _response.headers.contentType = ContentType.json;
    _response.write(jsonEncode(obj));
    _response.close();
  }

  set statusCode(int code) => _response.statusCode = code;
}
