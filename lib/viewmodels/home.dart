class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  factory BannerItem.formJSON(Map<String, dynamic> json) {
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

class CategoryItem {
  String name;
  String id;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.name,
    required this.id,
    required this.picture,
    this.children,
  });

  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    return CategoryItem(
      name: json["name"] ?? "",
      id: json["id"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List)
                .map((e) => CategoryItem.formJSON(e as Map<String, dynamic>))
                .toList(),
    );
  }
}

class SpecialRecommendItem {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialRecommendItem({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecialRecommendItem.formJSON(Map<String, dynamic> json) {
    return SpecialRecommendItem(
      id: json["id"].toString() ?? "",
      title: json["title"].toString() ?? "",
      subTypes: (json["subTypes"] as List? ?? [])
          .map((item) => SubType.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.formJSON(Map<String, dynamic> json) {
    return SubType(
      id: json["id"].toString() ?? "",
      title: json["title"].toString() ?? "",
      goodsItems: GoodsItems.formJSON(
        json["goodsItems"] as Map<String, dynamic>,
      ),
    );
  }
}

class GoodsItems {
  int count;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.count,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.formJSON(Map<String, dynamic> json) {
    return GoodsItems(
      count: int.tryParse(json["count"].toString()??"0") ?? 0,
      pageSize: int.tryParse(json["pageSize"].toString()??"0") ?? 0,
      pages: int.tryParse(json["pages"].toString()??"0") ?? 0,
      page: int.tryParse(json["page"].toString()??"0") ?? 0,
      items: (json["items"] as List? ?? [])
          .map((item) => GoodsItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.formJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"] ?? "",
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;
 
  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}