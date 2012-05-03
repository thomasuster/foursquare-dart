#library('HTTP utilities');

#import('dart:html');
#import('dart:json');
#import('dart:uri');
#import('uri.dart');

class HttpRequest {
  String method;
  Uri uri;
  Map<String, String> headers;

  HttpRequest(String this.method, Uri this.uri,
      [Map<String, String> this.headers]);

  Future<Map> execute([String body]) {
    Completer<Map> completer = new Completer<Map>();
    XMLHttpRequest xhr = new XMLHttpRequest();
    xhr.open(method, uri.toString());

    this.headers.forEach((k, v) => xhr.setRequestHeader(k, v));

    xhr.on.error.add((Event e) {
      completer.completeException(new HttpException());
    });
    xhr.on.loadEnd.add((Event e) {
      if (xhr.status >= 400) {
        completer.completeException(new HttpException(xhr.status));
      } else {
        // TODO: Return an HttpResponse instead of JSON parsing by default.
        completer.complete(JSON.parse(xhr.responseText));
      }
    });
    xhr.send(body);

    return completer.future;
  }
}

class HttpException implements Exception {
  int code;
  HttpException([int this.code]);
}

String toParamsString(Map<String, String> params) {
  if (params == null) return '';
  List<String> parts = new List<String>();
  params.forEach((String key, String val) {
    parts.add('$key=${encodeURIComponent(val)}');
  });
  return '?' + Strings.join(parts, '&');
}