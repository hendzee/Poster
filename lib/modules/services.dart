class Services {
  static final String _SERVICE_HOST =
      'http://192.168.1.5/poster_service/public'; // Host address

  static String users() {
    return _SERVICE_HOST + '/users';
  }

  static String posters() {
    return _SERVICE_HOST + '/posters';
  }

  static String login() {
    return _SERVICE_HOST + '/users/login';
  }

  static String signup() {
    return _SERVICE_HOST + '/users/signup';
  }

  // Genereal error message
  static String generealErrorMsg() {
    return 'Something went wrong, please try again';
  }

  // Get trending poster
  static String getTrendingPoster() {
    return _SERVICE_HOST + '/posters/trending';
  }

  // Recomended poster list
  static String getRecomendedPoster() {
    return _SERVICE_HOST + '/posters/recommendation';
  }

  // Comming soon list
  static String getCommingSoonPoster() {
    return _SERVICE_HOST + '/posters/recommendation';
  }

  // Get user's poster
  static String getUserPoster() {
    return _SERVICE_HOST + '/users/posters';
  }

  // Get user's subscriber
  static String getUserSubscription() {
    return _SERVICE_HOST + '/users/subscriptions';
  }

  // Get sugestion search
  static String getSugestionSearch() {
    return _SERVICE_HOST + '/posters/search';
  }

  // Get search result
  static String getSearchResult() {
    return _SERVICE_HOST + '/posters/search_result';
  }

  // Check subscribe status
  static String checkSubscribeStatus() {
    return _SERVICE_HOST + '/subscribers/exist';
  }
}
