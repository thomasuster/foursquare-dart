#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('dart:uri');
#import('http.dart', prefix:'http');
#import('oauth2.dart', prefix:'oauth2');
#import('uri.dart');

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

  Request multi(List<Request> requests, [String method='GET']) {
    List<String> pathsAndQueries = [];
    for (Request r in requests) {
      pathsAndQueries.add(r._getPathAndQuery(true));
    }
    String requestsStr = Strings.join(pathsAndQueries, ',');
    return new Request(method, 'multi', { 'requests': requestsStr });
  }
}

Map<String, String> _combine(Map<String, Dynamic> first,
    Map<String, Dynamic> second) {
  if (first == null || first.isEmpty()) {
    return second;
  } else if (second == null || second.isEmpty()) {
    return first;
  }
  var m = <String>{};
  var set = (String k, String v) => m[k] = v.toString();
  first.forEach(set);
  second.forEach(set);
  return m;
}

class Request {
  String _method;
  String _path;
  Map<String, String> _params;

  Request(String method, String path, [Map<String, String> params]) :
      _method = method,
      _path = path,
      _params = params;

  String _getPathAndQuery([bool multi=false]) {
    if (!multi) {
      if (_params == null) _params = <String>{};
      _params['v'] = _version;
      if (_accessToken != null) {
        _params['oauth_token'] = _accessToken;
      } else {
        // To support userless requests
        _params['client_id'] = _clientId;
        _params['client_secret'] = _clientSecret;
      }
    }
    return '/$_path${_toParamsString(_params)}';
  }

  String _toParamsString(Map<String, String> p) {
    if (p == null) return '';
    List<String> parts = <String>[];
    p.forEach((String key, String val) {
      if (key != null && val != null) {
        parts.add('$key=${encodeURIComponent(val.toString())}');
      }
    });
    return "?${Strings.join(parts, '&')}";
  }

  Future<Map> execute() {
    Uri uri = new Uri.fromString('$_API_ENDPOINT${_getPathAndQuery()}');

    Completer<Map> c = new Completer<Map>();
    Future<http.HttpResponse> innerF = new http.HttpRequest(_method, uri).execute();
    innerF.handleException((e) => c.completeException(e));
    innerF.then((http.HttpResponse r) => c.complete(JSON.parse(r.body)));

    return c.future;
  }
}