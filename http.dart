#library('HTTP utilities');

#import('dart:html', prefix:'html');
#import('dart:uri');

class HttpRequest {
  String method;
  Uri uri;
  Map<String, String> headers;

  HttpRequest(String this.method, Uri this.uri,
      [Map<String, String> this.headers]);

  Future<HttpResponse> execute([String body]) {
    Completer<HttpResponse> completer = new Completer<HttpResponse>();
    html.HttpRequest xhr = new html.HttpRequest();
    xhr.open(method, uri.toString());

    if (headers != null) {
      headers.forEach((k, v) => xhr.setRequestHeader(k, v));
    }

    xhr.on.error.add((html.Event e) {
      completer.completeException(new HttpException());
    });
    xhr.on.loadEnd.add((html.Event e) {
      if (xhr.status >= 400) {
        completer.completeException(new HttpException(xhr.status));
      } else {
        List<String> headerParts = xhr.getAllResponseHeaders().split('\n');
        var responseHeaders = <String>{};
        headerParts.forEach((String hp) {
          int idx = hp.indexOf(':');
          if (idx < 0) {
            responseHeaders[hp] = null;
          } else {
            String k = hp.substring(0, idx);
            String v = hp.substring(idx + 2);
            responseHeaders[k] = v;
          }
        });
        completer.complete(new HttpResponse(xhr.responseText, responseHeaders));
      }
    });
    xhr.send(body);

    return completer.future;
  }
}

class HttpResponse {
  final String body;
  final Map<String, String> headers;

  HttpResponse(this.body, this.headers);
}

class HttpException implements Exception {
  int code;
  HttpException([int this.code]);
}