import 'package:equatable/equatable.dart';

class Fate extends Equatable {
  final String text;

  const Fate({
    required this.text,
  });

  @override
  List<Object> get props => [text];
}
