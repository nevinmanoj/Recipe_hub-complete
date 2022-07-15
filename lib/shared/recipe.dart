// ignore: camel_case_types
class recipes{

  int Calories;
  String Cuisine;
  String Time="";
  String Title="";
  String img="";
  bool isveg;
  List <String> Preparation=[];
  Map <String,String> ingredients =Map();

  recipes({required this.Calories,required this.Cuisine,required this.Time,required this.Title,
  required this.img,required this.Preparation,required this.ingredients,required this.isveg});

}

