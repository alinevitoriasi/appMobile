import 'package:appmobile/model/company_response.dart';
import 'package:appmobile/repository/company_repository.dart';
import 'package:rxdart/rxdart.dart';


class CompanyBloc {
  final CompanyRepository _repository = CompanyRepository();
  final BehaviorSubject<CompanyResponse> _subject =
      BehaviorSubject<CompanyResponse>();

  getCompany() async {
    CompanyResponse response = await _repository.getCompany();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CompanyResponse> get subject => _subject;
}

final bloc = CompanyBloc();
