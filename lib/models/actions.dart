import 'package:timeago/timeago.dart' as timeago;

class ActionModel {
  final String verb;
  final String action;
  final String time;
  ActionModel({
    required this.verb,
    required this.action,
    required this.time,
  });

  factory ActionModel.fromMap(Map map) {
    return ActionModel(
      verb: (map['verb'] ?? '') as String,
      action: (map['action'] ?? '') as String,
      time: timeago.format(DateTime.parse(map['created'] as String)),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActionModel &&
        other.verb == verb &&
        other.action == action &&
        other.time == time;
  }

  @override
  int get hashCode => verb.hashCode ^ action.hashCode ^ time.hashCode;
}
