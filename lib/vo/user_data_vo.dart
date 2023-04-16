class UserDataVO {
  String? saksiId;
  String? namaLengkap;
  String? noHp;
  String? tpsID;
  String? noTps;
  String? alamat;
  String? dapilKecamatanId;
  String? namaKecamatan;
  String? totalDpt;

  UserDataVO(
      {this.saksiId,
        this.namaLengkap,
        this.noHp,
        this.tpsID,
        this.noTps,
        this.alamat,
        this.dapilKecamatanId,
        this.namaKecamatan,
        this.totalDpt});

  UserDataVO.fromJson(Map<String, dynamic> json) {
    saksiId = json['saksiId'];
    namaLengkap = json['namaLengkap'];
    noHp = json['noHp'];
    tpsID = json['tpsID'];
    noTps = json['noTps'];
    alamat = json['alamat'];
    dapilKecamatanId = json['dapilKecamatanId'];
    namaKecamatan = json['namaKecamatan'];
    totalDpt = json['totalDpt'];
  }

  UserDataVO.empty(): this(
      saksiId  : '',
      namaLengkap  : '',
      noHp  : '',
      tpsID  : '',
      noTps  : '',
      alamat  : '',
      dapilKecamatanId  : '',
      namaKecamatan  : '',
      totalDpt  : '',
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['saksiId'] = this.saksiId;
    data['namaLengkap'] = this.namaLengkap;
    data['noHp'] = this.noHp;
    data['tpsID'] = this.tpsID;
    data['noTps'] = this.noTps;
    data['alamat'] = this.alamat;
    data['dapilKecamatanId'] = this.dapilKecamatanId;
    data['namaKecamatan'] = this.namaKecamatan;
    data['totalDpt'] = this.totalDpt;
    return data;
  }
}