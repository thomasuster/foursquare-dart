#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('oauth2.dart');
#import('uri.dart');

#source('users.dart');
#source('venues.dart');
#source('checkins.dart');

class Foursquare {
  _RequestFactory _requestFactory;
  String _clientId;

  Foursquare(String clientId, [String clientSecret]) {
    this._requestFactory = new _RequestFactory(clientId, clientSecret);
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

  _Users _users;
  _Users get users() {
    if (_users == null) {
      _users = new _Users(_requestFactory);
    }
    return _users;
  }

  _Venues _venues;
  _Venues get venues() {
    if (_venues == null) {
      _venues = new _Venues(_requestFactory);
    }
    return _venues;
  }

  _Checkins _checkins;
  _Checkins get checkins() {
    if (_checkins == null) {
      new _Checkins(_requestFactory);
    }
    return _checkins;
  }
}

abstract class _Endpoint {
  final String _endpoint;
  final _RequestFactory _requestFactory;
}

class _RequestFactory {
  final String _API_ENDPOINT = 'https://api.foursquare.com/v2';
  final String _VERSION = 'v20120429';
  String _accessToken;

  String _clientId;
  String _clientSecret;

  _RequestFactory(String clientId, String clientSecret) {
    this._clientId = clientId;
    this._clientSecret = clientSecret;
  }

  _Request build(String method, String path, [Map<String, String> params]) {
    String url = '$_API_ENDPOINT/$path?${_paramsStr(params)}';
    switch (method) {
      case 'GET':
        return new _GetRequest(url);
      case 'POST':
        return new _PostRequest(url);
    }
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

typedef bool SuccessCallback(Object);
typedef bool FailureCallback(Object);

abstract class _Request {
  void _doExecute(String url, String method, [Map<String, String> params,
      SuccessCallback successCallback, FailureCallback failureCallback]) {
    XMLHttpRequest xhr = new XMLHttpRequest();
    xhr.open(method, url);
    xhr.on.loadEnd.add((Event e) {
      Object resp = JSON.parse(xhr.responseText);
      // TODO: Need to check if it's an error.
      if (successCallback != null) {
        successCallback(resp);
      }
    });
    xhr.send();
  }

  abstract void execute([SuccessCallback successCallback,
      FailureCallback failureCallback]);
}

class _GetRequest extends _Request {
  final String url;
  final String method = 'GET';

  _GetRequest(this.url);

  void execute([SuccessCallback successCallback,
      FailureCallback failureCallback]) {
    _doExecute(url, method, successCallback: successCallback,
      failureCallback: failureCallback);
  }
}

class _PostRequest extends _Request {
  final String url;
  final String method = 'POST';
  final Map<String, String> params;

  _PostRequest(this.url, [this.params=null]);

  void execute([SuccessCallback successCallback,
      FailureCallback failureCallback]) {
    _doExecute(url, method, params: params, successCallback: successCallback,
      failureCallback: failureCallback);
  }
}