library;

export 'src/dpress_base.dart';

import 'dart:io';
import 'src/dpress_base.dart';

typedef HandlerMap = Map<String, Map<String, void Function(DpressRequest, DpressResponse)>>;

class Dpress {
  Dpress({this.port = 8080, this.address = "localhost"});

  final int port;
  final String address;

  final HandlerMap _handlers = {};

  void addRoute(
      String path, String method, void Function(DpressRequest, DpressResponse) handler) {
    if (!_handlers.containsKey(path)) {
      _handlers[path] = {};
    }
    _handlers[path]![method] = handler;
  }

  void get(String path, void Function(DpressRequest, DpressResponse) handler) {
    addRoute(path, "GET", handler);
  }

  void delete(String path, void Function(DpressRequest, DpressResponse) handler) {
    addRoute(path, "DELETE", handler);
  }

  void post(String path, void Function(DpressRequest, DpressResponse) handler) {
    addRoute(path, "POST", handler);
  }

  void put(String path, void Function(DpressRequest, DpressResponse) handler) {
    addRoute(path, "PUT", handler);
  }

  void patch(String path, void Function(DpressRequest, DpressResponse) handler) {
    addRoute(path, "PATCH", handler);
  }

  void _handleRequest(HttpRequest request) async {
    final dpressRequest = DpressRequest(request);
    final dpressResponse = DpressResponse(request.response);

    if (_handlers.containsKey(request.uri.path) &&
        _handlers[request.uri.path]!.containsKey(request.method)) {
      _handlers[request.uri.path]![request.method]!(dpressRequest, dpressResponse);
    } else {
      dpressResponse.statusCode = HttpStatus.notFound;
      dpressResponse.send("404 Not Found");
    }
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