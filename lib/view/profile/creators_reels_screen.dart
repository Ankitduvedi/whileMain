import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:while_app/data/model/video_model.dart';
// import 'package:while_app/resources/components/videoPlayer/circle_animation.dart';

class CreatorReelsScreen extends StatefulWidget {
  const CreatorReelsScreen({
    super.key,
    required this.video,
    required this.index,
  });
  final Video video;
  final int index;
  @override
  State<CreatorReelsScreen> createState() => CreatorReelsScreenState();
}

class CreatorReelsScreenState extends State<CreatorReelsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late VideoPlayerController _controller;
  bool likeTapped = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    likeTapped = false;
    super.initState();
  }

  void addlikes(bool likeTapped) async {
    // DocumentReference ref = widget.video.videoRef as DocumentReference<Object?>;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('videos')
        .doc(widget.video.videoRef)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(user!.uid)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.video.videoRef)
          .update({
        'likes': FieldValue.arrayRemove([user!.uid])
      });
    } else {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.video.videoRef)
          .update({
        'likes': FieldValue.arrayUnion([user!.uid])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize();
    _controller.play();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(children: [
          VideoPlayer(_controller),
          // FloatingActionButton(
          //   backgroundColor: Colors.transparent,
          //   onPressed: () => Navigator.of(context).pop(),
          //   child: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          // ),
          Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.video.title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              widget.video.description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.music_note,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Text(
                                  'song name',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 350,
                      width: 100,
                      margin: EdgeInsets.only(top: size.height / 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // buildProfile('profilePhoto'),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    addlikes(likeTapped);
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color:
                                        widget.video.likes.contains(user!.uid)
                                            ? Colors.red
                                            : Colors.white,
                                    size: 30,
                                  )),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                widget.video.likes.length.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                          const InkWell(
                              child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 30,
                          )),

                          // CircleAnimation(
                          //     child: buildMusicAlbum('profile photo')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        ]),
      ),
    );
  }

  // buildProfile(String profilePhoto) {
  //   return SizedBox(
  //     width: 60,
  //     height: 60,
  //     child: Stack(
  //       children: [
  //         Positioned(
  //             left: 5,
  //             child: Container(
  //               width: 50,
  //               height: 50,
  //               padding: const EdgeInsets.all(11),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(25.0),
  //               ),
  //               child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(25.0),
  //                   child: const Image(
  //                     image: NetworkImage(
  //                       "https://images.unsplash.com/photo-1682685797498-3bad2c6e161a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
  //                     ),
  //                     fit: BoxFit.cover,
  //                   )),
  //             ))
  //       ],
  //     ),
  //   );
  // }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Container(
        padding: const EdgeInsets.all(11),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: const Image(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1682685797498-3bad2c6e161a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
