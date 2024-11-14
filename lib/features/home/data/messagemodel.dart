class Messagemodel {
  final String message;
  final dynamic date;
  final String sender;

  Messagemodel(
      {required this.message, required this.date, required this.sender});

  factory Messagemodel.fromjson(json) {
    return Messagemodel(
        message: json['message'],
        date: json['Created At'],
        sender: json['sender']);
  }
}
