import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel? productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel? data) => json.encode(data!.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.userId,
    this.categoryId,
    this.productName,
    this.productDescription,
    this.imageUrl,
    this.imagePath,
  });

  String? id;
  String? userId;
  String? categoryId;
  String? productName;
  String? productDescription;
  String? imageUrl;
  String? imagePath;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    userId: json["user_id"],
    categoryId: json["category_id"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    imageUrl: json["imageUrl"],
    imagePath: json["imagePath"],
  );



  factory ProductModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>> json) => ProductModel(
    id: json.id,
    userId: json["user_id"],
    categoryId: json["category_id"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    imageUrl: json["imageUrl"],
    imagePath: json["imagePath"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "category_id": categoryId,
    "productName": productName,
    "productDescription": productDescription,
    "imageUrl": imageUrl,
    "imagePath": imagePath,
  };
}
