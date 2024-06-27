import 'package:flutter/material.dart';
import '../../../controllers/userController/userController.dart';
import '../../../models/user/user.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final UserController _controller = UserController();
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = null;
    _loadUser();
  }

  void _loadUser() async {
    _user = await _controller.displayUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null ? SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 195, right: 10, left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: Column(
                  children: [
                    _userInfo(_user!.name, 'Name: ', Icons.account_circle),
                    _userInfo(_user!.email, 'E-mail: ',  Icons.email),
                    _userInfo(_user!.phone, 'Telephone: ',  Icons.phone),
                    _userInfo(_user!.username, 'User: ',  Icons.manage_accounts),
                    _userInfo(_user!.firstname, 'First name: ',  Icons.account_box),
                    _userInfo(_user!.lastname, 'Last name: ',  Icons.account_box),
                    _userInfo(_user!.city, 'City: ',  Icons.location_city),
                    _userInfo(_user!.street, 'Neighborhood: ',  Icons.streetview),
                    _userInfo(_user!.number.toString(), 'Number: ',  Icons.numbers),
                    _userInfo(_user!.zipcode, 'AreaCode: ',  Icons.park_outlined)
                  ],
                ),
              ),
            ),
            Positioned(
              top: 27,
              child: ClipOval(
                child: Image.asset("assets/icons/user.png", fit: BoxFit.cover, width: 200),
              ),
            ),
          ],
        ),
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _userInfo(String? info, String? labelText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10, bottom: 5, top: 10),
      child: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: (MediaQuery.of(context).size.width) - 80,
              child: TextField(
                controller: TextEditingController(text: info),
                style: const TextStyle(fontSize: 16),
                enabled: false,
                decoration: InputDecoration(
                  labelText: labelText,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}