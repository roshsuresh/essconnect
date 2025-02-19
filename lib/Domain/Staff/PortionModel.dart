//Courses


class PortionInitial {
  List<PortionCourse>? courseList;
  String? isExistApprovalSettings;
  String? isClassTeacher;

  PortionInitial(
      {this.courseList, this.isExistApprovalSettings, this.isClassTeacher});

  PortionInitial.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = <PortionCourse>[];
      json['courseList'].forEach((v) {
        courseList!.add(new PortionCourse.fromJson(v));
      });
    }
    isExistApprovalSettings = json['isExistApprovalSettings'];
    isClassTeacher = json['isClassTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.map((v) => v.toJson()).toList();
    }
    data['isExistApprovalSettings'] = this.isExistApprovalSettings;
    data['isClassTeacher'] = this.isClassTeacher;
    return data;
  }
}


class PortionCourse {
  String? tblId;
  String? name;
  int? sortOrder;

  PortionCourse({this.tblId, this.name, this.sortOrder});

  PortionCourse.fromJson(Map<String, dynamic> json) {
    tblId = json['tblId'];
    name = json['name'];
    sortOrder = json['sortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tblId'] = this.tblId;
    data['name'] = this.name;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}
//Division
class PortionDivisions {
  String? value;
  String? text;
  String? courseSubjectId;
  bool? subSubjectOrOptional;
  bool? selected;
  bool? active;
  int? order;

  PortionDivisions(
      {this.value,
        this.text,
        this.courseSubjectId,
        this.subSubjectOrOptional,
        this.selected,
        this.active,
        this.order});

  PortionDivisions.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    courseSubjectId = json['courseSubjectId'];
    subSubjectOrOptional = json['subSubjectOrOptional'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['courseSubjectId'] = this.courseSubjectId;
    data['subSubjectOrOptional'] = this.subSubjectOrOptional;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}

//Subjects
class PortionSubjects {
  String? value;
  String? text;
  String? courseSubjectId;
  String? optionSubjectId;
  String? subSubjectId;
  bool? selected;
  bool? active;
  int? order;

  PortionSubjects(
      {this.value,
        this.text,
        this.courseSubjectId,
        this.optionSubjectId,
        this.subSubjectId,
        this.selected,
        this.active,
        this.order});

  PortionSubjects.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    courseSubjectId = json['courseSubjectId'];
    optionSubjectId = json['optionSubjectId'];
    subSubjectId = json['subSubjectId'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['courseSubjectId'] = this.courseSubjectId;
    data['optionSubjectId'] = this.optionSubjectId;
    data['subSubjectId'] = this.subSubjectId;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}


//PortionSubsubject

class PortionSubSubject {
  String? value;
  String? text;
  String? courseSubjectId;
  String? subSubjectOrOptional;
  bool? selected;
  bool? active;
  String? order;

  PortionSubSubject(
      {this.value,
        this.text,
        this.courseSubjectId,
        this.subSubjectOrOptional,
        this.selected,
        this.active,
        this.order});

  PortionSubSubject.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    courseSubjectId = json['courseSubjectId'];
    subSubjectOrOptional = json['subSubjectOrOptional'];
    selected = json['selected'];
    active = json['active'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    data['courseSubjectId'] = this.courseSubjectId;
    data['subSubjectOrOptional'] = this.subSubjectOrOptional;
    data['selected'] = this.selected;
    data['active'] = this.active;
    data['order'] = this.order;
    return data;
  }
}
//student
class StudentListPortions {
  String? id;
  String? admNo;
  String? name;
  String? division;
  String? divisionId;
  String? courseId;
  String? rollNo;
  String? guardianId;
  String? guardianMobile;
  String? guardianName;
  String? relationId;
  bool? selected;

  StudentListPortions(
      {this.id,
        this.admNo,
        this.name,
        this.division,
        this.divisionId,
        this.courseId,
        this.rollNo,
        this.guardianId,
        this.guardianMobile,
        this.guardianName,
        this.relationId});

  StudentListPortions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    admNo = json['admNo'];
    name = json['name'];
    division = json['division'];
    divisionId = json['divisionId'];
    courseId = json['courseId'];
    rollNo = json['rollNo'];
    guardianId = json['guardianId'];
    guardianMobile = json['guardianMobile'];
    guardianName = json['guardianName'];
    relationId = json['relationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['admNo'] = this.admNo;
    data['name'] = this.name;
    data['division'] = this.division;
    data['divisionId'] = this.divisionId;
    data['courseId'] = this.courseId;
    data['rollNo'] = this.rollNo;
    data['guardianId'] = this.guardianId;
    data['guardianMobile'] = this.guardianMobile;
    data['guardianName'] = this.guardianName;
    data['relationId'] = this.relationId;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? pageSize;
  int? count;

  Pagination({this.currentPage, this.pageSize, this.count});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;
    data['count'] = this.count;
    return data;
  }
}

//Files

class PortionFiles {
  String? name;
  String? extension;
  String? path;
  String? size;
  String? url;
  bool? isTemporary;
  bool? isDeleted;
  String? images;
  String? createdAt;
  String? id;

  PortionFiles(
      {this.name,
        this.extension,
        this.path,
        this.size,
        this.url,
        this.isTemporary,
        this.isDeleted,
        this.images,
        this.createdAt,
        this.id});

  PortionFiles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    extension = json['extension'];
    path = json['path'];
    size = json['size'];
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
    data['size'] = this.size;
    data['url'] = this.url;
    data['isTemporary'] = this.isTemporary;
    data['isDeleted'] = this.isDeleted;
    data['images'] = this.images;
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }

}
//Notification
//-----------------------
class PortionResponse {
  String? classTeacherApproval;
  String? portionEntryId;

  PortionResponse({this.classTeacherApproval, this.portionEntryId});

  PortionResponse.fromJson(Map<String, dynamic> json) {
    classTeacherApproval = json['classTeacherApproval'];
    portionEntryId = json['portionEntryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classTeacherApproval'] = this.classTeacherApproval;
    data['portionEntryId'] = this.portionEntryId;
    return data;
  }
}

//---------------List---------------

class PortionList {
  String? tblId;
  String? date;
  String? division;
  String? subject;
  String? topic;
  String? chapter;
  String? courseSubjectId;
  String? status;
  int? seenCount;
  int? unSeenCount;
  List<StudViewedorNotList>? viewedList;
  List<StudViewedorNotList>? notViewedList;
  PortionList(
      {this.tblId,
        this.date,
        this.division,
        this.subject,
        this.topic,
        this.chapter,
        this.courseSubjectId,
      this.status,
      this.seenCount,
        this.unSeenCount,
        this.viewedList,
        this.notViewedList
      });

  PortionList.fromJson(Map<String, dynamic> json) {
    tblId = json['tblId'];
    date = json['date'];
    division = json['division'];
    subject = json['subject'];
    topic = json['topic'];
    chapter = json['chapter'];
    courseSubjectId = json['courseSubjectId'];
    status = json['status'];
    seenCount = json['seenCount'];
    unSeenCount = json['unSeenCount'];
    if (json['viewedList'] != null) {
      viewedList = <StudViewedorNotList>[];
      json['viewedList'].forEach((v) {
        viewedList!.add(new StudViewedorNotList.fromJson(v));
      });
    }
    if (json['notViewedList'] != null) {
      notViewedList = <StudViewedorNotList>[];
      json['notViewedList'].forEach((v) {
        notViewedList!.add(new StudViewedorNotList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tblId'] = this.tblId;
    data['date'] = this.date;
    data['division'] = this.division;
    data['subject'] = this.subject;
    data['topic'] = this.topic;
    data['chapter'] = this.chapter;
    data['courseSubjectId'] = this.courseSubjectId;
    data['status'] = this.status;
    data['seenCount'] = this.seenCount;
    data['unSeenCount'] = this.unSeenCount;
    if (this.viewedList != null) {
      data['viewedList'] = this.viewedList!.map((v) => v.toJson()).toList();
    }
    if (this.notViewedList != null) {
      data['notViewedList'] =
          this.notViewedList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class StudViewedorNotList {
  String? id;
  String? name;
  String? mobile;

  StudViewedorNotList({this.id, this.name, this.mobile});

  StudViewedorNotList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}


//--Update----

class PortionUpdateRow {
  String? id;
  String? entryDate;
  String? courseId;
  String? division;
  String? course;
  List<PortionDivisions>? divisionList;
  List<PortionSubjects>? subjectList;
  List<PortionSubSubject>? optionalorSubSubjectList;
  String? topicList;
  String? topicId;
  List<Files>? file;
  List<PortionFiles>? mobileAppFile;
  List<String>? studentIds;
  String? divisionId;
  String? subjectId;
  String? courseSubjectId;
  String? optionalSubjectId;
  String? subjectName;
  String? subOrOptionalSubjectId;
  String? optionalOrSubSubjectName;
  String? subOrOptionalType;
  String? details;
  String? description;
  String? chapter;
  String? assignment;
  String? actualStudCount;


  PortionUpdateRow(
      {this.id,
        this.entryDate,
        this.courseId,
        this.division,
        this.course,
        this.divisionList,
        this.subjectList,
        this.optionalorSubSubjectList,
        this.topicList,
        this.topicId,
        this.file,
        this.mobileAppFile,
        this.studentIds,
        this.divisionId,
        this.subjectId,
        this.courseSubjectId,
        this.optionalSubjectId,
        this.subjectName,
        this.subOrOptionalSubjectId,
        this.optionalOrSubSubjectName,
        this.subOrOptionalType,
        this.details,
        this.description,
        this.chapter,
        this.assignment,
        this.actualStudCount});

  PortionUpdateRow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryDate = json['entryDate'];
    courseId = json['courseId'];
    division = json['division'];
    course = json['course'];
    if (json['divisionList'] != null) {
      divisionList = <PortionDivisions>[];
      json['divisionList'].forEach((v) {
        divisionList!.add(new PortionDivisions.fromJson(v));
      });
    }
    if (json['subjectList'] != null) {
      subjectList = <PortionSubjects>[];
      json['subjectList'].forEach((v) {
        subjectList!.add(new PortionSubjects.fromJson(v));
      });
    }
    if (json['optionalorSubSubjectList'] != null) {
      optionalorSubSubjectList = <PortionSubSubject>[];
      json['optionalorSubSubjectList'].forEach((v) {
        optionalorSubSubjectList!.add(new PortionSubSubject.fromJson(v));
      });
    }
    topicList = json['topicList'];
    topicId = json['topicId'];
    if (json['file'] != null) {
      file = <Files>[];
      json['file'].forEach((v) {
        file!.add(new Files.fromJson(v));
      });
    }
    if (json['mobileAppFile'] != null) {
      mobileAppFile = <PortionFiles>[];
      json['mobileAppFile'].forEach((v) {
        mobileAppFile!.add(new PortionFiles.fromJson(v));
      });
    }
    studentIds = json['studentIds'].cast<String>();
    divisionId = json['divisionId'];
    subjectId = json['subjectId'];
    courseSubjectId = json['courseSubjectId'];
    optionalSubjectId = json['optionalSubjectId'];
    subjectName = json['subjectName'];
    subOrOptionalSubjectId = json['subOrOptionalSubjectId'];
    optionalOrSubSubjectName = json['optionalOrSubSubjectName'];
    subOrOptionalType = json['subOrOptionalType'];
    details = json['details'];
    description = json['description'];
    chapter = json['chapter'];
    assignment = json['assignment'];
    actualStudCount = json['actualStudCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entryDate'] = this.entryDate;
    data['courseId'] = this.courseId;
    data['division'] = this.division;
    data['course'] = this.course;
    if (this.divisionList != null) {
      data['divisionList'] = this.divisionList!.map((v) => v.toJson()).toList();
    }
    if (this.subjectList != null) {
      data['subjectList'] = this.subjectList!.map((v) => v.toJson()).toList();
    }
    if (this.optionalorSubSubjectList != null) {
      data['optionalorSubSubjectList'] =
          this.optionalorSubSubjectList!.map((v) => v.toJson()).toList();
    }
    data['topicList'] = this.topicList;
    data['topicId'] = this.topicId;
    if (this.file != null) {
      data['file'] = this.file!.map((v) => v.toJson()).toList();
    }
    if (this.mobileAppFile != null) {
      data['mobileAppFile'] =
          this.mobileAppFile!.map((v) => v.toJson()).toList();
    }
    data['studentIds'] = this.studentIds;
    data['divisionId'] = this.divisionId;
    data['subjectId'] = this.subjectId;
    data['courseSubjectId'] = this.courseSubjectId;
    data['optionalSubjectId'] = this.optionalSubjectId;
    data['subjectName'] = this.subjectName;
    data['subOrOptionalSubjectId'] = this.subOrOptionalSubjectId;
    data['optionalOrSubSubjectName'] = this.optionalOrSubSubjectName;
    data['subOrOptionalType'] = this.subOrOptionalType;
    data['details'] = this.details;
    data['description'] = this.description;
    data['chapter'] = this.chapter;
    data['assignment'] = this.assignment;
    data['actualStudCount'] = this.actualStudCount;
    return data;
  }
}

class Files {
  PortionFiles? file;

  Files({this.file});

  Files.fromJson(Map<String, dynamic> json) {
    file = json['file'] != null ? new PortionFiles.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    return data;
  }
}

////-------------Approval------------------------//


class PortionApprovalModel {
  List<ApproveCourseList>? courseList;
  String? isExistApprovalSettings;
  String? isClassTeacher;

  PortionApprovalModel(
      {this.courseList, this.isExistApprovalSettings, this.isClassTeacher});

  PortionApprovalModel.fromJson(Map<String, dynamic> json) {
    if (json['courseList'] != null) {
      courseList = <ApproveCourseList>[];
      json['courseList'].forEach((v) {
        courseList!.add(new ApproveCourseList.fromJson(v));
      });
    }
    isExistApprovalSettings = json['isExistApprovalSettings'];
    isClassTeacher = json['isClassTeacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseList != null) {
      data['courseList'] = this.courseList!.map((v) => v.toJson()).toList();
    }
    data['isExistApprovalSettings'] = this.isExistApprovalSettings;
    data['isClassTeacher'] = this.isClassTeacher;
    return data;
  }
}

class ApproveCourseList {
  String? value;
  String? text;
  String? selected;
  String? active;
  String? order;

  ApproveCourseList({this.value, this.text, this.selected, this.active, this.order});

  ApproveCourseList.fromJson(Map<String, dynamic> json) {
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

//approval view

class PortionApprovalView {
  String? portionEntryId;
  String? date;
  String? division;
  String? staff;
  String? staffId;
  bool? isApproved;
  String? subject;
  String? remarks;
  String? optOrSubSubject;
  String? chapter;
  String? topic;
  bool? allowAppproval;
  List<PhotoList>? photoList;

  PortionApprovalView(
      {this.portionEntryId,
        this.date,
        this.division,
        this.staff,
        this.staffId,
        this.isApproved,
        this.subject,
        this.remarks,
        this.optOrSubSubject,
        this.chapter,
        this.topic,
        this.allowAppproval,
        this.photoList});

  PortionApprovalView.fromJson(Map<String, dynamic> json) {
    portionEntryId = json['portionEntryId'];
    date = json['date'];
    division = json['division'];
    staff = json['staff'];
    staffId = json['staffId'];
    isApproved = json['isApproved'];
    subject = json['subject'];
    remarks = json['remarks'];
    optOrSubSubject = json['optOrSubSubject'];
    chapter = json['chapter'];
    topic = json['topic'];
    allowAppproval = json['allowAppproval'];
    if (json['photoList'] != null) {
      photoList = <PhotoList>[];
      json['photoList'].forEach((v) {
        photoList!.add(new PhotoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portionEntryId'] = this.portionEntryId;
    data['date'] = this.date;
    data['division'] = this.division;
    data['staff'] = this.staff;
    data['staffId'] = this.staffId;
    data['isApproved'] = this.isApproved;
    data['subject'] = this.subject;
    data['remarks'] = this.remarks;
    data['optOrSubSubject'] = this.optOrSubSubject;
    data['chapter'] = this.chapter;
    data['topic'] = this.topic;
    data['allowAppproval'] = this.allowAppproval;
    if (this.photoList != null) {
      data['photoList'] = this.photoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotoList {
  PortionFiles? file;

  PhotoList({this.file});

  PhotoList.fromJson(Map<String, dynamic> json) {
    file = json['file'] != null ? new PortionFiles.fromJson(json['file']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    return data;
  }
}
//AprrovalDetials

class ApprovalDetails {
  String? portionEntryId;
  String? date;
  String? subject;
  String? chapter;
  String? topic;
  String? status;
  String? remarks;
  String? description;
  String? details;
  String? assignment;
  bool? allowApproval;
  List<PortionFiles>? photoList;

  ApprovalDetails({this.portionEntryId,
    this.date,
    this.subject,
    this.chapter,
    this.topic,
    this.status,
    this.remarks,
    this.description,
    this.details,
    this.assignment,
    this.allowApproval,
    this.photoList});

  ApprovalDetails.fromJson(Map<String, dynamic> json) {
    portionEntryId = json['portionEntryId'];
    date = json['date'];
    subject = json['subject'];
    chapter = json['chapter'];
    topic = json['topic'];
    status = json['status'];
    remarks = json['remarks'];
    details = json['details'];
    description = json['description'];
    assignment = json['assignment'];
    allowApproval = json['allowApproval'];
    if (json['photoList'] != null) {
      photoList = <PortionFiles>[];
      json['photoList'].forEach((v) {
        photoList!.add(new PortionFiles.fromJson(v));
      });
    }
  }
}
