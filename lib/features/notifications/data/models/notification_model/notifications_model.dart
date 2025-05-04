class NotificationModel {
  final String? id;
  final String? recipient;
  final String? type;
  final Course? course;
  final Lecture? lecture;
  final num? count;
  final bool? seen;
  final String? createdAt;
  final String? updatedAt;

  NotificationModel({
    this.id,
    this.recipient,
    this.type,
    this.course,
    this.lecture,
    this.count,
    this.seen,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String?,
      recipient: json['recipient'] as String?,
      type: json['type'] as String?,
      course: json['course'] != null ? Course.fromJson(json['course']) : null,
      lecture: json['lecture'] != null ? Lecture.fromJson(json['lecture']) : null,
      count: json['count'] as num?,
      seen: json['seen'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class Course {
  final String? id;
  final String? title;
  final String? picture;

  Course({
    this.id,
    this.title,
    this.picture,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      picture: json['picture'] as String?,
    );
  }
}

class Lecture {
  final String? id;
  final String? title;
  final String? thumbnailUrl;

  Lecture({
    this.id,
    this.title,
    this.thumbnailUrl,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );
  }
}
