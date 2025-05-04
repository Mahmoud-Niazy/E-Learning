class NotificationModel {
  final String? id;
  final String? recipient;
  final String? type;
  final String? course;
  final String? lecture;
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
      course: json['course'] as String?,
      lecture: json['lecture'] as String?,
      count: json['count'] as num?,
      seen: json['seen'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipient': recipient,
      'type': type,
      'course': course,
      'lecture': lecture,
      'count': count,
      'seen': seen,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
