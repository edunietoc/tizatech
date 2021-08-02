import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_components/app_bar.dart';
import '../../../../_components/loader.dart';
import '../../../../_components/report_bar_chart.dart';
import '../../../../shared/utils.dart';
import 'attendance_vm.dart';

class AttendanceChartScreen extends StatelessWidget {
  AttendanceChartScreen(this.attendanceType, {Key key}) : super(key: key);
  final AttendanceType attendanceType;

  final Map<AttendanceType, String> textType = {
    AttendanceType.attendance: 'Asistencias',
    AttendanceType.unattendance: 'Inasistencias',
    AttendanceType.delayment: 'Retrasos',
  };

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<AttendanceViewModel>(
        create: (_) => AttendanceViewModel(attendanceType),
        child: Scaffold(
          body: Consumer<AttendanceViewModel>(
              builder: (_, AttendanceViewModel viewModel, __) {
            String diaryText = attendanceType == AttendanceType.delayment
                ? 'Diarios'
                : 'Diarias';
            switch (viewModel.currentStatus) {
              case Status.loading:
                return Loader();

              case Status.error:
                return Text('error');

              case Status.done:
                return CustomScrollView(shrinkWrap: true, slivers: <Widget>[
                  TizaAppBar(
                      title: '${textType[attendanceType]}', subtitle: ''),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      ReportChart(
                        series: viewModel.getAnualSeries(),
                        title: 'Anuales',
                        subtitle: currentYear(),
                        xLabel: 'Porcentaje de ${textType[attendanceType]}',
                        yLabel: 'Meses',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getMonthSeries(),
                        title: 'Mensuales',
                        subtitle: currentMonth(),
                        xLabel:
                            'Porcentaje de ${textType[attendanceType]} Mensual',
                        yLabel: 'Cursos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDailySeries(),
                        title: 'Diarias',
                        subtitle: currentMonth(),
                        xLabel:
                            'Porcentaje de ${textType[attendanceType]} $diaryText',
                        yLabel: 'Cursos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getDailySeries(),
                        title: '$diaryText',
                        xLabel:
                            'Porcentaje de ${textType[attendanceType]} $diaryText',
                        yLabel: 'Cursos',
                        isVertical: false,
                      ),
                      ReportChart(
                        series: viewModel.getLevelSeries(),
                        title: 'Por Niveles',
                        xLabel: 'Número de ${textType[attendanceType]}',
                        yLabel: 'Niveles',
                        isVertical: false,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ]),
                  ),
                ]);
              default:
                return Container();
            }
          }),
        ),
      );
}
