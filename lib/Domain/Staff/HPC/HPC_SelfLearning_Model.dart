

class Learning {
   int? order;
   String? learningName;
   String? learningId;

  Learning({this.order, this.learningName, this.learningId});

  factory Learning.fromJson(Map<String, dynamic> json) {
    return Learning(
      order: json['order'] as int?,
      learningName: json['learningName'] as String?,
      learningId: json['learningId'] as String?,
    );
  }
}

class StudentLearning {
   String? learningId;
   String? remarks;

  StudentLearning({this.learningId, this.remarks});

  factory StudentLearning.fromJson(Map<String, dynamic> json) {
    return StudentLearning(
      learningId: json['learningId'] as String?,
      remarks: json['remarks'] as String?,
    );
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
class StudentEntrySelfLearning {
   Map<String, StudentLearning>? studentLearnings;
   List<PeerStudents>? peerStudents;
   String? studentName;
   String? admissionNo;
   String? entryStaffName;
   String? entryDate;
   int? rollNo;
   String? studentId;
   String? peerStudentId;
   String? learningEntryId;
   bool? isEdited;
   bool? isDisabled;
   String? entryStatus;
   bool? isAttendanceDisabled;

   StudentEntrySelfLearning({
    this.studentLearnings,
    this.peerStudents,
    this.studentName,
    this.admissionNo,
    this.entryStaffName,
    this.entryDate,
    this.rollNo,
    this.studentId,
    this.peerStudentId,
    this.learningEntryId,
    this.isEdited,
    this.isDisabled,
    this.entryStatus,
    this.isAttendanceDisabled,
  });

   factory StudentEntrySelfLearning.fromJson(Map<String, dynamic> json) {
     final studentLearningsJson = json['studentLearnings'] as Map<String, dynamic>?;

     Map<String, StudentLearning>? studentLearnings;
     if (studentLearningsJson != null) {
       studentLearnings = studentLearningsJson.map((key, value) {
         return MapEntry(key, StudentLearning.fromJson(value));
       });
     }

     // Parse peerStudents as List<PeerStudents>
     List<PeerStudents>? peerStudents;
     if (json['peerStudents'] != null) {
       peerStudents = (json['peerStudents'] as List).map((peerJson) {
         return PeerStudents.fromJson(peerJson); // Assuming PeerStudents has a fromJson method
       }).toList();
     }

     return StudentEntrySelfLearning(
       studentLearnings: studentLearnings,
       peerStudents: peerStudents,
       studentName: json['studentName'] as String?,
       admissionNo: json['admissionNo'] as String?,
       entryStaffName: json['entryStaffName'] as String?,
       entryDate: json['entryDate'] as String?,
       rollNo: json['rollNo'] as int?,
       studentId: json['studentId'] as String?,
       peerStudentId: json['peerStudentId'] as String?,
       learningEntryId: json['learningEntryId'] as String?,
       isEdited: json['isEdited'] as bool?,
       isDisabled: json['isDisabled'] as bool?,
       entryStatus: json['entryStatus'] as String?,
       isAttendanceDisabled: json['isAttendanceDisabled'] as bool?,
     );
   }

}

class AssessmentEntry {
   List<StudentEntrySelfLearning>? studentEntries;
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

  AssessmentEntry({
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

  factory AssessmentEntry.fromJson(Map<String, dynamic> json) {
    final studentEntriesJson = json['studentEntries'] as List<dynamic>?;
    List<StudentEntrySelfLearning>? studentEntries;

    if (studentEntriesJson != null) {
      studentEntries = studentEntriesJson
          .map((entry) => StudentEntrySelfLearning.fromJson(entry as Map<String, dynamic>))
          .toList();
    }

    return AssessmentEntry(
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

class AssessmentData {
   List<Learning>? learnings;
   AssessmentEntry? assessmentEntry;

  AssessmentData({this.learnings, this.assessmentEntry});

  factory AssessmentData.fromJson(Map<String, dynamic> json) {
    final learningsJson = json['learnings'] as List<dynamic>?;
    List<Learning>? learnings;

    if (learningsJson != null) {
      learnings = learningsJson
          .map((learning) => Learning.fromJson(learning as Map<String, dynamic>))
          .toList();
    }

    return AssessmentData(
      learnings: learnings,
      assessmentEntry: json['assessmentEntry'] != null
          ? AssessmentEntry.fromJson(json['assessmentEntry'])
          : null,
    );
  }
}
