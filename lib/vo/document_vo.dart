class DocumentVO {
  String partaiId = '';
  String partaiName = '';
  List<CalegVO>? listCaleg;

  DocumentVO(
      {required this.partaiId, required this.partaiName, this.listCaleg});

  DocumentVO.fromJson(Map<String, dynamic> json) {
    partaiId = json['partaiId']??'';
    partaiName = json['partaiName']??'';
    if (json['listCaleg'] != null) {
      listCaleg = <CalegVO>[];
      json['listCaleg'].forEach((v) {
        listCaleg?.add(new CalegVO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partaiId'] = this.partaiId;
    data['partaiName'] = this.partaiName;
    if (this.listCaleg != null) {
      data['listCaleg'] = this.listCaleg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalegVO {
  String? calegId;
  String? calegName;

  CalegVO({this.calegId, this.calegName});

  CalegVO.fromJson(Map<String, dynamic> json) {
    calegId = json['calegId'];
    calegName = json['calegName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calegId'] = this.calegId;
    data['calegName'] = this.calegName;
    return data;
  }
}
