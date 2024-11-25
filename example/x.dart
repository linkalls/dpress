import "package:dpress/dpress.dart";

void main() {
  final app = Dpress(port: 3000);
  app.get("/", (req, res) => res.send("Hello, Worldだよ！"));
  app.get("/json", (req, res) {
    final data = {"message": "Hello, JSON!"};
    res.json(data);
  });
  app.start();
}