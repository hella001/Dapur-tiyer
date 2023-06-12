class Product {
  int? id;
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
  String? createdAt;
  String? updatedAt;
  Category? category;
  Subcategory? subcategory;

  Product(
      {this.id,
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
      this.createdAt,
      this.updatedAt,
      this.category,
      this.subcategory});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? namaKategori;
  String? deskripsi;
  String? gambar;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.namaKategori,
      this.deskripsi,
      this.gambar,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKategori = json['nama_kategori'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kategori'] = this.namaKategori;
    data['deskripsi'] = this.deskripsi;
    data['gambar'] = this.gambar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Subcategory {
  int? id;
  int? idKategori;
  String? namaSubkategori;
  String? deskripsi;
  String? gambar;
  String? createdAt;
  String? updatedAt;

  Subcategory(
      {this.id,
      this.idKategori,
      this.namaSubkategori,
      this.deskripsi,
      this.gambar,
      this.createdAt,
      this.updatedAt});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKategori = json['id_kategori'];
    namaSubkategori = json['nama_subkategori'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_kategori'] = this.idKategori;
    data['nama_subkategori'] = this.namaSubkategori;
    data['deskripsi'] = this.deskripsi;
    data['gambar'] = this.gambar;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
