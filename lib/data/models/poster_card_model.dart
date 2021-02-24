import 'dart:convert';

class PosterCardModel {
  final String id;
  final String title;
  final String location;
  final String detailLocation;
  final String description;
  final String posterImage;
  final String userPhoto;
  final String startDate;
  final String endDate;
  final String website;
  final String facebook;
  final String twitter;
  final String instagram;
  final String price;

  PosterCardModel({
    this.id,
    this.title,
    this.location,
    this.detailLocation,
    this.description,
    this.posterImage,
    this.userPhoto,
    this.startDate,
    this.endDate,
    this.website,
    this.facebook,
    this.twitter,
    this.instagram,
    this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'detailLocation': detailLocation,
      'description': description,
      'posterImage': posterImage,
      'userPhoto': userPhoto,
      'startDate': startDate,
      'endDate': endDate,
      'website': website,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'price': price,
    };
  }

  factory PosterCardModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PosterCardModel(
      id: map['id'].toString(),
      title: map['title'],
      location: map['location'],
      detailLocation: map['detail_location'],
      description: map['description'],
      posterImage: map['image'],
      userPhoto: map['photo'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      website: map['website'],
      facebook: map['facebook'],
      twitter: map['twitter'],
      instagram: map['instagram'],
      price: map['price'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PosterCardModel.fromJson(String source) =>
      PosterCardModel.fromMap(json.decode(source));
}
