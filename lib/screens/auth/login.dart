import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/dialog.dart';
import 'package:tizatech/services/message.dart';

import '../../_components/text_input.dart';
import '../../services/auth.dart';
import '../../shared/colors.dart';
import 'auth_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService authService = AuthService();

  /* String email = '24071291';

  String password = 'passuser'; */

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<AuthViewModel>(
        create: (_) => AuthViewModel(),
        builder: (BuildContext context, _) {
          AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
          return Scaffold(
            backgroundColor: secondaryColor,
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 48),
                        child: Image.asset(
                          'assets/logo/white.png',
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Iniciar Sesion',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      TextInput(
                        hintText: 'Correo',
                        labelText: 'Correo',
                        onChanged: (String value) =>
                            authViewModel.email = value,
                      ),
                      TextInput(
                        hintText: '',
                        labelText: 'Contraseña',
                        obscureText: true,
                        onChanged: (String value) =>
                            authViewModel.password = value,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Olvide mi Contraseña',
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    color: informationColor),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          onPressed: () => authViewModel.login(),
                          child: Text('Iniciar Sesion'),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
