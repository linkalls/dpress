import 'package:dpress/dpress.dart';
import 'package:test/test.dart' as test;
import 'dart:io';
import 'dart:convert';

void main() {
  test.group('A group of tests', () {
    final app = Dpress(port: 8080, address: "localhost");

    test.setUp(() {
      app.start();
    });

    

    test.test('access to "/" => "Hello, /!"', () async {
      app.get("/", (request, response) {
        response.send("Hello, /!");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      test.expect(responseBody, "Hello, /!");
      client.close();
    });

    test.test('access to "/a" => "Hello, /a!"', () async {
      app.get("/a", (request, response) {
        response.send("Hello, /a!");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/a'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      test.expect(responseBody, "Hello, /a!");
      client.close();
    });

    test.test('access to "/hello" with GET => "Hello, World!"', () async {
      app.get("/hello", (request, response) {
        response.send("Hello, World!");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/hello'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      test.expect(responseBody, "Hello, World!");
      client.close();
    });

    test.test('access to "/hello" with POST => "Hello, POST!"', () async {
      app.post("/hello", (request, response) {
        response.send("Hello, POST!");
      });

      final client = HttpClient();
      final request = await client.postUrl(Uri.parse('http://localhost:8080/hello'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      test.expect(responseBody, "Hello, POST!");
      client.close();
    });
  });
}