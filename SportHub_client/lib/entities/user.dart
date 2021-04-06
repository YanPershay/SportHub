class User {
  String guidId;
  String username;
  String email;
  String password;
  bool isOnline;
  bool isAdmin;

  User(
      {this.guidId,
      this.username,
      this.email,
      this.password,
      this.isOnline,
      this.isAdmin});

  User.fromJson(Map<String, dynamic> json) {
    guidId = json['guidId'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    isOnline = json['isOnline'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guidId'] = this.guidId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['isOnline'] = this.isOnline;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}
