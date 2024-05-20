class TimeTableViewModel {
  String? value;
  String? text;
  String? fileId;
  String? classTTUploadId;

  TimeTableViewModel(
      {this.value, this.text, this.fileId, this.classTTUploadId});

  TimeTableViewModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    fileId = json['fileId'];
    classTTUploadId = json['classTTUploadId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    data['fileId'] = fileId;
    data['classTTUploadId'] = classTTUploadId;
    return data;
  }
}
