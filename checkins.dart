class _Checkins extends _Endpoint {
  _Checkins(_RequestFactory requestFactory) {
    this._endpoint = 'checkins';
    this._requestFactory = requestFactory;
  }

  /*
   * General
   */

  _GetRequest get(String checkinId, [String signature,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'signature': signature,
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/$checkinId', params);
  }

  _GetRequest recent([String ll, int limit, int afterTimestamp,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'limit': limit.toString(),
      'afterTimestamp': afterTimestamp.toString(),
    }, additional);
    return _requestFactory.build('GET', '$_endpoint/recent', params);
  }

  _PostRequest addcomment(String checkinId, String text,
      [Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'text': text,
    }, additional);
    return _requestFactory.build('POST', '$_endpoint/$checkinId/addcomment',
        params);
  }

  _PostRequest deletecomment(String checkinId, String commentId,
      [Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'commentId': commentId,
    }, additional);
    return _requestFactory.build('POST', '$_endpoint/$checkinId/deletecomment',
        params);
  }
}