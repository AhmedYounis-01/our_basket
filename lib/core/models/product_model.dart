class ProductModel {
  final String productId;
  final DateTime createdAt;
  final String productName;
  final String price;
  final String oldPrice;
  final String sale;
  final String description;
  final String category;
  final String imageUrl;
  final List<FavoriteProduct> favoriteProducts;
  final List<PurchaseProducts> purchase;

  ProductModel({
    required this.productId,
    required this.createdAt,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.sale,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.favoriteProducts,
    required this.purchase,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'],
      createdAt: DateTime.parse(json['created_at']),
      productName: json['product_name'],
      price: json['price'],
      oldPrice: json['old_price'],
      sale: json['sale'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['image_url'],
      favoriteProducts:
          (json['favorite_products'] as List<dynamic>?)
              ?.map((e) => FavoriteProduct.fromJson(e))
              .toList() ??
          [],
      purchase:
          (json['purchase'] as List<dynamic>?)
              ?.map((e) => PurchaseProducts.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'created_at': createdAt.toIso8601String(),
      'product_name': productName,
      'price': price,
      'old_price': oldPrice,
      'sale': sale,
      'description': description,
      'category': category,
      'image_url': imageUrl,
      'favorite_products': favoriteProducts.map((e) => e.toJson()).toList(),
      'purchase': purchase.map((e) => e.toJson()).toList(),
    };
  }
}

class FavoriteProduct {
  final String id;
  final String forUsers;
  final DateTime createdAt;
  final bool isFavorite;
  final String forProducts;

  FavoriteProduct({
    required this.id,
    required this.forUsers,
    required this.createdAt,
    required this.isFavorite,
    required this.forProducts,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      id: json['id'],
      forUsers: json['for_users'],
      createdAt: DateTime.parse(json['created_at']),
      isFavorite: json['is_favorite'],
      forProducts: json['for_products'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'for_users': forUsers,
      'created_at': createdAt.toIso8601String(),
      'is_favorite': isFavorite,
      'for_products': forProducts,
    };
  }
}

class PurchaseProducts {
  final String id;
  final String forUsers;
  final bool isBought;
  final DateTime createdAt;
  final String forProducts;

  PurchaseProducts({
    required this.id,
    required this.forUsers,
    required this.isBought,
    required this.createdAt,
    required this.forProducts,
  });

  factory PurchaseProducts.fromJson(Map<String, dynamic> json) {
    return PurchaseProducts(
      id: json['id'],
      forUsers: json['for_users'],
      isBought: json['is_bought'],
      createdAt: DateTime.parse(json['created_at']),
      forProducts: json['for_products'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'for_users': forUsers,
      'is_bought': isBought,
      'created_at': createdAt.toIso8601String(),
      'for_products': forProducts,
    };
  }
}
