import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purple/ohservices/auth.dart';

class DatabaseSerivce {
  //collection reference
  String categoryValue;
  String keyword;
  DatabaseSerivce({this.categoryValue, this.keyword});
  final CollectionReference postsCollection =
      Firestore.instance.collection('posts');
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
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

  // get user data

  Future getUser(String useruid) async {
    dynamic userData = await usersCollection
        .document(useruid)
        .get()
        .then((value) => value.data);
    return userData;
  }

  // create post

  Future createPost(
      String userid,
      String title,
      String desc,
      String category,
      List keywords,
      String imageurl,
      String location,
      String price,
      String phoneNumber,
      String whatsAppNumber) async {
    await postsCollection.document().setData({
      'userid': userid,
      'title': title,
      'desc': desc,
      'category': category,
      'keyword': keywords,
      'imgurl': imageurl,
      'location': location,
      'price': price,
      'time': Timestamp.now(),
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'comments': []
    });
  }

  // update user data on sign up

  Future updateUserData(String userid, String phoneNumber,
      String whatsAppNumber, String userEmail) async {
    return await usersCollection.document(userid).setData({
      'username': 'Unknown',
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'location': 'Unknown',
      'email': userEmail,
      'comments': [],
      'avatar': 'default.jpg'
    });
  }

  Future commentOnPost(String userid, String docid, String commentText) async {
    List comments = await postsCollection
        .document(docid)
        .get()
        .then((value) => value.data['comments']);
    comments.insert(0, {'comment': commentText, 'userid': userid});
    return await postsCollection
        .document(docid)
        .updateData({'comments': comments});
  }
}
