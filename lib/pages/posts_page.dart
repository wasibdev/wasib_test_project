import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/comment_provider.dart';
import 'package:test_project/providers/post_provider.dart';
import 'package:test_project/utils/values.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  late PostProvider post;
  late CommentProvider commentList;
  @override
  void initState() {
    super.initState();
    var id = Random().nextInt(100).toString();
    post = Provider.of<PostProvider>(context, listen: false);
    commentList = Provider.of<CommentProvider>(context, listen: false);
    post.getPost(context,id);
    commentList.getComment(context,id);
  }

  @override
  Widget build(BuildContext context) {
    post = Provider.of<PostProvider>(context);
    commentList = Provider.of<CommentProvider>(context);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: primaryColor,
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  color: primaryColor,
                  iconSize: 40,
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
              ],
            ),
            Text(
              !post.loading?post.post.title:"Loading",
              style: GoogleFonts.nunitoSans(
                height: 1,
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            commentList.loading?Container():
            Expanded(
              child: ListView.builder(
                itemCount: commentList.commentList.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(commentList.commentList[index].body));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}