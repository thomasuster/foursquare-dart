#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('oauth2.dart');
#import('uri.dart');

#source('users.dart');
#source('venues.dart');
#source('checkins.dart');

class Foursquare {
  RequestFactory _requestFactory;
  String _clientId;

  Foursquare(String clientId, [String clientSecret]) {
    this._requestFactory = new RequestFactory(clientId, clientSecret);
    this._clientId = clientId;
  }

  /* Not currently implemented because OAuth 2.0 library does not work.
  void login([VoidCallback successCallback]) {
    AuthRequest req = new AuthRequest(
        'https://foursquare.com/oauth2/authenticate', _clientId);
    new Auth().login(req,
      successCallback: (String accessToken) {
        this.accessToken = accessToken;

        if (successCallback != null) {
          successCallback();
        }
      },
      errorCallback: (AuthError e) {
        window.alert(e.error);
      });
  } */

  String get accessToken() => this._requestFactory._accessToken;
         set accessToken(value) => this._requestFactory._accessToken = value;

  RequestFactory get requestFactory() => this._requestFactory;

  _Users _users;
  _Users get users() {
    if (_users == null) _users = new _Users(_requestFactory);
    return _users;
  }

  _Venues _venues;
  _Venues get venues() {
    if (_venues == null) _venues = new _Venues(_requestFactory);
    return _venues;
  }

  _Checkins _checkins;
  _Checkins get checkins() {
    if (_checkins == null) new _Checkins(_requestFactory);
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
  final String _VERSION = 'v20120429';
  String _accessToken;

  String _clientId;
  String _clientSecret;

  RequestFactory(String clientId, String clientSecret) {
    this._clientId = clientId;
    this._clientSecret = clientSecret;
  }

  Request build(String method, String path, [Map<String, String> params]) {
    String url = '$_API_ENDPOINT/$path?${_paramsStr(params)}';
    return new Request(method, url);
  }

  String _paramsStr(Map<String, String> params) {
    List<String> parts = new List.from(['v=$_VERSION']);
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

typedef void SuccessCallback(Map);
typedef void FailureCallback(Map);

class Request {

  final String _method;
  final String _url;

  Request(this._method, this._url);

  void execute([SuccessCallback successCallback,
      FailureCallback failureCallback]) {
    XMLHttpRequest xhr = new XMLHttpRequest();
    xhr.open(_method, _url);
    xhr.on.loadEnd.add((Event e) {
      Object resp = JSON.parse(xhr.responseText);
      // TODO: Need to check if it's an error.
      if (successCallback != null) {
        successCallback(resp);
      }
    });
    xhr.send();
  }
}