class LectureResponseModel {
  final String? lectureId;
  final String? title;
  final String? description;
  final String? videoUrl;
  final String? thumbnailUrl;
  final String? courseId;
  final num? lectureNumber;
  final String? instructorId;
  // final List<num>? rates;
  // final num? rating;
  final String? createdAt;
  final num? duration;

  LectureResponseModel({
    required this.lectureId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.courseId,
    required this.lectureNumber,
    required this.instructorId,
    // required this.rates,
    // required this.rating,
    required this.createdAt,
    required this.duration,
  });

  factory LectureResponseModel.fromJson(Map<String, dynamic> json) {
    return LectureResponseModel(
      lectureId: json['lectureId'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      courseId: json['courseId'],
      lectureNumber: json['lectureNumber'],
      instructorId: json['instructorId'],
      // rates: List<num>.from(json['rates']),
      // rating: json['rating'],
      createdAt: json['createdAt'],
      duration: json['duration'] != null ? num.parse((json['duration'] / 60).toString()).round() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lectureId': lectureId,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'courseId': courseId,
      'lectureNumber': lectureNumber,
      'instructorId': instructorId,
      // 'rates': rates,
      // 'rating': rating,
      'createdAt': createdAt,
      'duration': duration,
    };
  }
}
