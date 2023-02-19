class FavoritesModel
{
  bool? status;
  String? message;
  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
   int? currentPage;
   List<FavoritesData> data=[];
   String? firstPageUrl;
   int? from;
   int? lastPage;
   String? lastPageUrl;
   String? path;
   int? perPage;
   int? to;
   int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new FavoritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
   int? id;
   Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product'] != null) {
      product = Product.fromJson(json['product']);
    }
  }
}

class Product {
   int? id;
   dynamic? price;
   dynamic? oldPrice;
   int? discount;
   String? image;
   String? name;
   String? description;

  Product(
      {required this.id,
        this.price,
        this.oldPrice,
        required this.discount,
        required this.image,
        required this.name,
        required this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}