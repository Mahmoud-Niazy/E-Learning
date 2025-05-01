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
  final String? instructorId;

  CourseInstructorResponse({this.name, this.userProfileImage,this.instructorId});

  factory CourseInstructorResponse.fromJson(Map<String, dynamic> json) {
    return CourseInstructorResponse(
      name: json['name'],
      userProfileImage: json['userProfileImage'],
      instructorId: json['_id'],
    );
  }
}

/// {id: 680605dc203cca25af00285e, title: html, description: desc, price: 150, picture: https://res.cloudinary.com/dwpc6ln1q/image/upload/v1745225183/course_pictures/course_picture_6744e3caebed616ee1858995_680605dc203cca25af00285e.jpg, category: programming, rates: [0, 0, 0, 0, 0], rating: 0, lecturesCount: 0, createdAt: 2025-04-21T08:46:29.249Z, overview: https://res.cloudinary.com/dwpc6ln1q/video/upload/v1745225188/course_overviews/course_overview_6744e3caebed616ee1858995_680605dc203cca25af00285e.mp4, overviewPlaybackUrl: , instructorDetails: {userProfileImage: , _id: 6744e3caebed616ee1858995, name: string}, isFav: false}
// I/flutter ( 9380): {id: 680506681008580004ec4686, title: html, description: desc, price: 150, picture: https://res.cloudinary.com/dwpc6ln1q/image/upload/v1745159784/course_pictures/course_picture_6744e3caebed616ee1858995_680506681008580004ec4686.jpg, category: programming, rates: [0, 0, 0, 0, 0], rating: 0, lecturesCount: 6, createdAt: 2025-04-20T14:36:24.941Z, overview: , overviewPlaybackUrl: , instructorDetails: {userProfileImage: , _id: 6744e3caebed616ee1858995, name: string}, isFav: false}



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
