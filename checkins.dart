class Checkins {
  final String endpoint = 'venues';
  final RequestFactory _requestFactory;

  Checkins(this._requestFactory);

  /*
   * General
   */

  Request get(String checkinId, [String signature,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'signature': signature,
    }, additional);
    return _requestFactory.build('GET', '$endpoint/$checkinId', params);
  }

  Request recent([String ll, int limit, int afterTimestamp,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'limit': limit.toString(),
      'afterTimestamp': afterTimestamp.toString(),
    }, additional);
    return _requestFactory.build('GET', '$endpoint/recent', params);
  }

  /*
   * Actions
   */

  Request addcomment(String checkinId, String text,
      [Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'text': text,
    }, additional);
    return _requestFactory.build('POST', '$endpoint/$checkinId/addcomment',
        params);
  }

  Request deletecomment(String checkinId, String commentId,
      [Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'commentId': commentId,
    }, additional);
    return _requestFactory.build('POST', '$endpoint/$checkinId/deletecomment',
        params);
  }
}