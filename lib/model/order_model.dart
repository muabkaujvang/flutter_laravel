// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
    int? id;
    int? userId;
    String? totalAmount;
    String? province;
    String? district;
    String? village;
    DateTime? orderDate;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    List<OrderDetail>? orderDetails;

    OrderModel({
        this.id,
        this.userId,
        this.totalAmount,
        this.province,
        this.district,
        this.village,
        this.orderDate,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.orderDetails,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["user_id"],
        totalAmount: json["total_amount"],
        province: json["province"],
        district: json["district"],
        village: json["village"],
        orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        orderDetails: json["order_details"] == null ? [] : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "total_amount": totalAmount,
        "province": province,
        "district": district,
        "village": village,
        "order_date": orderDate?.toIso8601String(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
    };
}

class OrderDetail {
    int? id;
    int? orderId;
    int? productId;
    int? quantity;
    String? price;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;

    OrderDetail({
        this.id,
        this.orderId,
        this.productId,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
    };
}

class Product {
    int? id;
    String? name;
    String? imageUrl;
    String? price;
    String? originalPrice;
    String? rating;
    int? reviewCount;
    String? description;
    String? category;
    DateTime? createdAt;
    DateTime? updatedAt;

    Product({
        this.id,
        this.name,
        this.imageUrl,
        this.price,
        this.originalPrice,
        this.rating,
        this.reviewCount,
        this.description,
        this.category,
        this.createdAt,
        this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        price: json["price"],
        originalPrice: json["original_price"],
        rating: json["rating"],
        reviewCount: json["review_count"],
        description: json["description"],
        category: json["category"],
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
        "category": category,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class User {
    int? id;
    String? email;
    String? phonenumber;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.email,
        this.phonenumber,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phonenumber": phonenumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
