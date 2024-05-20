class DiaryList {
  String? uploadedDate;
  String? name;
  String? remarksDate;
  String? category;
  String? remarks;
  bool? isImportant;

  DiaryList(
      {this.uploadedDate,
      this.name,
      this.remarksDate,
      this.category,
      this.remarks,
      this.isImportant});

  DiaryList.fromJson(Map<String, dynamic> json) {
    uploadedDate = json['uploadedDate'];
    name = json['name'];
    remarksDate = json['remarksDate'];
    category = json['category'];
    remarks = json['remarks'];
    isImportant = json['isImportant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uploadedDate'] = uploadedDate;
    data['name'] = name;
    data['remarksDate'] = remarksDate;
    data['category'] = category;
    data['remarks'] = remarks;
    data['isImportant'] = isImportant;
    return data;
  }
}
