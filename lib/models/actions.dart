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
}
