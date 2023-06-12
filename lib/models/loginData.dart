class loginData {
  int? status;
  String? message;
  UserId? userId;

  loginData({this.status, this.message, this.userId});

  loginData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    return data;
  }
}

class UserId {
  int? id;
  String? namaMember;
  String? noHp;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  UserId(
      {this.id,
      this.namaMember,
      this.noHp,
      this.email,
      this.password,
      this.createdAt,
      this.updatedAt});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaMember = json['nama_member'];
    noHp = json['no_hp'];
    email = json['email'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_member'] = this.namaMember;
    data['no_hp'] = this.noHp;
    data['email'] = this.email;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
