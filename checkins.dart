class Checkins {
  final String endpoint = 'venues';

  /*
   * General
   */

  Request get(String checkinId, [String signature,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'signature': signature,
    }, additional);
    return new Request('GET', '$endpoint/$checkinId', params);
  }

  Request recent([String ll, int limit, int afterTimestamp,
      Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'll': ll,
      'limit': limit.toString(),
      'afterTimestamp': afterTimestamp.toString(),
    }, additional);
    return new Request('GET', '$endpoint/recent', params);
  }

  /*
   * Actions
   */

  Request addcomment(String checkinId, String text,
      [Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'text': text,
    }, additional);
    return new Request('POST', '$endpoint/$checkinId/addcomment',
        params);
  }

  Request deletecomment(String checkinId, String commentId,
      [Map<String, String> additional]) {
    Map<String, String> params = _combine({
      'commentId': commentId,
    }, additional);
    return new Request('POST', '$endpoint/$checkinId/deletecomment',
        params);
  }
}