#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('dart:uri');
#import('http.dart');
#import('oauth2.dart', prefix:'oauth2');
#import('uri.dart');

#source('users.dart');
#source('venues.dart');
#source('checkins.dart');
#source('tips.dart');

final String _AUTH_URL = 'https://foursquare.com/oauth2/authenticate';
final String _API_ENDPOINT = 'https://api.foursquare.com/v2/';
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

  Future login(String redirectUri) {
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

  /*
   * Endpoints
   */
  Users get users() => new Users();
  Venues get venues() => new Venues();
  Checkins get checkins() => new Checkins();
  Tips get tips() => new Tips();
}

Map<String, String> _combine(Map<String, Dynamic> first,
    Map<String, Dynamic> second) {
  if (first.isEmpty()) {
    return second;
  } else if (second.isEmpty()) {
    return first;
  }
  var m = <String>{};
  var set = (String k, String v) => m[k] = v.toString();
  first.forEach(set);
  second.forEach(set);
  return m;
}

class Request {
  String method;
  String path;
  Map<String, String> params;

  Request(this.method, this.path, [this.params]);

  Future<Map> execute() {
    if (params == null) params = <String>{};
    if (_accessToken != null) {
      params['oauth_token'] = _accessToken;
    } else {
      params['client_id'] = _clientId;
      params['client_secret'] = _clientSecret;
    }
    Uri uri = new Uri.fromString(
        '$_API_ENDPOINT$path${_toParamsString(params)}');

    Completer<Map> c = new Completer<Map>();
    Future<HttpResponse> innerF = new HttpRequest(method, uri).execute();
    innerF.handleException((e) => c.completeException(e));
    innerF.then((HttpResponse r) => c.complete(JSON.parse(r.body)));

    return c.future;
  }

  String _toParamsString(Map<String, String> p) {
    if (p == null) return '';
    List<String> parts = new List<String>();
    p.forEach((String key, String val) {
      parts.add('$key=${encodeURIComponent(val)}');
    });
    return '?' + Strings.join(parts, '&');
  }
}