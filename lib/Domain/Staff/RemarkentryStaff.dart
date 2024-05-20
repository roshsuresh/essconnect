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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['order'] = order;
    data['installationId'] = installationId;
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
        divisionList!.add(RemarkDivisionList.fromJson(v));
      });
    }
    if (json['remarksCategoryList'] != null) {
      remarksCategoryList = <RemarksCategoryList>[];
      json['remarksCategoryList'].forEach((v) {
        remarksCategoryList!.add(RemarksCategoryList.fromJson(v));
      });
    }
    tabulationMethod = json['tabulationMethod'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (divisionList != null) {
      data['divisionList'] = divisionList!.map((v) => v.toJson()).toList();
    }
    if (remarksCategoryList != null) {
      data['remarksCategoryList'] =
          remarksCategoryList!.map((v) => v.toJson()).toList();
    }
    data['tabulationMethod'] = tabulationMethod;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
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
        studentList!.add(RemarksStudentList.fromJson(v));
      });
    }
    if (json['remarkMasterList'] != null) {
      remarkMasterList = <RemarkMasterList>[];
      json['remarkMasterList'].forEach((v) {
        remarkMasterList!.add(RemarkMasterList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (studentList != null) {
      data['studentList'] = studentList!.map((v) => v.toJson()).toList();
    }
    if (remarkMasterList != null) {
      data['remarkMasterList'] =
          remarkMasterList!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rollNo'] = rollNo;
    data['studentId'] = studentId;
    data['name'] = name;
    data['remarks'] = remarks;
    data['principalRemarks'] = principalRemarks;
    data['remarksCaption'] = remarksCaption;
    data['remarksMasterId'] = remarksMasterId;
    data['fileId'] = fileId;
    data['remarksEntryId'] = remarksEntryId;
    data['remarksEntryDetId'] = remarksEntryDetId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['selected'] = selected;
    data['active'] = active;
    data['order'] = order;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['extension'] = extension;
    data['path'] = path;
    data['url'] = url;
    data['isTemporary'] = isTemporary;
    data['isDeleted'] = isDeleted;
    data['images'] = images;
    data['createdAt'] = createdAt;
    data['id'] = id;
    return data;
  }
}
