import 'dart:io';
import 'dart:convert';

void main() async {
  // サーバーを作成し、localhost:8080でリッスン
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('サーバーが起動しました: ${server.address.address}:${server.port}');

  // リクエストの処理
  await for (HttpRequest request in server) {
    if (request.method == 'GET' && request.uri.path == '/') {
      // レスポンスヘッダーの設定
      request.response.headers.contentType = ContentType.json;
      
      // 現在時刻をJSONとして送信
      final responseData = {
        'time': DateTime.now().toString()
      };
      
      request.response
        ..write(jsonEncode(responseData))
        ..close();
    } else {
      // 404エラー
      request.response
        ..statusCode = HttpStatus.notFound
        ..close();
    }
  }
}