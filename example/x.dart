import "package:dpress/dpress.dart";

void main() async {
  final app = Dpress();


app.get("/", (req, res) => res.json({"time": DateTime.now().toString()}));
  // 静的ルート
  app.addRoute("/users", "GET", (req, res) {
    res.send("User list");
  });

  app.get("/dpress",(DpressRequest request, DpressResponse response) {
    response.json({"hello":"dpress"});
  });

  // 動的ルート
  app.addRoute("/users/:id", "GET", (req, res) {
    final userId = req.parameters["id"];
    // res.send("User profile for ID: $userId");
    res.json({"userId": userId});
  });

  app.addRoute("/posts/:postId/comments", "POST", (req, res) {
    final postId = req.parameters["postId"];
    print(postId);
    res.send("Create comment for Post ID: $postId");
  });

  // サーバー開始
  await app.start();
}
