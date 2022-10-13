class Faw{
  late final int id ;
  late final String name;
  late final String phone;
  late final String date;
  late final String day;
  late final String hour;
  late final String type;
  late final String notes;
  late final String money;
  late final String weekly;

  Faw({
    required this.id,
    required this.name,
    required this.phone,
    required this.date,
    required this.day,
    required this.hour,
    required this.type,
    required this.notes,
    required this.money,
    required this.weekly
});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "phone": phone,
      "date": date,
      "day": day,
      "hour": hour,
      "type": type,
      "notes": notes,
      "money": money,
      "weekly": weekly,
    };
  }

  @override
  String toString() {
    return 'Faw{id: $id, name: $name, phone: $phone, date: $date, day: $day, hour: $hour, type: $type, notes: $notes, money: $money, weekly: $weekly}';
  }
}

