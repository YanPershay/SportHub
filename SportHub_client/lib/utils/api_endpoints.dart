class ApiEndpoints {
  static const String protocol = "https://";
  static const String host = "618c15ec59e3.ngrok.io";
  static const String basePath = "/api/v1";

  static const String userPOST = basePath + "/user";
  static const String userInfoPOST = basePath + "/userInfo";

  static const String authenticationPOST = basePath + "/user/authenticate";

  static const String baseUrl = protocol + host + basePath;
  static const String userInfoGET = baseUrl + "/userinfo?guid=";
  static const String userPostsGET = baseUrl + "/post/postsbyguid?guid=";

  static const String mySubscribesGET =
      baseUrl + "/subscribe/getmysubs?subscriberid=";
  static const String subscribersGET = baseUrl + "/subscribe/getsubs?userid=";

  static const String subscribesPostsGET =
      baseUrl + "/post/subsPosts?subscriberId=";

  static const String getAdminPostsGET = baseUrl + "/adminpost?id=3";

  static const String getCommentsGET = baseUrl + "/comment?id=";
}
