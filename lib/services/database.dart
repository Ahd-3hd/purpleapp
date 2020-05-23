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

  // update user data
  Future updateUserData(String phoneNumber, String whatsAppNumber) async {
    return await usersCollection.document(uid).setData({
      'username': 'this is a test username',
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
    });
  }

  Future getUser(String useruid) async {
    dynamic username = await usersCollection
        .document(useruid)
        .get()
        .then((value) => value.data['username']);
    return username;
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
