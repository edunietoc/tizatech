import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:tizatech/_components/button.dart';
import 'package:tizatech/shared/constants.dart';

import '../../../_components/app_bar.dart';
import '../../../_components/loader.dart';
import '../../../models/courses.dart';
import '../../../shared/colors.dart';
import 'verify_code_vm.dart';

class TeacherVerifyCodeScreen extends StatelessWidget {
  const TeacherVerifyCodeScreen({
    @required this.course,
    Key key,
  }) : super(key: key);
  final Courses course;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<TeacherVerifyCodeViewModel>(
        create: (_) => TeacherVerifyCodeViewModel(course),
        child: Scaffold(
          body: Consumer<TeacherVerifyCodeViewModel>(
            builder: (_, TeacherVerifyCodeViewModel viewModel, __) {
              switch (viewModel.currentStatus) {
                case Status.loading:
                  return Loader();

                case Status.error:
                  return Center(child: Text(viewModel.error));

                case Status.done:
                  return CustomScrollView(
                    slivers: <Widget>[
                      TizaAppBar(title: 'Verificacion de Codigo', subtitle: ''),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 32,
                                bottom: 24,
                              ),
                              child: Text(
                                'Ingresa el Código',
                                textAlign: TextAlign.center,
                                style: h3(context).copyWith(
                                  color: secondaryColor[80],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                'Ingresa el código de seguridad de seis dígito desde tu aplicación de autenticación.',
                                textAlign: TextAlign.center,
                                style: body1(context).copyWith(
                                  color: blackShadesColor[70],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 60,
                              ),
                              child: PinCodeTextField(
                                length: 6,
                                appContext: context,
                                cursorColor: primaryColor[80],
                                enableActiveFill: true,
                                backgroundColor: Colors.white,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  /* activeColor: blackShadesColor[10], */
                                  selectedColor: primaryColor[80],
                                  selectedFillColor: blackShadesColor[05],
                                  inactiveColor: blackShadesColor[10],
                                  inactiveFillColor: blackShadesColor[05],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  activeFillColor: blackShadesColor[05],
                                  activeColor: primaryColor[80],
                                ),
                                onChanged: (String value) =>
                                    viewModel.code = value,
                              ),
                            ),
                            Button(
                              onPressed: () => viewModel.verifyCode(),
                              text: 'Aceptar',
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      );
}
