import 'package:uuid/uuid.dart';

class Step {
  final String? id;
  final String description;

  Step({
    String? id,
    required this.description,
  })  : assert(id == null || id.isNotEmpty),
        id = id ?? Uuid().v4();

  Step copyWith({String? id, String? description}) =>
      Step(id: id ?? this.id, description: description ?? this.description);
}
