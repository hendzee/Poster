class Services {
  static final String _SERVICE_HOST =
      'http://192.168.1.14/poster_service/public'; // Host address

  static String users() {
    return _SERVICE_HOST + '/users';
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

  // static String Comming soon list
  static String getCommingSoonPoster() {
    return _SERVICE_HOST + '/posters/recommendation';
  }
}
