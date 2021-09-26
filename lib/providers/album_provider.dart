import 'dart:convert';
import 'dart:developer'as logging;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:test_project/models/album_model.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/utils/api.dart';
import 'package:test_project/utils/config.dart';

class AlbumProvider with ChangeNotifier {
  Album album = Album(id: 0, userId: 0, title: '', body: '');
  bool loading = false;

  getAlbum(context,id) async {
    loading = true;
    album = await fetchAlbum(context,id);
    loading = false;
    notifyListeners();
  }

  Future<Album> fetchAlbum(context,id) async {
    var url = Uri.parse(restUrl+albums+"/"+id);
    Album res = Album(id: 0, userId: 0, title: '', body: '');
    try {
      final response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        res = Album.fromJson(item);
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