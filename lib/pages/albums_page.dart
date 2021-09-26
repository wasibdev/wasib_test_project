import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test_project/models/photos_model.dart';
import 'package:test_project/providers/album_provider.dart';
import 'package:test_project/providers/photos_provider.dart';
import 'package:test_project/utils/values.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);
  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  bool imageReady = false;
  late XFile? imageFile;
  late AlbumProvider album;
  late PhotosProvider photosList;
  var id = Random().nextInt(100).toString();
  @override
  void initState() {
    super.initState();
    album = Provider.of<AlbumProvider>(context, listen: false);
    photosList = Provider.of<PhotosProvider>(context, listen: false);
    album.getAlbum(context, id);
    photosList.getPhotos(context, id);
  }

  @override
  Widget build(BuildContext context) {
    album = Provider.of<AlbumProvider>(context);
    photosList = Provider.of<PhotosProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      body: SafeArea(
        child: Column(
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
                    color: whiteColor,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Text(
                    'Album',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      height: 1,
                      color: whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: whiteColor,
                    iconSize: 30,
                    onPressed: () {
                      getImageFromGallery(id);
                    },
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
            ),
            !album.loading
                ? Container(
                    margin: const EdgeInsets.all(16),
                    child: Text(
                      album.album.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        height: 1,
                        color: whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                : Container(),
            photosList.loading
                ? Container()
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(2),
                        itemCount: photosList.photosList.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          Photos photo = photosList.photosList[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: boxColor,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: photo.networkImage?
                                  Image.network(photo.url)
                                      :Image.file(File(photo.url)),
                                ),
                                const SizedBox(height: 8,),
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image: DecorationImage(
                                          image: photo.networkImage?
                                          NetworkImage(photo.thumbnailUrl)
                                          :FileImage(File(photo.thumbnailUrl)) as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                                        border: Border.all(
                                          color: whiteColor,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8,),
                                    Expanded(child: Text(
                                      photo.title,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.nunitoSans(
                                        height: 1,
                                        color: whiteColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> getImageFromGallery(id) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = image;
      Photos photo = Photos(
          id: photosList.photosList.length,
          albumId: int.parse(id),
          title: 'Photo From Gallery',
          url: image.path,
          thumbnailUrl: image.path,
          networkImage: false);
      photosList.updatePhotos(photo);
    }
  }
}
