class _Venues extends _Endpoint {
  _Venues(_RequestFactory requestFactory) {
    this._endpoint = 'venues';
    this._requestFactory = requestFactory;
  }

  /*
   * General
   */

  _GetRequest get(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId');
  }

  _PostRequest add(Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/add', params);
  }

  _GetRequest categories() {
    return _requestFactory.build('GET', '$_endpoint/categories');
  }

  _GetRequest explore(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/explore', params);
  }

  _GetRequest managed() {
    return _requestFactory.build('GET', '$_endpoint/managed');
  }

  _GetRequest search(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/search', params);
  }

  _GetRequest suggestcompletion(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/suggestcompletion', params);
  }

  _GetRequest timeseries(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/timeseries', params);
  }

  _GetRequest trending(Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/trending', params);
  }

  /*
   * Aspects
   */

  _GetRequest events(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/events');
  }

  _GetRequest herenow(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/herenow', params);
  }

  _GetRequest links(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/links');
  }

  _GetRequest listed(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/listed', params);
  }

  _GetRequest menu(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/menu', params);
  }

  _GetRequest photos(String venueId, Map<String, String> params) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/photos', params);
  }

  _GetRequest similar(String venueId) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/similar');
  }

  _GetRequest stats(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/stats', params);
  }

  _GetRequest tips(String venueId, [Map<String, String> params]) {
    return _requestFactory.build('GET', '$_endpoint/$venueId/tips', params);
  }

  /*
   * Actions
   */

  _PostRequest flag(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/flag', params);
  }

  _PostRequest edit(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/edit', params);
  }

  _PostRequest proposeedit(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/proposeedit', params);
  }

  _PostRequest marktodo(String venueId, Map<String, String> params) {
    return _requestFactory.build('POST', '$_endpoint/$venueId/marktodo', params);
  }
}
