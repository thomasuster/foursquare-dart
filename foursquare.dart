#library('Foursquare API client');

#import('dart:html');
#import('dart:json');
#import('oauth2.dart');


class SampleUsage {
  void usage() {
    Foursquare fsq = new Foursquare();

    fsq.login('CLIENT_ID', successCallback: () {
      fsq.users.leaderboard({
        'foo': 'bar'
      }).execute(successCallback: (Object o) {

      });
    });
  }
}

class Foursquare {
  String _accessToken;

  void login(String clientId, [VoidCallback successCallback]) {
    AuthRequest req = new AuthRequest('https://foursquare.com/oauth2/authenticate', clientId);
    new Auth().login(req,
      successCallback: (String accessToken) {
        this._accessToken = accessToken;

        if (successCallback != null) {
          successCallback();
        }
      },
      errorCallback: (AuthError e) {
        window.alert(e.error);
      });
  }

  _Users get users() => new _Users();
}

abstract class _Endpoint {
  final String _endpoint;
  final _Requester _requester;
}

class _Users extends _Endpoint {
  _Users() {
    this._endpoint = 'users';
    this._requester = new _Requester();
  }

  _GetRequest leaderboard([Map<String, String> params]) {
    return new _Requester().GET('$_endpoint/leaderboard', params);
  }
}

class _Requester {
  final String _API_ENDPOINT = 'https://api.foursquare.com/v2';
  _GetRequest GET(String path, [Map<String, String> params]) {
    String paramsStr = '';
    String url = '$_API_ENDPOINT$path?$paramsStr';
    return new _GetRequest(url);
  }
}

typedef bool SuccessCallback(Object);
typedef bool FailureCallback(Object);

abstract class _Request {
  void _doExecute(String url, String method, [Map<String, String> params,
      SuccessCallback successCallback, FailureCallback failureCallback]) {
    String body = ''; // TODO params -> body
    XMLHttpRequest xhr = new XMLHttpRequest();
    xhr.open(method, url);
    xhr.on.loadEnd.add((Event e) {
      Object resp = JSON.parse(xhr.responseText);
      // TODO: Need to check if it's an error.
      if (successCallback != null) {
        successCallback(resp);
      }
    });
    xhr.send(body);
  }

  abstract void execute([SuccessCallback successCallback, FailureCallback failureCallback]);
}

class _GetRequest extends _Request {
  final String url;

  _GetRequest(this.url);

  void execute([SuccessCallback successCallback, FailureCallback failureCallback]) {
    _doExecute(this.url, 'GET', successCallback: successCallback, failureCallback: failureCallback);
  }
}

class _PostRequest extends _Request {
  final String url;
  final Map<String, String> params;

  _PostRequest(this.url, [this.params=null]);

  void execute([SuccessCallback successCallback, FailureCallback failureCallback]) {
    _doExecute(this.url, 'POST', params: params, successCallback: successCallback,
      failureCallback: failureCallback);
  }
}