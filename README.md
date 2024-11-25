

# Dpress

Dpressは、Dart用の軽量なWebフレームワークで、Express.jsに触発されています。

## 特徴

- シンプルで使いやすいAPI
- 高速なルーティング
- ミドルウェアのサポート
- 必要最低限の僕が欲しいと思ったapiだけを導入
- expressの平均約2倍の処理速度

## インストール

`pubspec.yaml`に以下を追加してください。

```yaml
dependencies:
  dpress: ^0.0.1+gamma
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






## パフォーマンス比較: Express vs Dpress

以下は、`express` と自作の `dpress` を負荷テストツール **bombardier** を使用して比較した結果です。

### テスト条件

- **ツール:** [bombardier](https://github.com/codesenberg/bombardier)
- **テスト時間:** 10秒
- **接続数:** 100
- **テスト対象:**
  - Express (ポート 3000)
  - Dpress (ポート 8080)

---

## 比較表

| 項目                   | Express                | Dpress                 |
|------------------------|------------------------|------------------------|
| 平均リクエスト数       | 4873.74 req/sec        | 9734.84 req/sec        |
| 最大リクエスト数       | 6396.91 req/sec        | 16017.30 req/sec       |
| 平均レイテンシー       | 20.51ms               | 10.27ms               |
| 最大レイテンシー       | 305.82ms              | 34.11ms               |
| HTTP 2xx レスポンス数  | 48798                 | 97412                 |
| スループット           | 1.44MB/s              | 2.57MB/s              |

---

## 考察

1. **リクエスト処理能力**  
   Dpress は Express の約 **2倍のリクエスト** を処理可能であり、より高いスループットを持っています。

2. **レイテンシー**  
   Dpress はレスポンス速度が速く、レイテンシーも Express より低いです。

3. **成功レスポンス数**  
   テスト期間中に成功したリクエスト数でも、Dpress が優れています。

---

## 使用方法

### テストコマンド

以下のコマンドで同様のテストが可能です。

#### Express のテスト
```bash
bombardier --fasthttp -d 10s -c 100 http://localhost:3000/
```

#### Dpress のテスト
```bash
bombardier --fasthttp -d 10s -c 100 http://localhost:8080/
```

---

この結果から、Dpress の設計が非常に効率的であることがわかります。



```sh
dart pub publish
```