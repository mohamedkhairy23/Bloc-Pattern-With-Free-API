import 'package:bloc_app/constants/constants.dart';
import 'package:bloc_app/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try{
      Response response = await dio.get('characters');
      printFullText(response.data.toString());
      return response.data;
    }catch(e){
      printFullText(e.toString());
      return[];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try{
      Response response = await dio.get('quote' , queryParameters: {"author" : charName});
      printFullText(response.data.toString());
      return response.data;
    }catch(e){
      printFullText(e.toString());
      return[];
    }
  }

}
