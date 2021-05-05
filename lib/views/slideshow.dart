import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Slideshow extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  int _index = 0;

  @override
  void initState() {

    
    getSlideshowImageFromdb();
    super.initState();
  }

  Future getSlideshowImageFromdb() async {
    var _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await _firestore.collection('posts').limit(5).get();
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: getSlideshowImageFromdb(),
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 2.0, right: 2.0),
                      child: CarouselSlider.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index, _) {
                          DocumentSnapshot slideimagesnap =
                              snapshot.data[index];
                          Map getImage = slideimagesnap.data();
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Image.network(
                              getImage['postUrl'],
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                        options: CarouselOptions(
                            height: 250,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            autoPlay: true,
                            scrollDirection: Axis.horizontal,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            onPageChanged: (int i, carousePageChangedReason) {
                              setState(() {
                                _index = i;
                              });
                            }),
                      ),
                    );
            }),
      ],
    );
  }
}
