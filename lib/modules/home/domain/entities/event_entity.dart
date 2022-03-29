class EventEntity {
  late String name;
  late String speaker;
  late DateTime date;

  EventEntity({
    required this.name,
    required this.speaker,
    required this.date,
  });

  EventEntity.fromJson(Map<String, dynamic> json) {
    var _date = DateTime.parse(json['date']);
    date = DateTime(_date.year, _date.month, _date.day);
    name = json['name'];
    speaker = json['speaker'];
  }
}
