import 'package:dpress/dpress.dart';

void main() async {
  final app = Dpress();

  // app.addRoute("/", "GET", (DpressRequest request, DpressResponse response) {
  //   response.send("Hello, /!");
  // });

  app.get("/", (req, res) => res.json({"time": DateTime.now().toString()}));

  app.get("/a", (DpressRequest request, DpressResponse response) {
    response.send("Hello, /a!");
  });

  app.addRoute("/hello", "GET",
      (DpressRequest request, DpressResponse response) {
    response.send("Hello, World!");
  });

  app.addRoute("/hello", "POST",
      (DpressRequest request, DpressResponse response) {
    response.send("Hello, POST!");
  });

  await app.start();
}
