import '../../domain/entities/fate.dart';

class FateModel extends Fate {
  FateModel({
    required String text,
  }) : super(text: text);

  factory FateModel.fromJson(Map<String, dynamic> json) {
    return FateModel(
      text: json['reading'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reading': text,
    };
  }
}
