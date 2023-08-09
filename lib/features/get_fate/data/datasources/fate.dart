import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/fate_model.dart';

abstract class FateDataSource {
  Future<FateModel> getFate();
}

class FateDataSourceImpl implements FateDataSource {
  final Dio client;
  final Dio _dio = Dio();

  FateDataSourceImpl({required this.client});

  @override
  Future<FateModel> getFate() =>
      _getFateFromUrl('https://eightballapi.com/api');

  Future<FateModel> _getFateFromUrl(String url) async {
    Response userData = await _dio.get(url);

    if (userData.statusCode == 200) {
      return FateModel.fromJson(userData.data);
    } else {
      throw ServerException();
    }
  }
}
