

import 'package:appmobile/model/category_response.dart';
import 'package:appmobile/repository/category_repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc {
  final CategoryRepository _repository = CategoryRepository();

  final BehaviorSubject<CategoryResponse> _subject =
      BehaviorSubject<CategoryResponse>();

  getCategory() async {
    CategoryResponse response = await _repository.getCategory();
    
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CategoryResponse> get subject => _subject;
  
}
final bloc = CategoryBloc();