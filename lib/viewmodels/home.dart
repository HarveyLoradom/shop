class BannerItem{
  String id;
  String imgUrl;
  BannerItem({required this.id,required this.imgUrl});

  factory BannerItem.formJSON(Map<String,dynamic> json){
    return BannerItem(
      id: json["id"]??"",
      imgUrl: json["imgUrl"]??""
    );
  }
} 

class CategoryItem{
  String name;
  String id;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({required this.name,required this.id,required this.picture,this.children}); 

  factory CategoryItem.formJSON(Map<String,dynamic> json){
    return CategoryItem(
      name: json["name"]??"",
      id: json["id"]??"",
      picture: json["picture"]??"",
      children: json["children"]==null?null:(json["children"] as List).map((e)=>CategoryItem.formJSON(e as Map<String, dynamic>)).toList()
    );
  }
} 


