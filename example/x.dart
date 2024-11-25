import "package:dpress/dpress.dart";

void main() {
  final app = Dpress(port: 3000);
  app.get("/", (req, res) => res.send("Hello, Worldだよ！"));
  app.start();
}