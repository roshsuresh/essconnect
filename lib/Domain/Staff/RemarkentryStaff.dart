class RemarksCourseList {
  String? value;
  String? text;
  int? order;
  int? installationId;

  RemarksCourseList({this.value, this.text, this.order, this.installationId});

  RemarksCourseList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    order = json['order'];
    installationId = json['installationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['order'] = this.order;
    data['installationId'] = this.installationId;
    return data;
  }
}
class RemarkDivisionInitialValues {
  List<RemarkDivisionList>? divisionList;
  List<RemarksCategoryList>? remarksCategoryList;
  String? tabulationMethod;


  RemarkDivisionInitialValues(
      {this.divisionList,
        this.remarksCategoryList,
        this.tabulationMethod,
       });

  RemarkDivisionInitialValues.fromJson(Map<String, dynamic> json) {
    if (json['divisionList'] != null) {
      divisionList = <RemarkDivisionList>[];
      json['divisionList'].forEach((v) {
        divisionList!.add(new RemarkDivisionList.fromJson(v));
      });
    }
    if (json['remarksCategoryList'] != null) {
      remarksCategoryList = <RemarksCategoryList>[];
      json['remarksCategoryList'].forEach((v) {
        remarksCategoryList!.add(new RemarksCategoryList.fromJson(v));
      });
    }
    tabulationMethod = json['tabulationMethod'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.divisionList != null) {
      data['divisionList'] = this.divisionList!.map((v) => v.toJson()).toList();
    }
    if (this.remarksCategoryList != null) {
      data['remarksCategoryList'] =
          this.remarksCategoryList!.map((v) => v.toJson()).toList();
    }
    data['tabulationMethod'] = this.tabulationMethod;

    return data;
  }
}

//division


class RemarkDivisionList {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  RemarkDivisionList({this.value, this.text, this.selected, this.active, this.order});

  RemarkDivisionList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

class RemarksCategoryList {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  RemarksCategoryList({this.value, this.text, this.selected, this.active, this.order});

  RemarksCategoryList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

//TermList

class RemarksTermlist {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  RemarksTermlist({this.value, this.text, this.selected, this.active, this.order});

  RemarksTermlist.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}
//Assessment list
class RemarksAssessmentList {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  RemarksAssessmentList({this.value, this.text, this.selected, this.active, this.order});

  RemarksAssessmentList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

//Remarks View

class RemarksEntryView {
  List<RemarksStudentList>? studentList;
  List<RemarkMasterList>? remarkMasterList;

  RemarksEntryView({this.studentList, this.remarkMasterList});

  RemarksEntryView.fromJson(Map<String, dynamic> json) {
    if (json['studentList'] != null) {
      studentList = <RemarksStudentList>[];
      json['studentList'].forEach((v) {
        studentList!.add(new RemarksStudentList.fromJson(v));
      });
    }
    if (json['remarkMasterList'] != null) {
      remarkMasterList = <RemarkMasterList>[];
      json['remarkMasterList'].forEach((v) {
        remarkMasterList!.add(new RemarkMasterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentList != null) {
      data['studentList'] = this.studentList!.map((v) => v.toJson()).toList();
    }
    if (this.remarkMasterList != null) {
      data['remarkMasterList'] =
          this.remarkMasterList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RemarksStudentList {
  int? rollNo;
  String? studentId;
  String? name;
  String? remarks;
  String? principalRemarks;
  String? remarksCaption;
  String? remarksMasterId;
  String? fileId;
  String? remarksEntryId;
  String? remarksEntryDetId;

  RemarksStudentList(
      {this.rollNo,
        this.studentId,
        this.name,
        this.remarks,
        this.principalRemarks,
        this.remarksCaption,
        this.remarksMasterId,
        this.fileId,
        this.remarksEntryId,
        this.remarksEntryDetId});

  RemarksStudentList.fromJson(Map<String, dynamic> json) {
    rollNo = json['rollNo'];
    studentId = json['studentId'];
    name = json['name'];
    remarks = json['remarks'];
    principalRemarks = json['principalRemarks'];
    remarksCaption = json['remarksCaption'];
    remarksMasterId = json['remarksMasterId'];
    fileId = json['fileId'];
    remarksEntryId = json['remarksEntryId'];
    remarksEntryDetId = json['remarksEntryDetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rollNo'] = this.rollNo;
    data['studentId'] = this.studentId;
    data['name'] = this.name;
    data['remarks'] = this.remarks;
    data['principalRemarks'] = this.principalRemarks;
    data['remarksCaption'] = this.remarksCaption;
    data['remarksMasterId'] = this.remarksMasterId;
    data['fileId'] = this.fileId;
    data['remarksEntryId'] = this.remarksEntryId;
    data['remarksEntryDetId'] = this.remarksEntryDetId;
    return data;
  }
}

class RemarkMasterList {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  RemarkMasterList(
      {this.value, this.text, this.selected, this.active, this.order});

  RemarkMasterList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

class MarkHistoryAttachment {
  String? name;
  String? extension;
  String? path;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  MarkHistoryAttachment(
      {this.name,
        this.extension,
        this.path,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  MarkHistoryAttachment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    url = json['url'];
    isTemporary = json['isTemporary'];
    isDeleted = json['isDeleted'];
    images = json['images'];
    createdAt = json['createdAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
