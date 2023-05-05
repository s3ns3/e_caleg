class UserDataVO {
  String? saksiId;
  String? namaLengkap;
  String? noHp;
  String? tpsID;
  String? noTps;
  String? alamat;
  String? kecamatanId;
  String? namaKecamatan;
  String? kotaKabupatenId;
  String? namaKotaKabupaten;
  String? provinsiId;
  String? namaProvinsi;
  List<TypeCaleg>? typeCaleg;

  UserDataVO(
      {this.saksiId,
      this.namaLengkap,
      this.noHp,
      this.tpsID,
      this.noTps,
      this.alamat,
      this.kecamatanId,
      this.namaKecamatan,
      this.kotaKabupatenId,
      this.namaKotaKabupaten,
      this.provinsiId,
      this.namaProvinsi,
      this.typeCaleg});

  UserDataVO.empty()
      : this(
          saksiId: '',
          namaLengkap: '',
          noHp: '',
          tpsID: '',
          noTps: '',
          alamat: '',
          kecamatanId: '',
          namaKecamatan: '',
          kotaKabupatenId: '',
          namaKotaKabupaten: '',
          provinsiId: '',
          namaProvinsi: '',
          typeCaleg: [],
        );

  UserDataVO.fromJson(Map<String, dynamic> json) {
    saksiId = json['saksiId'];
    namaLengkap = json['namaLengkap'];
    noHp = json['noHp'];
    tpsID = json['tpsID'];
    noTps = json['noTps'];
    alamat = json['alamat'];
    kecamatanId = json['kecamatanId'];
    namaKecamatan = json['namaKecamatan'];
    kotaKabupatenId = json['kotaKabupatenId'];
    namaKotaKabupaten = json['namaKotaKabupaten'];
    provinsiId = json['provinsiId'];
    namaProvinsi = json['namaProvinsi'];
    if (json['typeCaleg'] != null) {
      typeCaleg = <TypeCaleg>[];
      json['typeCaleg'].forEach((v) {
        typeCaleg!.add(new TypeCaleg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saksiId'] = this.saksiId;
    data['namaLengkap'] = this.namaLengkap;
    data['noHp'] = this.noHp;
    data['tpsID'] = this.tpsID;
    data['noTps'] = this.noTps;
    data['alamat'] = this.alamat;
    data['kecamatanId'] = this.kecamatanId;
    data['namaKecamatan'] = this.namaKecamatan;
    data['kotaKabupatenId'] = this.kotaKabupatenId;
    data['namaKotaKabupaten'] = this.namaKotaKabupaten;
    data['provinsiId'] = this.provinsiId;
    data['namaProvinsi'] = this.namaProvinsi;
    if (this.typeCaleg != null) {
      data['typeCaleg'] = this.typeCaleg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypeCaleg {
  String? typeCalegId;
  String? namaTypeCaleg;

  TypeCaleg({this.typeCalegId, this.namaTypeCaleg});

  TypeCaleg.fromJson(Map<String, dynamic> json) {
    typeCalegId = json['typeCalegId'];
    namaTypeCaleg = json['namaTypeCaleg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeCalegId'] = this.typeCalegId;
    data['namaTypeCaleg'] = this.namaTypeCaleg;
    return data;
  }
}
