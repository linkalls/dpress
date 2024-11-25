

# Dpress

Dpressは、Dart用の軽量なWebフレームワークで、Express.jsに触発されています。

## 特徴

- シンプルで使いやすいAPI
- 高速なルーティング
- ミドルウェアのサポート

## インストール

`pubspec.yaml`に以下を追加してください。

```yaml
dependencies:
  dpress: ^0.0.1+alpha
```

その後、以下のコマンドを実行してパッケージをインストールします。

```sh
dart pub get
```

## 使い方

以下は、Dpressを使った簡単なサーバーの例です。

```dart
import 'package:dpress/dpress.dart';

void main() async {
  final app = Dpress();

  app.get("/", (DpressRequest request, DpressResponse response) {
    response.send("Hello, /!");
  });

  app.get("/a", (DpressRequest request, DpressResponse response) {
    response.send("Hello, /a!");
  });

  app.get("/hello", (DpressRequest request, DpressResponse response) {
    response.send("Hello, World!");
  });

  app.post("/hello", (DpressRequest request, DpressResponse response) {
    response.send("Hello, POST!");
  });

  await app.start();
}
```

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は`LICENSE`ファイルを参照してください。
```



README.md

を更新した後、再度`dart pub publish`を実行してパッケージを公開してください。

```sh
dart pub publish
```