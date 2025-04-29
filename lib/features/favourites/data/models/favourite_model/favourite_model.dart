// class FavouriteModel {
//   final String id;
//   final String category;
//   final String createdAt;
//   final String description;
//   final String instructorId;
//   final bool isFav;
//   final String picture;
//   final num price;
//   final List<num> rates;
//   final num rating;
//   final String title;
//
//   FavouriteModel({
//     required this.id,
//     required this.category,
//     required this.createdAt,
//     required this.description,
//     required this.instructorId,
//     required this.isFav,
//     required this.picture,
//     required this.price,
//     required this.rates,
//     required this.rating,
//     required this.title,
//   });
//
//   factory FavouriteModel.fromJson(Map<String, dynamic> json) {
//     return FavouriteModel(
//       id: json['_id'],
//       category: json['category'],
//       createdAt: json['createdAt'],
//       description: json['description'],
//       instructorId: json['instructorId'],
//       isFav: json['isFav'],
//       picture: json['picture'],
//       price: json['price'] as num,
//       rates: List<num>.from(json['rates']),
//       rating: json['rating'] as num,
//       title: json['title'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'category': category,
//       'createdAt': createdAt,
//       'description': description,
//       'instructorId': instructorId,
//       'isFav': isFav,
//       'picture': picture,
//       'price': price,
//       'rates': rates,
//       'rating': rating,
//       'title': title,
//     };
//   }
// }