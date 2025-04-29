class CourseResponseModel {
  final String? id;
  final String? instructorId;
  final String? title;
  final String? description;
  final num? price;
  final String? picture;
  final String? category;
  final List<num>? rates;
  final num? rating;
  final num? lecturesCount;
  final String? createdAt;
  final String? videoIntroduction;
  final String? overviewPlaybackUrl;
  final CourseInstructorResponse? instructorDetails;

  CourseResponseModel({
    this.id,
    this.instructorId,
    this.title,
    this.description,
    this.price,
    this.picture,
    this.category,
    this.rates,
    this.rating,
    this.lecturesCount,
    this.createdAt,
    this.videoIntroduction,
    this.overviewPlaybackUrl,
    this.instructorDetails,
  });

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseResponseModel(
      id: json['id'],
      instructorId: json['instructorId'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      picture: json['picture'],
      category: json['category'],
      rates: (json['rates'] as List<dynamic>?)?.map((e) => e as num).toList(),
      rating: json['rating'],
      lecturesCount: json['lecturesCount'],
      createdAt: json['createdAt'],
      videoIntroduction: json['overview'],
      overviewPlaybackUrl: json['overviewPlaybackUrl'],
      instructorDetails: json['instructorDetails'] != null
          ? CourseInstructorResponse.fromJson(json['instructorDetails'])
          : null,
    );
  }
}

class CourseInstructorResponse {
  final String? name;
  final String? userProfileImage;

  CourseInstructorResponse({this.name, this.userProfileImage});

  factory CourseInstructorResponse.fromJson(Map<String, dynamic> json) {
    return CourseInstructorResponse(
      name: json['name'],
      userProfileImage: json['userProfileImage'],
    );
  }
}




// class CourseResponseModel {
//   final String? id;
//   final String? title;
//   final String? description;
//   final num? price;
//   final String? picture;
//   final String? category;
//   final List<num>? rates;
//   final num? rating;
//   final num? lecturesCount;
//   final String? createdAt;
//   final CourseInstructorResponse? instructorDetails;
//   final bool? isFav;
//   final String? videoIntroduction;
//
//   CourseResponseModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.picture,
//     required this.category,
//     required this.rates,
//     required this.rating,
//     required this.lecturesCount,
//     required this.createdAt,
//     required this.instructorDetails,
//     required this.isFav,
//     required this.videoIntroduction,
//   });
//
//   factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
//     List<num> rates = [];
//     for(var rate in json['rates']){
//       rates.add(rate);
//   }
//     return CourseResponseModel(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       price: json['price'],
//       picture: json['picture'],
//       category: json['category'],
//       rates: rates,
//       rating: json['rating'],
//       lecturesCount: json['lecturesCount'],
//       createdAt: json['createdAt'],
//       instructorDetails:
//       json['instructorDetails'] == null ?
//           null :
//       CourseInstructorResponse.fromJson(json['instructorDetails']),
//       isFav: json['isFav'],
//       videoIntroduction: json['overview']
//     );
//   }
// }
//
// class CourseInstructorResponse {
//   final String? userProfileImage;
//   final String? id;
//   final String? name;
//
//   CourseInstructorResponse({
//     required this.userProfileImage,
//     required this.id,
//     required this.name,
//   });
//
//   factory CourseInstructorResponse.fromJson(Map<String, dynamic> json) {
//     return CourseInstructorResponse(
//       userProfileImage: json['userProfileImage'],
//       id: json['_id'],
//       name: json['name'],
//     );
//   }
// }
