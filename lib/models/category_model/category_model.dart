class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status=json["status"];
    data= CategoriesDataModel.fromJson(json["data"]);
  }
}

class CategoriesDataModel{
  late int currentPage;
  List<DataModelOfCategory> dataModel=[];

  CategoriesDataModel.fromJson(Map<String ,dynamic> json){
    currentPage=json["current_page"];
    json["data"].forEach((element){
      dataModel.add(DataModelOfCategory.fromJson(element));
    });
  }
}

class DataModelOfCategory{
  late int id;
  late String name;
  late String image;
  DataModelOfCategory.fromJson(Map<String,dynamic> json)
  {
    id=json["id"];
    name=json["name"];
    image=json["image"];

  }


}