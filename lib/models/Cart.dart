class CartsModel {
  int? id;
  int? idMember;
  int? idBarang;
  int? jumlah;
  String? size;
  String? color;
  int? total;
  int? isCheckout;
  String? createdAt;
  String? updatedAt;
  String? namaMember;
  String? noHp;
  String? email;
  String? password;
  int? idKategori;
  int? idSubkategori;
  String? namaBarang;
  String? gambar;
  String? deskripsi;
  int? harga;
  int? diskon;
  String? bahan;
  String? tags;
  String? sku;
  String? ukuran;
  String? warna;
  int? cartsId;

  CartsModel(
      {this.id,
      this.idMember,
      this.idBarang,
      this.jumlah,
      this.size,
      this.color,
      this.total,
      this.isCheckout,
      this.createdAt,
      this.updatedAt,
      this.namaMember,
      this.noHp,
      this.email,
      this.password,
      this.idKategori,
      this.idSubkategori,
      this.namaBarang,
      this.gambar,
      this.deskripsi,
      this.harga,
      this.diskon,
      this.bahan,
      this.tags,
      this.sku,
      this.ukuran,
      this.warna,
      this.cartsId});

  CartsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMember = json['id_member'];
    idBarang = json['id_barang'];
    jumlah = json['jumlah'];
    size = json['size'];
    color = json['color'];
    total = json['total'];
    isCheckout = json['is_checkout'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaMember = json['nama_member'];
    noHp = json['no_hp'];
    email = json['email'];
    password = json['password'];
    idKategori = json['id_kategori'];
    idSubkategori = json['id_subkategori'];
    namaBarang = json['nama_barang'];
    gambar = json['gambar'];
    deskripsi = json['deskripsi'];
    harga = json['harga'];
    diskon = json['diskon'];
    bahan = json['bahan'];
    tags = json['tags'];
    sku = json['sku'];
    ukuran = json['ukuran'];
    warna = json['warna'];
    cartsId = json['carts_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_member'] = this.idMember;
    data['id_barang'] = this.idBarang;
    data['jumlah'] = this.jumlah;
    data['size'] = this.size;
    data['color'] = this.color;
    data['total'] = this.total;
    data['is_checkout'] = this.isCheckout;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nama_member'] = this.namaMember;
    data['no_hp'] = this.noHp;
    data['email'] = this.email;
    data['password'] = this.password;
    data['id_kategori'] = this.idKategori;
    data['id_subkategori'] = this.idSubkategori;
    data['nama_barang'] = this.namaBarang;
    data['gambar'] = this.gambar;
    data['deskripsi'] = this.deskripsi;
    data['harga'] = this.harga;
    data['diskon'] = this.diskon;
    data['bahan'] = this.bahan;
    data['tags'] = this.tags;
    data['sku'] = this.sku;
    data['ukuran'] = this.ukuran;
    data['warna'] = this.warna;
    data['carts_id'] = this.cartsId;
    return data;
  }
}
