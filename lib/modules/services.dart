class Services {
  static final String _SERVICE_HOST =
      'http://192.168.1.14/poster_service/public'; // Host address

  static String login() {
    return _SERVICE_HOST + '/users/login';
  }
}
