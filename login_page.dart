import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usuario = TextEditingController();
  final password = TextEditingController();

  String usu = '';
  String pass = '';

  void ingresar(usuario, pass) async {
    try {
      var url = Uri.parse('https://vidaalasnaciones.com.mx/login_user.php');
      var response = await http.post(url, body: {
        'usu': usuario,
        'pass': pass,
      }).timeout(const Duration(seconds: 90));

      if (response.body == '1') {
        Navigator.pushNamed(context, '/checker_principal',
            arguments: {'usuario': usu, 'password': pass});

        FocusScope.of(context).unfocus();
      } else {
        print('Usuario Incorrecto');
      }
    } on TimeoutException catch (e) {
      print('Tardo Mucho la conexion');
    } on Error catch (e) {
      print('Http error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logochecker.png',
                height: 150.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              _userTextField(),
              SizedBox(
                height: 15,
              ),
              _passwordTextField(),
              SizedBox(
                height: 20.0,
              ),
              _bottomLogin(),
              SizedBox(
                height: 20.0,
              ),
              _TextField(),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 250, 179, 8),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            hintText: 'ejemplo@ejemplo.com',
            labelText: 'Correo Electronico',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.vpn_key),
            hintText: 'Contrasena',
            labelText: 'Contrasena',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  _bottomLogin() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text(
                'Iniciar Sesion',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10.0,
            color: Colors.teal[400],
            onPressed: () {
              usu = usuario.text;
              pass = password.text;

              if (usu == 'abi123' && pass == 'abi123') {
                ingresar(usu, pass);
              } else {}
            });
      },
    );
  }

  _TextField() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: Text(
            'Made in Reboot y TEAM AB',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              height: 2.0,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Segunda Pantall"),
    ));
  }
}
