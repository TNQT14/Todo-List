import 'package:todolist/model/category.dart';
import 'package:todolist/repositories/reponsitory.dart';

class CategoryService{
  saveCategory(Category category){
    late Reponsitory _reponsitory;

    CategoryService(){
      _reponsitory = Reponsitory();
    }

    saveCategory(Category category){
      return _reponsitory?.insertData('categories', category.categoryMap());
    }

    print(category.name);
    print(category.description);
  }
}
