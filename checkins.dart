class _Checkins extends _Endpoint {
  _Checkins(_RequestFactory requestFactory) {
    this._endpoint = 'checkins';
    this._requestFactory = requestFactory;
  }

  /*
   * General
   */

  _GetRequest get(String checkinId) {
    return _requestFactory.build('GET', '$_endpoint/$checkinId');
  }
}