import 'package:todolist/model/category.dart';
import 'package:todolist/repositories/reponsitory.dart';

class CategoryService{
    late Reponsitory _reponsitory;

    CategoryService(){
      _reponsitory = Reponsitory();
    }

    saveCategory(Category category) async{
      print('Category id: ${category.id}');
      print('Category name: ${category.name}');
      print('Category description: ${category.description}');
      return await _reponsitory.insertData('categories', category.categoryMap());
    }

    readCategories() async{
      return await _reponsitory.readData('categories');
    }

  readCategoyById(categoryId) async{
      return await _reponsitory.readDataById('categories',categoryId);
  }

  updateCategory(Category category) async{
    return await _reponsitory.updateData('categories',category.categoryMap());
  }

  deleteCategory(categoryId) async{
    return await _reponsitory.deleteData('categories',categoryId);
  }
}
