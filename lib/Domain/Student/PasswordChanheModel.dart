class PasswordModel {
  PasswordModel({
    this.oldPasswordCorrect,
  });

  String? oldPasswordCorrect;

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
        oldPasswordCorrect: json["oldPasswordCorrect"],
      );

  Map<String, dynamic> toJson() => {
        "oldPasswordCorrect": oldPasswordCorrect,
      };
}
