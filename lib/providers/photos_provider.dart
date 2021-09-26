import 'dart:convert';
import 'dart:developer'as logging;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/models/photos_model.dart';
import 'package:test_project/utils/api.dart';
import 'package:test_project/utils/config.dart';

class PhotosProvider with ChangeNotifier {
  List<Photos> photosList = [];
  bool loading = false;

  getPhotos(context,albumId) async {
    loading = true;
    photosList = await fetchPhotos(context,albumId);
    loading = false;
    notifyListeners();
  }

  Future<List<Photos>> fetchPhotos(context,albumId) async {
    var url = Uri.parse(restUrl+photos+"?"+albumIdFilter+albumId);
    List<Photos> res = [];
    try {
      final response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        res = list.map((model) => Photos.fromJson(model)).toList();
        logging.log(response.body);
      } else {
        logging.log(response.body);
        showToast('album not found');
      }
    } catch (e) {
      logging.log(e.toString());
    }
    return res;
  }
}