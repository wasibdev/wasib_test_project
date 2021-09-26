import 'dart:convert';
import 'dart:developer'as logging;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/models/comment_model.dart';
import 'package:test_project/utils/api.dart';
import 'package:test_project/utils/config.dart';

class CommentProvider with ChangeNotifier {
  List<Comment> commentList = [];
  bool loading = false;

  getComment(context,postId) async {
    loading = true;
    commentList = await fetchComment(context,postId);
    loading = false;
    notifyListeners();
  }

  Future<List<Comment>> fetchComment(context,postId) async {
    var url = Uri.parse(restUrl+comments+"?"+postIdFilter+postId);
    List<Comment> res = [];
    try {
      final response = await http.get(url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        res = list.map((model) => Comment.fromJson(model)).toList();
      } else {
        logging.log(response.body);
        showToast('comment not found');
      }
    } catch (e) {
      logging.log(e.toString());
    }
    return res;
  }
}