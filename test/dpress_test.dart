import 'package:dpress/dpress.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  group('A group of tests', () {
    final app = Dpress(port: 8080, address: "localhost");

    setUp(() {
      app.start();
    });

    test('access to "/" => "Hello, /!"', () async {
      app.get("/", (request, response) {
        response.send("Hello, /!");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Hello, /!");
      client.close();
    });

    test('access to "/a" => "Hello, /a!"', () async {
      app.get("/a", (request, response) {
        response.send("Hello, /a!");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/a'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Hello, /a!");
      client.close();
    });

    test('access to "/hello" with GET => "Hello, World!"', () async {
      app.get("/hello", (request, response) {
        response.send("Hello, World!");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/hello'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Hello, World!");
      client.close();
    });

    test('access to "/hello" with POST => "Hello, POST!"', () async {
      app.post("/hello", (request, response) {
        response.send("Hello, POST!");
      });

      final client = HttpClient();
      final request = await client.postUrl(Uri.parse('http://localhost:8080/hello'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Hello, POST!");
      client.close();
    });

    test('access to "/put_test" with PUT => "Hello, PUT!"', () async {
      app.put("/put_test", (request, response) {
        response.send("Hello, PUT!");
      });

      final client = HttpClient();
      final request = await client.putUrl(Uri.parse('http://localhost:8080/put_test'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Hello, PUT!");
      client.close();
    });

    test('access to "/delete_test" with DELETE => "Deleted!"', () async {
      app.delete("/delete_test", (request, response) {
        response.send("Deleted!");
      });

      final client = HttpClient();
      final request = await client.deleteUrl(Uri.parse('http://localhost:8080/delete_test'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Deleted!");
      client.close();
    });

    test('access to "/patch_test" with PATCH => "Patched!"', () async {
      app.patch("/patch_test", (request, response) {
        response.send("Patched!");
      });

      final client = HttpClient();
      final request = await client.openUrl('PATCH', Uri.parse('http://localhost:8080/patch_test'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Patched!");
      client.close();
    });

    test('access to "/method_test" with unsupported method => 404 Not Found', () async {
      app.get("/method_test", (request, response) {
        response.send("GET Method");
      });

      final client = HttpClient();
      final request = await client.postUrl(Uri.parse('http://localhost:8080/method_test'));
      final response = await request.close();

      expect(response.statusCode, HttpStatus.notFound);
      client.close();
    });

    test('access to undefined route => 404 Not Found', () async {
      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/undefined_route'));
      final response = await request.close();

      expect(response.statusCode, HttpStatus.notFound);
      client.close();
    });

    test('concurrent requests to "/" => "Hello, /!"', () async {
      app.get("/", (request, response) {
        response.send("Hello, /!");
      });

      final client = HttpClient();

      // Send multiple requests concurrently
      var futures = List.generate(10, (_) async {
        final request = await client.getUrl(Uri.parse('http://localhost:8080/'));
        final response = await request.close();
        final responseBody = await response.transform(utf8.decoder).join();
        expect(responseBody, "Hello, /!");
      });

      await Future.wait(futures);
      client.close();
    });

    test('route overriding test', () async {
      app.get("/override_test", (request, response) {
        response.send("First Handler");
      });

      // Override the route handler
      app.get("/override_test", (request, response) {
        response.send("Second Handler");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/override_test'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Second Handler");
      client.close();
    });

    test('access to "/query_test?param=value" with GET => "param=value"', () async {
      app.get("/query_test", (request, response) {
        final param = request.uri.queryParameters['param'];
        response.send('param=$param');
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/query_test?param=value'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "param=value");
      client.close();
    });

    test('access to "/special/çãø" => "Special Characters"', () async {
      app.get("/special/çãø", (request, response) {
        response.send("Special Characters");
      });

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse('http://localhost:8080/special/%C3%A7%C3%A3%C3%B8'));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      expect(responseBody, "Special Characters");
      client.close();
    });

    test('server binds to correct address and port', () async {
      expect(app.port, 8080);
      expect(app.address, "localhost");
    });
  });
}