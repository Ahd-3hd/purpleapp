import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSerivce {
  final String uid;
  //collection reference
  String categoryValue;
  String keyword;
  DatabaseSerivce({this.categoryValue, this.keyword, this.uid});
  final CollectionReference postsCollection =
      Firestore.instance.collection('posts');
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
  // create post
  Future createPost(String userid, String title, String desc, String category,
      List keywords, String imageurl, String location, String price) async {
    await usersCollection
        .document(userid)
        .get()
        .then((value) => print(value.data));
    return await postsCollection.document().setData({
      'userid': userid,
      'title': title,
      'desc': desc,
      'category': category,
      'keyword': keywords,
      'imgurl': imageurl,
      'location': location,
      'price': price,
      'time': Timestamp.now(),
      'phoneNumber': await usersCollection
          .document(userid)
          .get()
          .then((value) => value.data['phoneNumber']),
      'whatsAppNumber': await usersCollection
          .document(userid)
          .get()
          .then((value) => value.data['phoneNumber'])
    });
  }

  // update user data
  Future updateUserData(String phoneNumber, String whatsAppNumber) async {
    return await usersCollection.document(uid).setData({
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
    });
  }

  // get posts from database
  Stream<QuerySnapshot> get thePosts {
    if (categoryValue != null && keyword != null && keyword.isNotEmpty) {
      return postsCollection
          .where('category', isEqualTo: categoryValue)
          .where('keyword', arrayContains: keyword)
          .orderBy('time', descending: true)
          .snapshots();
    } else if (categoryValue != null) {
      return postsCollection
          .where('category', isEqualTo: categoryValue)
          .orderBy('time', descending: true)
          .snapshots();
    } else if (keyword != null && keyword.isNotEmpty) {
      return postsCollection
          .where('keyword', arrayContains: keyword)
          .orderBy('time', descending: true)
          .snapshots();
    } else {
      return postsCollection.orderBy('time', descending: true).snapshots();
    }
  }
}
