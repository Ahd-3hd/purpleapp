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
          .then((value) => value.data['phoneNumber']),
      'comments': [],
    });
  }

  Future createComment(String userid, String docid, String comment) async {
    List comments = await postsCollection
        .document(docid)
        .get()
        .then((value) => value.data['comments']);
    comments.add({'comment': comment, 'username': await getUser(userid)});
    return await postsCollection
        .document(docid)
        .updateData({'comments': comments});
  }

  Future profileComment(
      String commentoruid, String comment, String useruid) async {
    List comments = await usersCollection
        .document(useruid)
        .get()
        .then((value) => value.data['comments']);
    comments.add({'comment': comment, 'username': await getUser(commentoruid)});
    return await usersCollection
        .document(useruid)
        .updateData({'comments': comments});
  }

  // update user data
  Future updateUserData(String phoneNumber, String whatsAppNumber) async {
    return await usersCollection.document(uid).setData({
      'username': 'Unknown',
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'location': 'Unknown',
      'email': 'Unknown',
      'comments': [],
      'avatar':
          'https://firebasestorage.googleapis.com/v0/b/purple-aa6da.appspot.com/o/icon.png?alt=media&token=c4ebe948-7e46-4f12-b625-f0b153bc9f3a'
    });
  }

  // update user profile data
  Future updateUserProfileData(
      String phoneNumber,
      String whatsAppNumber,
      String username,
      String email,
      String whatsapp,
      String location,
      String useruid) async {
    return await usersCollection.document(useruid).updateData({
      'username': username,
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'location': location,
      'email': email,
    });
  }

  Future updateUserProfileImage(String useruid, String imgurl) async {
    return await usersCollection
        .document(useruid)
        .updateData({'avatar': imgurl});
  }

  Future getUser(String useruid) async {
    dynamic username = await usersCollection
        .document(useruid)
        .get()
        .then((value) => value.data['username']);
    return username;
  }

  Future getUserForProfile(String useruid) async {
    dynamic userData = await usersCollection
        .document(useruid)
        .get()
        .then((value) => value.data);
    return userData;
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
