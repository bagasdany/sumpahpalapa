class Message {
  final String? text;
  final int? userId;
  final int? isRead;
  final bool? isSent;
  final DateTime? sendDateTime;
  bool? isNew;

  Message(
      {this.text,
      this.userId,
      this.isRead,
      this.isSent,
      this.sendDateTime,
      this.isNew = true});
}
