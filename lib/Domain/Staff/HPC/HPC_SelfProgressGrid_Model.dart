

class AblitiesGrid {
  String? ablityId;
  String? ablityName;
  int? ablityOrder;
  String? responseLevelId;

  AblitiesGrid(
      {this.ablityId, this.ablityName, this.ablityOrder, this.responseLevelId});

  AblitiesGrid.fromJson(Map<String, dynamic> json) {
    ablityId = json['ablityId'];
    ablityName = json['ablityName'];
    ablityOrder = json['ablityOrder'];
    responseLevelId = json['responseLevelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ablityId'] = this.ablityId;
    data['ablityName'] = this.ablityName;
    data['ablityOrder'] = this.ablityOrder;
    data['responseLevelId'] = this.responseLevelId;
    return data;
  }
}
class PeerStudents {
  String? studentId;
  String? studentName;

  PeerStudents({this.studentId, this.studentName});

  PeerStudents.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    studentName = json['studentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    return data;
  }
}
class StudentEntry {
   String? studentName;
   List<PeerStudents>? peerStudents;
   String? admissionNo;
   String? entryStaffName;
   String? entryDate;
   int? rollNo;
   String? studentId;
   String? peerStudentId;
   String? progressGridEntryId;
   bool? isEdited;
   bool? isDisabled;
   String? entryStatus;
   bool? isAttendanceDisabled;
   Map<String, ProgressGrid>? progressGrids;

  StudentEntry({
    this.studentName,
    this.peerStudents,
    this.admissionNo,
    this.entryStaffName,
    this.entryDate,
    this.rollNo,
    this.studentId,
    this.peerStudentId,
    this.progressGridEntryId,
     this.isEdited,
     this.isDisabled,
    this.entryStatus,
     this.isAttendanceDisabled,
    this.progressGrids,
  });

  factory StudentEntry.fromJson(Map<String, dynamic> json) {
    return StudentEntry(
      studentName: json['studentName'] as String?,
      peerStudents: (json['peerStudents'] as List<dynamic>?)
          ?.map((e) => PeerStudents.fromJson(e as Map<String, dynamic>))
          .toList(),
      admissionNo: json['admissionNo'] as String?,
      entryStaffName: json['entryStaffName'] as String?,
      entryDate: json['entryDate'] as String?,
      rollNo: json['rollNo'] as int?,
      studentId: json['studentId'] as String?,
      peerStudentId: json['peerStudentId'] as String?,
      progressGridEntryId: json['progressGridEntryId'] as String?,
      isEdited: json['isEdited'] as bool? ?? false,
      isDisabled: json['isDisabled'] as bool? ?? false,
      entryStatus: json['entryStatus'] as String?,
      isAttendanceDisabled: json['isAttendanceDisabled'] as bool? ?? false,
      progressGrids: (json['progressGrids'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, ProgressGrid.fromJson(value))),
    );
  }


}


class ProgressGridList {
  List<StudentEntry>? studentEntries;
  String? assessmentTypeId;
  String? assessmentTypeName;
  String? course;
  String? stage;
  String? part;
  String? courseDomain;
  String? domain;
  String? activity;
  String? term;
  String? division;
  String? assessmentEntryId;
  String? entryDate;
  String? search;
  String? entryStatus;
  String? updatedStaff;
  String? verifyStaff;
  bool? includeTerminatedStudents;


  ProgressGridList({
    this.studentEntries,
    this.assessmentTypeId,
    this.assessmentTypeName,
    this.course,
    this.stage,
    this.part,
    this.courseDomain,
    this.domain,
    this.activity,
    this.term,
    this.division,
    this.assessmentEntryId,
    this.entryDate,
    this.search,
    this.entryStatus,
    this.updatedStaff,
    this.verifyStaff,
    this.includeTerminatedStudents,
  });

  factory ProgressGridList.fromJson(Map<String, dynamic> json) {
    final studentEntriesJson = json['studentEntries'] as List<dynamic>?;
    List<StudentEntry>? studentEntries;

    if (studentEntriesJson != null) {
      studentEntries = studentEntriesJson
          .map((entry) => StudentEntry.fromJson(entry as Map<String, dynamic>))
          .toList();
    }

    return ProgressGridList(
      studentEntries: studentEntries,
      assessmentTypeId: json['assessmentTypeId'] as String?,
      assessmentTypeName: json['assessmentTypeName'] as String?,
      course: json['course'] as String?,
      stage: json['stage'] as String?,
      part: json['part'] as String?,
      courseDomain: json['courseDomain'] as String?,
      domain: json['domain'] as String?,
      activity: json['activity'] as String?,
      term: json['term'] as String?,
      division: json['division'] as String?,
      assessmentEntryId: json['assessmentEntryId'] as String?,
      entryDate: json['entryDate'] as String?,
      search: json['search'] as String?,
      entryStatus: json['entryStatus'] as String?,
      updatedStaff: json['updatedStaff'] as String?,
      verifyStaff: json['verifyStaff'] as String?,
      includeTerminatedStudents: json['includeTerminatedStudents'] as bool?,
    );
  }
}
class ProgressGrid {
  final String? abilityId;
  final List<String>? progressGridIdList;
  final List<ProgressGridProgressGridList>? progressGridList;

  ProgressGrid({
    this.abilityId,
    this.progressGridIdList,
    this.progressGridList,
  });

  factory ProgressGrid.fromJson(Map<String, dynamic> json) {
    return ProgressGrid(
      abilityId: json['abilityId'] as String?,
      progressGridIdList:
      (json['progressGridIdList'] as List?)?.map((e) => e as String).toList(),
      progressGridList: (json['progressGridList'] as List<dynamic>?)
          ?.map((item) => ProgressGridProgressGridList.fromJson(item))
          .toList(),
    );
  }
}


class ProgressGridProgressGridList {
  bool? checked;
  String? progressGridId;
  String? progressGridName;
  int? progressGridOrder;
  String? abilityId;

  ProgressGridProgressGridList({
    this.checked,
    this.progressGridId,
    this.progressGridName,
    this.progressGridOrder,
    this.abilityId,
  });

  factory ProgressGridProgressGridList.fromJson(Map<String, dynamic> json) {
    return ProgressGridProgressGridList(
      checked: json['checked'],
      progressGridId: json['progressGridId'],
      progressGridName: json['progressGridName'],
      progressGridOrder: json['progressGridOrder'],
      abilityId: json['abilityId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checked': checked,
      'progressGridId': progressGridId,
      'progressGridName': progressGridName,
      'progressGridOrder': progressGridOrder,
      'abilityId': abilityId,
    };
  }
}
