class ApiEndpoints {
  static const String protocol = "https://";
  static const String host = "6e5a7ad386f6.ngrok.io";
  static const String basePath = "/api/v1";

  static const String userPOST = basePath + "/user";
  static const String userInfoPOST = basePath + "/userInfo";

  static const String authenticationPOST = basePath + "/user/authenticate";

  static const String baseUrl = protocol + host + basePath;
  static const String userInfoGET = baseUrl + "/userinfo?guid=";
  static const String userPostsGET = baseUrl + "/post?guid=";

  static const String mySubscribesGET =
      baseUrl + "/subscribe/getmysubs?subscriberid=";

  static const String subscribersGET = baseUrl + "/subscribe/getsubs?userid=";
}
