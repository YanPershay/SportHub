import 'package:SportHub_client/utils/shared_prefs.dart';

class ApiEndpoints {
  static const String protocol = "https://";
  static const String host = "a7b54d679e90.ngrok.io";
  static const String basePath = "/api/v1";

  static const String userPOST = basePath + "/user";
  static const String userInfoPOST = basePath + "/userInfo";

  static const String authenticationPOST = basePath + "/user/authenticate";

  static const String baseUrl = protocol + host + basePath;

  static const String userGET = baseUrl + "/user?guid=";

  static const String userInfoGET = baseUrl + "/userinfo?guid=";
  static const String userPostsGET = baseUrl + "/post/postsbyguid?guid=";
  static const String savedPostsGET = baseUrl + "/post/savedPosts?userId=";
  static const String subscribesPostsGET =
      baseUrl + "/post/subsPosts?subscriberId=";

  static const String mySubscribesGET =
      baseUrl + "/subscribe/getmysubs?subscriberid=";
  static const String subscribersGET = baseUrl + "/subscribe/getsubs?userid=";
  static const String subsCountGET = baseUrl + "/subscribe/subscount?userid=";

  static const String getAdminPostsGET = baseUrl + "/adminpost?id=3";

  static const String getCommentsGET = baseUrl + "/comment?id=";

  static const String searchUsersGET =
      baseUrl + "/user/searchUser?searchString=";

  static String isSubscribed = baseUrl +
      "/subscribe/isSubscribed?subscriberId=" +
      SharedPrefs.userId +
      "&userid=";

  static String subscribeToUserPOST = baseUrl + "/subscribe";

  static String likePOST = baseUrl + "/like";

  static String commentPOST = baseUrl + "/comment";

  static const String savedPostsListGET = baseUrl + "/savedPost?userId=";
  static const String savePostPOST = baseUrl + "/savedPost";

  static const String deleteLikeDELETE = baseUrl + "/like";
  static const String deleteSavedPostDELETE = baseUrl + "/savedPost";
  static const String unsubscribeDELETE = baseUrl + "/subscribe";
  static String getSubscribeObjGET = baseUrl +
      "/subscribe/subObj?subscriberid=" +
      SharedPrefs.userId +
      "&userid=";
}
