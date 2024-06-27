import '../../../models/user/user.dart';
import '../../../services/user/user.dart';

class UserController{
  final UserService _service = UserService();

  Future<User> displayUser() async{
    try{
      final user = await _service.displayUser();
      return user;
    }catch(e){
      throw Exception('Error $e');
    }
  }
}