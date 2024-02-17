import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository{
  CollectionReference<CategoryModel> categoryRef = FirebaseService.db.collection("genre")
      .withConverter<CategoryModel>(
    fromFirestore: (snapshot, _) {
      return CategoryModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
  Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if(!hasData){
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>>  getCategory(String categoryId) async {
    try{
      print(categoryId);
      final response = await categoryRef.doc(categoryId).get();
      return response;
    }catch(e){
      rethrow;
    }
  }

  List<CategoryModel> makeCategory() {
    return [
      CategoryModel(
          categoryName: "Dark Knight",
          status: "active",
          imageUrl: "https://wallpapercave.com/wp/ueXZuuo.jpg"),
      CategoryModel(
          categoryName: "Marvel Comics",
          status: "active",
          imageUrl:
              "https://i.pinimg.com/564x/e6/4b/80/e64b80f40cd9f3f79fb6f7427271aa8c.jpg"),
      CategoryModel(
          categoryName: "DC Comics",
          status: "active",
          imageUrl:
              "https://static1.cbrimages.com/wordpress/wp-content/uploads/2020/10/DC-Acquired-Heroes.jpg?q=50&fit=contain&w=1140&h=&dpr=1.5"),
      CategoryModel(
          categoryName: "Invincible",
          status: "active",
          imageUrl:
              "https://images.augustman.com/wp-content/uploads/sites/3/2023/07/19123802/invincible-comic-series.jpg?tr=w-1920"),
      CategoryModel(
          categoryName: "The Boys",
          status: "active",
          imageUrl:
              "https://m.media-amazon.com/images/I/61189R+UonL._SY445_SX342_.jpg"),
    ];
  }
}
