import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_components/app_bar.dart';
import '../../shared/colors.dart';
import '../../shared/constants.dart';
import 'notifications_vm.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<NotificationsViewModel>(
        create: (_) => NotificationsViewModel(),
        builder: (context, child) => Consumer<NotificationsViewModel>(
          builder: (context, NotificationsViewModel viewModel, child) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  TizaAppBar(title: 'Notificaciones', subtitle: 'alumno'),
                  SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'En esta sección puedes activar o descativar las notificaciones.',
                            style: body2(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Activar',
                                style: body1(),
                              ),
                              Switch(
                                  value: viewModel.notificationsEnabled,
                                  activeColor: primaryColor,
                                  onChanged: (_) =>
                                      viewModel.toggleNotifications())
                            ],
                          ),
                          Text(
                            'Aviso de mensajes, notas, actualizaciónes de asistencias, atrasos y lecturas anuales.',
                            style:
                                body2().copyWith(color: blackShadesColor[30]),
                          )
                        ],
                      ),
                    )
                  ])),
                ],
              ),
            );
          },
        ),
      );
}
