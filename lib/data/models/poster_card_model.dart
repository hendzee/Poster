import 'dart:convert';

class PosterCardModel {
  final String id;
  final String title;
  final String location;
  final String description;
  final String posterImage;
  final String userPhoto;
  final String startDate;
  final String endDate;

  PosterCardModel({
    this.id,
    this.title,
    this.location,
    this.description,
    this.posterImage,
    this.userPhoto,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'description': description,
      'image': posterImage,
      'photo': userPhoto,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  factory PosterCardModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PosterCardModel(
      id: map['id'].toString(),
      title: map['title'],
      location: map['location'],
      description: map['description'],
      posterImage: map['image'],
      userPhoto: map['photo'],
      startDate: map['start_date'],
      endDate: map['end_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PosterCardModel.fromJson(String source) =>
      PosterCardModel.fromMap(json.decode(source));
}
