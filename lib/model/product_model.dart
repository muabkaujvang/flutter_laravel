// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    int? id;
    String? name;
    String? imageUrl;
    String? price;
    String? originalPrice;
    String? rating;
    int? reviewCount;
    String? description;
    int? categoryId;
    DateTime? createdAt;
    DateTime? updatedAt;

    ProductModel({
        this.id,
        this.name,
        this.imageUrl,
        this.price,
        this.originalPrice,
        this.rating,
        this.reviewCount,
        this.description,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        price: json["price"],
        originalPrice: json["original_price"],
        rating: json["rating"],
        reviewCount: json["review_count"],
        description: json["description"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "price": price,
        "original_price": originalPrice,
        "rating": rating,
        "review_count": reviewCount,
        "description": description,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
