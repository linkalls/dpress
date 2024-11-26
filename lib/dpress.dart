library;

export 'src/dpress_base.dart';

import 'dart:io';
import 'src/dpress_base.dart';

typedef RouteHandler = void Function(DpressRequest, DpressResponse);

class Dpress {
  Dpress({this.port = 8080, this.address = "localhost"});

  final int port;
  final String address;

  // final Map<String, Map<String, RouteHandler>> _routes = {};

  final RouteNode _root = RouteNode();

  void addRoute(String path, String method,
      void Function(DpressRequest, DpressResponse) handler) {
    // パスを "/" で分割
    final segments = path.split('/').where((segment) => segment.isNotEmpty);

    var current = _root;
    // print(_root);

    for (final segment in segments) {
      if (segment.startsWith(':')) {
        // 動的セグメントの場合
        final dynamicName = segment.substring(1); // ":id" → "id"
        // substringは引数に指定したインデックスから最後までを取得する(今回は1から最後まで)
        current.dynamicChild ??= RouteNode();
        current.dynamicChild!.dynamicSegmentName = dynamicName;
        current = current.dynamicChild!;
      } else {
        // 静的セグメントの場合
        current = current.children.putIfAbsent(segment, () => RouteNode());
      }
    }

    // 最後のノードにハンドラーを登録
    current.handlers[method] = handler;
  }

  void get(String path, RouteHandler handler) {
    addRoute(path, "GET", handler);
  }

  void delete(String path, RouteHandler handler) {
    addRoute(path, "DELETE", handler);
  }

  void post(String path, RouteHandler handler) {
    addRoute(path, "POST", handler);
  }

  void put(String path, RouteHandler handler) {
    addRoute(path, "PUT", handler);
  }

  void patch(String path, RouteHandler handler) {
    addRoute(path, "PATCH", handler);
  }

  void _handleRequest(HttpRequest request) async {
    final pathSegments =
        request.uri.path.split('/').where((segment) => segment.isNotEmpty);
    final method = request.method;
    var current = _root;

    // 動的ルートのパラメータを保存するマップ
    final parameters = <String, String>{};

    for (final segment in pathSegments) {
      if (current.children.containsKey(segment)) {
        // 静的ルートの一致
        current = current.children[segment]!;
      } else if (current.dynamicChild != null) {
        // 動的ルートの一致
        final dynamicChild = current.dynamicChild!;
        parameters[dynamicChild.dynamicSegmentName!] = segment;
        current = dynamicChild;
      } else {
        _sendNotFound(request);
        return;
      }
    }

    // HTTPメソッドに対応するハンドラーを実行
    final handler = current.handlers[method];
    if (handler != null) {
      final dpressRequest = DpressRequest(request, parameters: parameters);
      final dpressResponse = DpressResponse(request.response);
      handler(dpressRequest, dpressResponse);
    } else {
      _sendNotFound(request);
    }
  }

  void _sendNotFound(HttpRequest request) {
    final dpressResponse = DpressResponse(request.response);
    dpressResponse.statusCode = HttpStatus.notFound;
    dpressResponse.send("404 Not Found");
  }

  Future<void> start() async {
    try {
      final server = await HttpServer.bind(address, port, shared: true);
      print("Server started on http://$address:$port");
      await for (HttpRequest request in server) {
        _handleRequest(request);
      }
    } catch (e) {
      print(e);
    }
  }
}
