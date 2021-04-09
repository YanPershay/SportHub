class UserInfo {
  String firstName; //
  String lastName; //
  String country; //
  String city; //
  String dateOfBirth; //
  String sportLevel; //
  double height; //
  double weight; //
  String aboutMe; //
  String motivation; //
  String avatarUrl;
  String userId;

  UserInfo(
      {this.firstName,
      this.lastName,
      this.country,
      this.city,
      this.dateOfBirth,
      this.sportLevel,
      this.height,
      this.weight,
      this.aboutMe,
      this.motivation,
      this.avatarUrl,
      this.userId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    city = json['city'];
    dateOfBirth = json['dateOfBirth'];
    sportLevel = json['sportLevel'];
    height = json['height'];
    weight = json['weight'];
    aboutMe = json['aboutMe'];
    motivation = json['motivation'];
    avatarUrl = json['avatarUrl'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['country'] = this.country;
    data['city'] = this.city;
    data['dateOfBirth'] = this.dateOfBirth;
    data['sportLevel'] = this.sportLevel;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['aboutMe'] = this.aboutMe;
    data['motivation'] = this.motivation;
    data['avatarUrl'] = this.avatarUrl;
    data['userId'] = this.userId;
    return data;
  }
}
