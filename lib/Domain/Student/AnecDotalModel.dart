class AnecDotalInitial {
  List<AnecdotalList>? anecdotalList;
  String? maxDate;

  AnecDotalInitial({this.anecdotalList, this.maxDate});

  AnecDotalInitial.fromJson(Map<String, dynamic> json) {
    if (json['anecdotalList'] != null) {
      anecdotalList = <AnecdotalList>[];
      json['anecdotalList'].forEach((v) {
        anecdotalList!.add(new AnecdotalList.fromJson(v));
      });
    }
    maxDate = json['maxDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.anecdotalList != null) {
      data['anecdotalList'] =
          this.anecdotalList!.map((v) => v.toJson()).toList();
    }
    data['maxDate'] = this.maxDate;
    return data;
  }
}

class AnacDotalData {
  String? date;
  List<AnecdotalList>? anecdotalList;

  AnacDotalData({this.date, this.anecdotalList});

  AnacDotalData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['anecdotalList'] != null) {
      anecdotalList = <AnecdotalList>[];
      json['anecdotalList'].forEach((v) {
        anecdotalList!.add(new AnecdotalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.anecdotalList != null) {
      data['anecdotalList'] =
          this.anecdotalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnecdotalList {
  String? remarksDate;
  String? studentId;
  String? remarksCategory;
  String? subject;
  String? remarks;
  String? remarksBy;
  String? enteredBy;
  String? time;
  bool? isImportant;

  AnecdotalList(
      {this.remarksDate,
        this.studentId,
        this.remarksCategory,
        this.subject,
        this.remarks,
        this.remarksBy,
        this.enteredBy,
        this.time,
        this.isImportant});

  AnecdotalList.fromJson(Map<String, dynamic> json) {
    remarksDate = json['remarksDate'];
    studentId = json['studentId'];
    remarksCategory = json['remarksCategory'];
    subject = json['subject'];
    remarks = json['remarks'];
    remarksBy = json['remarksBy'];
    enteredBy = json['enteredBy'];
    time = json['time'];
    isImportant = json['isImportant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remarksDate'] = this.remarksDate;
    data['studentId'] = this.studentId;
    data['remarksCategory'] = this.remarksCategory;
    data['subject'] = this.subject;
    data['remarks'] = this.remarks;
    data['remarksBy'] = this.remarksBy;
    data['enteredBy'] = this.enteredBy;
    data['time'] = this.time;
    data['isImportant'] = this.isImportant;
    return data;
  }
}
