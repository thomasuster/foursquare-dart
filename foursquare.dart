#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('oauth2.dart', prefix:'oauth2');
#import('uri.dart');

#source('users.dart');
#source('venues.dart');
#source('checkins.dart');

class Foursquare {
  RequestFactory _requestFactory;
  String _clientId;

  Foursquare(String clientId) {
    this._requestFactory = new RequestFactory(clientId);
    this._clientId = clientId;
  }

  Foursquare.forUserlessRequests(String clientId, String clientSecret) {
    this._requestFactory = new RequestFactory(clientId, clientSecret);
    this._clientId = clientId;
  }

  Future<Dynamic> login(String redirectUri) {
    Completer<Dynamic> c = new Completer<Dynamic>();

    oauth2.AuthRequest req = new oauth2.AuthRequest(
        'https://foursquare.com/oauth2/authenticate', _clientId, redirectUri);
    Future<String> future = oauth2.login(req);
    future.then((String accessToken) {
      this.accessToken = accessToken;
      c.complete(null);
    });
    future.handleException((Exception e) => c.completeException(e));

    return c.future;
  }

  String get accessToken() => this._requestFactory._accessToken;
         set accessToken(value) => this._requestFactory._accessToken = value;

  RequestFactory get requestFactory() => this._requestFactory;

  Users _users;
  Users get users() {
    if (_users == null) _users = new Users(_requestFactory);
    return _users;
  }

  Venues _venues;
  Venues get venues() {
    if (_venues == null) _venues = new Venues(_requestFactory);
    return _venues;
  }

  Checkins _checkins;
  Checkins get checkins() {
    if (_checkins == null) _checkins = new Checkins(_requestFactory);
    return _checkins;
  }
}

Map<String, String> _combine(Map<String, String> first,
    Map<String, String> second) {
  if (first.isEmpty()) {
    return second;
  } else if (second.isEmpty()) {
    return first;
  }
  Map<String, String> m = new Map();
  first.forEach((String k, String v) {
    m[k] = v;
  });
  second.forEach((String k, String v) {
    m[k] = v;
  });
  return m;
}

class RequestFactory {
  final String _API_ENDPOINT = 'https://api.foursquare.com/v2';
  String version = '20120502';
  String _accessToken;

  String _clientId;
  String _clientSecret;

  RequestFactory(String clientId, [String clientSecret]) {
    this._clientId = clientId;
    this._clientSecret = clientSecret;
  }

  Request build(String method, String path, [Map<String, String> params]) {
    String url = '$_API_ENDPOINT/$path?${_paramsStr(params)}';
    return new Request(method, url);
  }

  String _paramsStr(Map<String, String> params) {
    List<String> parts = new List.from(['v=$version']);
    if (_accessToken != null) {
      parts.add('oauth_token=$_accessToken');
    } else {
      // Userless access
      parts.addAll(['client_id=$_clientId', 'client_secret=$_clientSecret']);
    }
    if (params != null) {
      params.forEach((String key, String val) {
        parts.add('$key=${encodeURIComponent(val)}');
      });
    }
    return Strings.join(parts, '&');
  }
}

class Request {

  final String _method;
  final String _url;

  Request(this._method, this._url);

  Future<Map> execute() {

    final completer = new Completer();
    XMLHttpRequest xhr = new XMLHttpRequest();
    xhr.open(_method, _url, true, null, null);

    xhr.on.error.add((Event e) {
      completer.completeException(new NetworkException());
    });
    xhr.on.loadEnd.add((Event e) {
      if (xhr.status >= 400) {
        completer.completeException(new HttpException(xhr.status));
      } else {
        completer.complete(JSON.parse(xhr.responseText));
      }
    });
    xhr.send();

    return completer.future;
  }
}

class NetworkException implements Exception {
  NetworkException();
}

class HttpException implements Exception {
  int code;
  HttpException(int this.code);
}