import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modules/services.dart';

abstract class AddPosterRepository {
  Future<String> addPoster({
    String userId,
    String country,
    String category,
    String title,
    String photo,
    String description,
    String location,
    String detailLocation,
    String startDate,
    String endDate,
    String price,
    String twitter,
    String facebook,
    String instagram,
  });
}

class ImpAddPosterRepository implements AddPosterRepository {
  @override
  Future<String> addPoster({
    String userId,
    String country,
    String category,
    String title,
    String photo,
    String description,
    String location,
    String detailLocation,
    String startDate,
    String endDate,
    String price,
    String twitter,
    String facebook,
    String instagram,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          Services.posters(),
        ),
      );

      request.fields['owner'] = userId;
      request.fields['country'] = country;
      request.fields['category'] = category;
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['location'] = location;
      request.fields['detail_location'] = detailLocation;
      request.fields['start_date'] = startDate;
      request.fields['end_date'] = endDate;
      request.fields['price'] = price;
      request.fields['twitter'] = twitter;
      request.fields['facebook'] = facebook;
      request.fields['instagram'] = instagram;

      request.files.add(await http.MultipartFile.fromPath('image', photo));

      http.Response response =
          await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        return 'SUCCESS';
      } else {
        var err = jsonDecode(response.body) != null
            ? jsonDecode(response.body)
            : Services.generealErrorMsg();
        throw (err['message']);
      }
    } catch (e) {
      throw (e);
    }
  }
}
