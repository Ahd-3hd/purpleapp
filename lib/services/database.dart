import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSerivce {
  //collection reference
  final CollectionReference postsCollection =
      Firestore.instance.collection('posts');

  Future createPost(String userid, String title, String desc, String category,
      List keywords, String imageurl) async {
    return await postsCollection.document().setData({
      'userid': userid,
      'title': title,
      'desc': desc,
      'category': category,
      'keyword': keywords,
      'imgurl': imageurl
    });
  }
}
