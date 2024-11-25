

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
  dpress: ^0.0.2+alphaAlpha
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

## `/time` エンドポイント パフォーマンス比較: Express vs Dpress

以下は、`express` と自作の `dpress` を使用して `/time` エンドポイントにアクセスした際の負荷テスト結果です。

### テスト条件

- **ツール:** [bombardier](https://github.com/codesenberg/bombardier)
- **テスト時間:** 10秒
- **接続数:** 100
- **エンドポイント:**
  - `/time`  
    - Express: `res.send(new Date().toString())`
    - Dpress: `res.send(DateTime.now().toString())`

---

## 比較表

| 項目                   | Express                | Dpress                 |
|------------------------|------------------------|------------------------|
| 平均リクエスト数       | 8358.69 req/sec        | 18535.88 req/sec       |
| 最大リクエスト数       | 10394.91 req/sec       | 23523.05 req/sec       |
| 平均レイテンシー       | 11.96ms               | 5.39ms                |
| 最大レイテンシー       | 353.99ms              | 59.01ms               |
| HTTP 2xx レスポンス数  | 83654                 | 185379                |
| スループット           | 2.70MB/s              | 5.06MB/s              |

---

## 考察

1. **リクエスト処理能力**  
   Dpress は Express の **2倍以上のリクエスト処理能力** を持ち、非常に高速で動作しています。

2. **レイテンシー**  
   Dpress のレイテンシーは **約半分以下** で、応答速度が非常に速いです。

3. **成功レスポンス数**  
   同じ時間内での成功リクエスト数も、Dpress のほうが大幅に多いです。

4. **スループット**  
   Dpress のスループット（1秒あたりのデータ転送量）は Express の約 **2倍** です。

---

## 結論

自作の **Dpress** は、`express` よりも軽量かつ高速であることが証明されました。Dart 言語や設計の最適化により、特にリクエスト数やレイテンシーで大きな差を生んでいます。

### テストコマンド

以下のコマンドで再現できます。

#### Express のテスト
```bash
bombardier --fasthttp -d 10s -c 100 http://localhost:3000/time
```

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


以下は、`README.md`の内容を英語に翻訳したものです。


# Dpress

Dpress is a lightweight web framework for Dart, inspired by Express.js.

## Features

- Simple and easy-to-use API
- Fast routing
- Middleware support
- Only includes the minimal APIs that I wanted
- Approximately twice the processing speed of Express

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  dpress: ^0.0.2+alphaAlpha
```

Then run the following command to install the package:

```sh
dart pub get
```

## Usage

Here is a simple server example using Dpress:

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

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Performance Comparison: Express vs Dpress

Below are the results of a load test comparing `express` and the custom `dpress` using the load testing tool **bombardier**.

### Test Conditions

- **Tool:** [bombardier](https://github.com/codesenberg/bombardier)
- **Test Duration:** 10 seconds
- **Connections:** 100
- **Test Targets:**
  - Express (port 3000)
  - Dpress (port 8080)

---

## Comparison Table

| Item                  | Express                | Dpress                 |
|-----------------------|------------------------|------------------------|
| Average Requests/sec  | 4873.74 req/sec        | 9734.84 req/sec        |
| Max Requests/sec      | 6396.91 req/sec        | 16017.30 req/sec       |
| Average Latency       | 20.51ms                | 10.27ms                |
| Max Latency           | 305.82ms               | 34.11ms                |
| HTTP 2xx Responses    | 48798                  | 97412                  |
| Throughput            | 1.44MB/s               | 2.57MB/s               |

---

## Considerations

1. **Request Handling Capacity**  
   Dpress can handle approximately **twice the number of requests** as Express, with higher throughput.

2. **Latency**  
   Dpress has faster response times and lower latency compared to Express.

3. **Successful Responses**  
   Dpress has a higher number of successful requests during the test period.

---

## `/time` Endpoint Performance Comparison: Express vs Dpress

Below are the results of a load test on the `/time` endpoint using `express` and the custom `dpress`.

### Test Conditions

- **Tool:** [bombardier](https://github.com/codesenberg/bombardier)
- **Test Duration:** 10 seconds
- **Connections:** 100
- **Endpoint:**
  - `/time`  
    - Express: `res.send(new Date().toString())`
    - Dpress: `res.send(DateTime.now().toString())`

---

## Comparison Table

| Item                  | Express                | Dpress                 |
|-----------------------|------------------------|------------------------|
| Average Requests/sec  | 8358.69 req/sec        | 18535.88 req/sec       |
| Max Requests/sec      | 10394.91 req/sec       | 23523.05 req/sec       |
| Average Latency       | 11.96ms                | 5.39ms                 |
| Max Latency           | 353.99ms               | 59.01ms                |
| HTTP 2xx Responses    | 83654                  | 185379                 |
| Throughput            | 2.70MB/s               | 5.06MB/s               |

---

## Considerations

1. **Request Handling Capacity**  
   Dpress has **more than twice the request handling capacity** of Express, operating at very high speed.

2. **Latency**  
   Dpress has **less than half the latency**, with very fast response times.

3. **Successful Responses**  
   Dpress has a significantly higher number of successful requests within the same time period.

4. **Throughput**  
   Dpress's throughput (data transfer rate per second) is about **twice** that of Express.

---

## Conclusion

The custom **Dpress** has proven to be lighter and faster than `express`. The design optimizations and the Dart language contribute to significant differences, especially in request count and latency.

### Test Commands

You can reproduce the tests with the following commands.

#### Express Test
```bash
bombardier --fasthttp -d 10s -c 100 http://localhost:3000/
```

#### Dpress Test
```bash
bombardier --fasthttp -d 10s -c 100 http://localhost:8080/
```

---

