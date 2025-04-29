class Lecture {
  final String? id;
  final String? title;
  final num? lectureNumber;

  Lecture({
    required this.id,
    required this.title,
    required this.lectureNumber,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      lectureNumber: json['lectureNumber'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'lectureNumber': lectureNumber,
    };
  }
}

class NoteModel {
  final String? id;
  final String? note;
  final num? videoSeconds;
  final Lecture? lecture;

  NoteModel({
    required this.id,
    required this.note,
    required this.videoSeconds,
    required this.lecture,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String?,
      note: json['note'] as String?,
      videoSeconds: json['videoSeconds'] as num?,
      lecture: Lecture.fromJson(json['lecture']),
    );
  }

}
