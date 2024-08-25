class URLManager {

  static String get apiUrl => "https://api.campusconnect.yuiozasx.com/";

  static String get auth => "${apiUrl}auth/";
  static String get comments => "${apiUrl}comments/";
  static String get courses => "${apiUrl}courses/";
  static String get items => "${apiUrl}items/";
  static String get lostAndFounds => "${apiUrl}lost_and_founds/";
  static String get messages => "${apiUrl}chat/";
  static String get posts => "${apiUrl}posts/";
  static String get rooms => "${apiUrl}rooms/";
  static String get notifications => "${apiUrl}notifications/";
  static String get subjects => "${apiUrl}subjects/";
  static String get me => "${users}me/";
  static String get users => "${apiUrl}users/";
  
  static String get messagesWebSocket => "wss://api.campusconnect.yuiozasx.com/wss";
}