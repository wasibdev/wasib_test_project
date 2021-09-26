import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/album_provider.dart';
import 'package:test_project/providers/photos_provider.dart';
import 'package:test_project/utils/values.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);
  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {

  late AlbumProvider album;
  late PhotosProvider photosList;
  @override
  void initState() {
    super.initState();
    var id = Random().nextInt(100).toString();
    album = Provider.of<AlbumProvider>(context, listen: false);
    photosList = Provider.of<PhotosProvider>(context, listen: false);
    album.getAlbum(context,id);
    photosList.getPhotos(context,id);
  }

  @override
  Widget build(BuildContext context) {
    album = Provider.of<AlbumProvider>(context);
    photosList = Provider.of<PhotosProvider>(context);
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
              !album.loading?album.album.title:"Loading",
              style: GoogleFonts.nunitoSans(
                height: 1,
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            photosList.loading?Container():
            Expanded(
              child: ListView.builder(
                itemCount: photosList.photosList.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(photosList.photosList[index].title));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}