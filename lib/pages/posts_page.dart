import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/comment_model.dart';
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
  final myController = TextEditingController();
  var id = Random().nextInt(100).toString();
  @override
  void initState() {
    super.initState();
    post = Provider.of<PostProvider>(context, listen: false);
    commentList = Provider.of<CommentProvider>(context, listen: false);
    post.getPost(context,id);
    commentList.getComment(context,id);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    post = Provider.of<PostProvider>(context);
    commentList = Provider.of<CommentProvider>(context);
    return Scaffold(
      backgroundColor: bg2Color,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: text1Color,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text(
                    'Post',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      height: 1,
                      color: text1Color,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: text1Color,
                    iconSize: 30,
                    onPressed: () {
                      showSheet();
                    },
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            !post.loading
                ? Container(
              margin: const EdgeInsets.all(16),
              child: Text(
                post.post.title,
                textAlign: TextAlign.start,
                style: GoogleFonts.nunitoSans(
                  height: 1,
                  color: text1Color,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ) : Container(),
            !post.loading
                ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.post.body,
                textAlign: TextAlign.start,
                style: GoogleFonts.nunitoSans(
                  height: 1,
                  color: blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ) : Container(),
            Container(
              margin: const EdgeInsets.only(left: 16,top: 24),
              child: Text(
                'Comments',
                textAlign: TextAlign.start,
                style: GoogleFonts.nunitoSans(
                  height: 1,
                  color: blackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            commentList.loading?Container():
            Expanded(
              child: ListView.builder(
                itemCount: commentList.commentList.length,
                itemBuilder: (context, index) {
                  Comment comment = commentList.commentList[index];
                  return Container(
                    margin: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Text(
                              comment.name.substring(0,1).toUpperCase(),
                              style: const TextStyle(
                                color: whiteColor,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                            border: Border.all(
                              color: whiteColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.name,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunitoSans(
                                color: blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              comment.email,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunitoSans(
                                color: const Color(0xff7c94b6),
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              comment.body,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunitoSans(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSheet(){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16,),
              Text(
                'Comment',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  height: 1,
                  color: text1Color,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),

              Container(
                margin: const EdgeInsets.all(16),
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Comment here'
                  ),
                  autofocus: true,
                  controller: myController,
                ),
              ),
              TextButton(
                  onPressed: () {
                    String cmt = myController.text.toString();
                    if(cmt.isNotEmpty){
                      Comment newComment = Comment(id: commentList.commentList.length,
                          postId: int.parse(id),
                          name: 'sample name',
                          email: 'sample email',
                          body: cmt
                      );
                      commentList.updateComment(newComment);
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(text1Color),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      )
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 40,right: 40,top: 12,bottom: 12),
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        height: 1,
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 30,),
            ],
          );
        });
  }
}