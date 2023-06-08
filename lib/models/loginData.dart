class loginData {
  bool? error;
  String? message;
  User? user;

  loginData({this.error, this.message, this.user});

  loginData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? idUsers;
  String? username;
  String? email;
  String? password;

  User({this.idUsers, this.username, this.email, this.password});

  User.fromJson(Map<String, dynamic> json) {
    idUsers = json['id_users'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_users'] = this.idUsers;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
