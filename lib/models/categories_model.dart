// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesModel {
  final String categoryId;
  final String categoryImg;
  final String categoryName;
  final String categoryDescription;
  final dynamic createdAt;
  final dynamic updatedAt;

  CategoriesModel({
    required this.categoryId,
    required this.categoryImg,
    required this.categoryName,
    required this.categoryDescription,
    required this.createdAt,
    required this.updatedAt,
  });
  factory CategoriesModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return CategoriesModel(
      createdAt: snapshot['createdAt'],
      updatedAt: snapshot['updatedAt'],
      categoryId: snapshot.id,
      categoryName: snapshot['categoryName'],
      categoryImg: snapshot['categoryImg'],
      categoryDescription: snapshot['categoryDescription'],
    );
  }

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImg': categoryImg,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a UserModel instance from a JSON map
  factory CategoriesModel.fromMap(Map<String, dynamic> json) {
    return CategoriesModel(
      categoryDescription: json['categoryDescription'],
      categoryId: json['categoryId'],
      categoryImg: json['categoryImg'],
      categoryName: json['categoryName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
