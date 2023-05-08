class ReqDocumentVO {
  String partaiId = '';
  String typeCalegId = '';
  String suaraPartai;
  List<ReqCalegVO>? listCaleg;

  ReqDocumentVO(
      {required this.partaiId, required this.typeCalegId,this.listCaleg, this.suaraPartai = '0'});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partaiId'] = this.partaiId;
    data['typeCalegId'] = this.typeCalegId;
    data['suaraPartai'] = this.suaraPartai;
    if (this.listCaleg != null) {
      data['listCaleg'] = this.listCaleg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReqCalegVO {
  String? calegId;
  String? calegPoint;

  ReqCalegVO({this.calegId, this.calegPoint});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calegId'] = this.calegId;
    data['calegPoint'] = this.calegPoint;
    return data;
  }
}
