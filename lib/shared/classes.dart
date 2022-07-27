// ignore: camel_case_types
class recipeModel{

  bool isLike;
  String RecipeId;
  int calories;
  String cuisine;
  String time;
  String title;
  String img;
  bool isveg;
  List preparation=[];
  Map <String,dynamic> ingredients =Map();

  recipeModel({required this.calories,required this.cuisine,required this.time,required this.title,required this.RecipeId,
  required this.img,required this.preparation,required this.ingredients,required this.isveg,required this.isLike});

}

class Item{
  
  String name;
  double qty;
  String unit;
  String category;

  Item({required this.name,required this.qty,required this.unit,required this.category});


}

