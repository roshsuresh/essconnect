class FeedbackModel {
  String? value;
  String? text;
  bool? selected;
  bool? active;
  int? order;

  FeedbackModel({
    this.value,
    this.text,
    this.selected,
    this.active,
    this.order,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      value: json['value'] as String?,
      text: json['text'] as String?,
      selected: json['selected'] as bool?,
      active: json['active'] as bool?,
      order: json['order'] != null ? json['order'] as int : null, // Handling potential null value
    );
  }
}

class FeedbackSubmissionModel {
  final String? categoryId;
  final String? matter;

  FeedbackSubmissionModel({
    required this.categoryId,
    required this.matter,
  });

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'matter': matter,
  };
}

class fbm {
  String? value;
  String? text;
  Null? selected;
  Null? active;
  int? order;

  fbm({this.value, this.text, this.selected, this.active, this.order});

  fbm.fromJson(Map<String, dynamic> json) {
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