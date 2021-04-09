class AuthResponse {
  String guidId;
  String username;
  bool isAdmin;
  String token;

  AuthResponse({this.guidId, this.username, this.isAdmin, this.token});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    guidId = json['guidId'];
    username = json['username'];
    isAdmin = json['isAdmin'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidId'] = this.guidId;
    data['username'] = this.username;
    data['isAdmin'] = this.isAdmin;
    data['token'] = this.token;
    return data;
  }
}
