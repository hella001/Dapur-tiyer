class signupData {
  List<String>? namaMember;
  List<String>? noHp;
  List<String>? email;
  List<String>? password;
  List<String>? konfirmasiPassword;

  signupData(
      {this.namaMember,
      this.noHp,
      this.email,
      this.password,
      this.konfirmasiPassword});

  signupData.fromJson(Map<String, dynamic> json) {
    namaMember = json['nama_member'].cast<String>();
    noHp = json['no_hp'].cast<String>();
    email = json['email'].cast<String>();
    password = json['password'].cast<String>();
    konfirmasiPassword = json['konfirmasi_password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_member'] = this.namaMember;
    data['no_hp'] = this.noHp;
    data['email'] = this.email;
    data['password'] = this.password;
    data['konfirmasi_password'] = this.konfirmasiPassword;
    return data;
  }
}
