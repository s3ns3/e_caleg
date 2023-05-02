class ReqDocumentVO {
  String partaiId = '';
  List<ReqCalegVO>? listCaleg;

  ReqDocumentVO(
      {required this.partaiId,this.listCaleg});

  ReqDocumentVO.fromJson(Map<String, dynamic> json) {
    partaiId = json['partaiId']??'';
    if (json['listCaleg'] != null) {
      listCaleg = <ReqCalegVO>[];
      json['listCaleg'].forEach((v) {
        listCaleg?.add(new ReqCalegVO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partaiId'] = this.partaiId;
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

  ReqCalegVO.fromJson(Map<String, dynamic> json) {
    calegId = json['calegId'];
    calegPoint = json['calegPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calegId'] = this.calegId;
    data['calegPoint'] = this.calegPoint;
    return data;
  }
}
