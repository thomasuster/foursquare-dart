#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('dart:uri');
#import('http.dart');
#import('oauth2.dart', prefix:'oauth2');

#source('users.dart');
#source('venues.dart');
#source('checkins.dart');
#source('tips.dart');

final String _AUTH_URL = 'https://foursquare.com/oauth2/authenticate';
final String _API_ENDPOINT = 'https://api.foursquare.com/v2';
String _version = '20120502';
String _accessToken;
String _clientId;
String _clientSecret;

class Foursquare {
  Foursquare(String clientId) {
    _clientId = clientId;
  }

  Foursquare.userless(String clientId, String clientSecret) {
    _clientId = clientId;
    _clientSecret = clientSecret;
  }

  Future<Dynamic> login(String redirectUri) {
    Completer c = new Completer();

    Future f = oauth2.login(_AUTH_URL, _clientId, redirectUri);
    f.handleException((Exception e) => c.completeException(e));
    f.then((token) {
      this.accessToken = token;
      c.complete(null);
    });

    return c.future;
  }

  String get accessToken() => _accessToken;
         set accessToken(value) => _accessToken = value;

  String get version() => _version;
         set version(value) => _version = value;

  Users get users() => new Users();
  Venues get venues() => new Venues();
  Checkins get checkins() => new Checkins();
  Tips get tips() => new Tips();
}

Map<String, String> _combine(Map<String, String> first,
    Map<String, String> second) {
  if (first.isEmpty()) {
    return second;
  } else if (second.isEmpty()) {
    return first;
  }
  var m = <String>{};
  var set = (String k, String v) => m[k] = v;
  first.forEach(set);
  second.forEach(set);
  return m;
}

class Request extends HttpRequest {
  Request(String method, String path, [Map<String, String> params]) {
    this.method = method;
    this.uri = new Uri.fromString(
        '$_API_ENDPOINT/$path${toParamsString(params)}');
  }
}

class FoursquareException implements Exception {
  int code;
  FoursquareException([this.code]);
}