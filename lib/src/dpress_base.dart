import 'dart:io';

class DpressRequest {
  final HttpRequest _request;

  DpressRequest(this._request);

  Uri get uri => _request.uri;
  String get method => _request.method;
  HttpHeaders get headers => _request.headers;
  Stream<List<int>> get body => _request;

  HttpResponse get response => _request.response;
}

class DpressResponse {
  final HttpResponse _response;

  DpressResponse(this._response);

  void send(Object? obj) {
    _response.write(obj);
    _response.close();
  }

  void set statusCode(int code) => _response.statusCode = code;
}