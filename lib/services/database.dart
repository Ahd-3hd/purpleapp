import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSerivce {
  //collection reference
  String categoryValue;
  String keyword;
  DatabaseSerivce({this.categoryValue, this.keyword});
  final CollectionReference postsCollection =
      Firestore.instance.collection('posts');
  // create post
  Future createPost(String userid, String title, String desc, String category,
      List keywords, String imageurl, String location, String price) async {
    return await postsCollection.document().setData({
      'userid': userid,
      'title': title,
      'desc': desc,
      'category': category,
      'keyword': keywords,
      'imgurl': imageurl,
      'location': location,
      'price': price
    });
  }

  // get posts from database
  Stream<QuerySnapshot> get thePosts {
    if (categoryValue != null && keyword != null || keyword.isNotEmpty) {
      return postsCollection
          .where('category', isEqualTo: categoryValue)
          .where('keyword', arrayContains: keyword)
          .orderBy('desc')
          .snapshots();
    } else if (categoryValue != null) {
      return postsCollection
          .where('category', isEqualTo: categoryValue)
          .orderBy('desc')
          .snapshots();
    } else if (keyword != null || keyword.isNotEmpty) {
      return postsCollection
          .where('keyword', arrayContains: keyword)
          .orderBy('desc')
          .snapshots();
    }
    return postsCollection.orderBy('desc').snapshots();
  }
}
