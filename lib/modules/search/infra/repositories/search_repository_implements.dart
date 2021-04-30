import 'package:github_search/modules/search/domain/errors/errors.dart';
import 'package:github_search/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:github_search/modules/search/domain/repositories/search_repository.dart';
import 'package:github_search/modules/search/infra/datasource/search_datasource.dart';

class SearRespositoryimplementation implements SearchRepository {
  final SearchDatasource datasource;

  SearRespositoryimplementation(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
