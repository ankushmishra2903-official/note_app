class NoteModel {
  final String? id, userId, title, content;
  final DateTime? dateAdded;

  NoteModel({
    this.id,
    this.title,
    this.content,
    this.dateAdded,
    this.userId,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'].toString(),
      title: map['title'],
      content: map['content'],
      dateAdded: DateTime.tryParse(map['date_added']),
      userId: map['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id" : id,
      "title" : title,
      "content" : content,
      "date_added" : dateAdded!.toIso8601String(),
      "user_id" : userId,
    };
  }
}
