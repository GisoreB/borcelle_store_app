import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/user/user.dart';

class UserService{
  final String baseUrl = 'https://fakestoreapi.com';

  Future<User> displayUser() async{
    final url = '$baseUrl/users/1';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final jsonBody = json.decode(response.body);
        final user = User(
            id: jsonBody['id'],
            email: jsonBody['email'],
            username: jsonBody['username'],
            password: jsonBody['password'],
            name: jsonBody['name']['firstname'] + ' ' + jsonBody['name']['lastname'],
            firstname: jsonBody['name']['firstname'],
            lastname: jsonBody['name']['lastname'],
            address: '${jsonBody['address']['geolocation']['lat']}, ${jsonBody['address']['geolocation']['long']}',
            city: jsonBody['address']['city'],
            street: jsonBody['address']['street'],
            number: jsonBody['address']['number'],
            zipcode: jsonBody['address']['zipcode'],
            phone: jsonBody['phone']);

        return user;
      }else{
        throw Exception('Erro ao buscar dados da API');
      }
    }catch(e){throw Exception('Erro na requisição: $e');}
  }
}